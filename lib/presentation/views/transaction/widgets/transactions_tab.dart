import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../viewmodels/transaction_viewmodel.dart';
import '../../../../data/models/transaction_model.dart';
import '../../dashboard/add_transaction_sheet.dart';
import '../../../../widgets/transaction_item.dart';
import '../../../../core/utils/motion_toast.dart';

class TransactionsTab extends StatefulWidget {
  const TransactionsTab({super.key});

  @override
  State<TransactionsTab> createState() => _TransactionsTabState();
}

class _TransactionsTabState extends State<TransactionsTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTransactions();
    });
  }

  void _loadTransactions() {
    final viewModel = context.read<TransactionViewModel>();
    if (!viewModel.isLoading) {
      viewModel.loadTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ToastUtils.showErrorToast(
              context,
              title: 'Error',
              description: viewModel.error!,
            );
            viewModel.clearError();
          });
        }

        return _buildContent(viewModel);
      },
    );
  }

  Widget _buildContent(TransactionViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.transactions.isEmpty) {
      return const Center(child: Text('No transactions found'));
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.loadTransactions(),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: viewModel.transactions.length,
        separatorBuilder: (context, index) => Divider(
          height: 0.1,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]
              : Colors.grey[200],
        ),
        itemBuilder: (context, index) {
          final transaction = viewModel.transactions[index];
          return _buildTransactionItem(context, transaction, viewModel);
        },
      ),
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    TransactionModel transaction,
    TransactionViewModel viewModel,
  ) {
    return InkWell(
      onTap: () => _showTransactionDetails(context, transaction, viewModel),
      child: TransactionItem(
        date: transaction.date,
        categoryIcon: _getIconForCategory(transaction.category),
        title: transaction.category,
        description: _buildDescription(transaction),
        amount: transaction.amount,
        isExpense: transaction.type == TransactionType.expense,
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    // Implement your category-to-icon mapping
    return Icons.receipt;
  }

  String _buildDescription(TransactionModel transaction) {
    String description = transaction.paymentMethod;
    if (transaction.description.isNotEmpty) {
      description += ' - ${transaction.description}';
    }
    return description;
  }

  void _showTransactionDetails(
    BuildContext context,
    TransactionModel transaction,
    TransactionViewModel viewModel,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction Details',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Gap(24),
            _buildDetailRow('Category', transaction.category),
            _buildDetailRow(
                'Amount', '₹${transaction.amount.toStringAsFixed(2)}'),
            _buildDetailRow(
                'Date', DateFormat('MMM d, yyyy').format(transaction.date)),
            _buildDetailRow('Payment Method', transaction.paymentMethod),
            if (transaction.description.isNotEmpty)
              _buildDetailRow('Settlement', transaction.description),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.edit,
                  label: 'Edit',
                  onPressed: () =>
                      _editTransaction(context, transaction, viewModel),
                ),
                _buildActionButton(
                  context,
                  icon: Icons.delete,
                  label: 'Delete',
                  color: Colors.red,
                  onPressed: () =>
                      _deleteTransaction(context, transaction.id, viewModel),
                ),
              ],
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    Color? color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
    );
  }

  Future<void> _editTransaction(
    BuildContext context,
    TransactionModel transaction,
    TransactionViewModel viewModel,
  ) async {
    Navigator.pop(context);
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddTransactionSheet(
        isEditing: true,
        transaction: transaction,
        onSave: (updatedTransaction) async {
          final success = await viewModel.updateTransaction(updatedTransaction);
          if (success && context.mounted) {
            ToastUtils.showSuccessToast(
              context,
              title: 'Success',
              description: 'Transaction updated successfully',
            );
          }
        },
      ),
    );
  }

  Future<void> _deleteTransaction(
    BuildContext context,
    String transactionId,
    TransactionViewModel viewModel,
  ) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Delete Transaction'),
        content:
            const Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await viewModel.deleteTransaction(transactionId);
              if (success && context.mounted) {
                ToastUtils.showSuccessToast(
                  context,
                  title: 'Success',
                  description: 'Transaction deleted successfully',
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
