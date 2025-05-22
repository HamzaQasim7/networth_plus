import 'package:finance_tracker/core/utils/helpers.dart';
import 'package:finance_tracker/core/utils/motion_toast.dart';
import 'package:finance_tracker/generated/l10n.dart';
import 'package:finance_tracker/widgets/app_header_text.dart';
import 'package:finance_tracker/widgets/shared_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/account_card_viewmodel.dart';
import '../../../data/models/account_card_model.dart';
import 'add_card_sheet.dart';

class CardDetailsScreen extends StatelessWidget {
  final AccountCardModel card;

  const CardDetailsScreen({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: SharedAppbar(
        title: card.name,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.edit_2_bold),
            onPressed: () => _editCard(context),
          ),
          IconButton(
            icon: const Icon(Iconsax.card_remove_1_bold),
            onPressed: () => _deleteCard(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardPreview(),
            _buildCardDetails(context),
            // _buildRecentTransactions(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardPreview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: card.color.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(card.icon, color: card.color),
              Text(
                card.type,
                style: TextStyle(
                  color: card.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            card.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            card.number,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '₹${card.balance.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardDetails(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeaderText(
              text: AppLocalizations.of(context).cardDetails, fontSize: 20),
          const SizedBox(height: 16),
          _buildDetailRow(localizations.typeLabel, card.type),
          _buildDetailRow(localizations.name, card.name),
          _buildDetailRow(localizations.number, card.number),
          _buildDetailRow(localizations.balanceLabel,
              '${Helpers.storeCurrency(context)}${card.balance.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Transactions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildTransactionItem(context);
          },
        ),
      ],
    );
  }

  Widget _buildTransactionItem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.swap_horiz,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transfer to Savings',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'May 15, 2024',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const Text(
            '- ₹5,000.00',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _editCard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCardSheet(
        card: card,
        isEditing: true,
      ),
    );
  }

  void _deleteCard(BuildContext context) {
    final viewModel = context.read<AccountCardViewModel>();
    final localizations = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(localizations.deleteCard),
        content: Text(localizations.areYouSureYouWantToDeleteThisCard),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () async {
              // First pop the dialog
              Navigator.pop(dialogContext);

              try {
                // Delete the card
                await viewModel.deleteAccountCard(card.id);

                // Check if the widget is still mounted before showing toast and popping
                if (context.mounted) {
                  // Show success toast
                  ToastUtils.showSuccessToast(context,
                      title: localizations.deleted,
                      description: localizations.cardDeletedSuccessfully);

                  // Pop the card details screen
                  Navigator.pop(context);
                }
              } catch (e) {
                if (context.mounted) {
                  ToastUtils.showErrorToast(context,
                      title: localizations.error,
                      description: 'Failed to delete card: ${e.toString()}');
                }
              }
            },
            child: Text(
              localizations.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
