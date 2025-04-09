import 'package:finance_tracker/data/models/settlement_model.dart';
import 'package:finance_tracker/viewmodels/settlement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/custom_text_field.dart';
import '../../../../core/utils/motion_toast.dart';
import '../../../../widgets/custom_loader.dart';

class SettleUpViewTab extends StatefulWidget {
  const SettleUpViewTab({super.key});

  @override
  State<StatefulWidget> createState() => _SettleUpViewTabState();
}

class _SettleUpViewTabState extends State<SettleUpViewTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.watch<SettlementViewModel>();
    if (viewModel.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ToastUtils.showErrorToast(
          context,
          title: 'Operation Failed',
          description: viewModel.error!,
        );
        viewModel.clearError();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettlementViewModel>();

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () => _showAddSettlementDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Add New Settlement'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                ),
              ),
            ),
            if (viewModel.settlements.isEmpty && !viewModel.isLoading)
              const Expanded(
                child: Center(child: Text('No settlements found')),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: viewModel.settlements.length,
                  itemBuilder: (context, index) {
                    final settlement = viewModel.settlements[index];
                    return _buildSettlementCard(settlement, context);
                  },
                ),
              ),
          ],
        ),
        if (viewModel.isLoading) const CustomLoadingOverlay(),
      ],
    );
  }

  Widget _buildSettlementCard(
      SettlementModel settlement, BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(settlement.title[0]),
        ),
        title: Text(settlement.title),
        subtitle: Text(
          settlement.isOwed ? 'You owe' : 'Owes you',
          style: TextStyle(
            color: settlement.isOwed ? Colors.red : Colors.green,
          ),
        ),
        trailing: Text(
          '₹${settlement.amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: settlement.isOwed ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => _showSettlementDetails(settlement, context),
      ),
    );
  }

  void _showAddSettlementDialog(BuildContext context) {
    final viewModel = context.read<SettlementViewModel>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    bool isYouOwe = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Settlement',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Gap(24),
              CustomTextField(
                  controller: nameController,
                  labelText: 'Person Name',
                  icon: Icons.person_outline),
              const Gap(16),
              CustomTextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                labelText: "Amount",
                icon: Icons.currency_rupee,
              ),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                    child: _buildChip(
                      label: 'They Owe Me',
                      isSelected: !isYouOwe,
                      onSelected: (selected) {
                        setState(() => isYouOwe = !selected);
                      },
                      selectedColor: Colors.green.withOpacity(0.2),
                      labelColor: !isYouOwe ? Colors.green : null,
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: _buildChip(
                      label: 'I Owe Them',
                      isSelected: isYouOwe,
                      onSelected: (selected) {
                        setState(() => isYouOwe = selected);
                      },
                      selectedColor: Colors.red.withOpacity(0.2),
                      labelColor: isYouOwe ? Colors.red : null,
                    ),
                  ),
                ],
              ),
              const Gap(24),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isNotEmpty &&
                      amountController.text.isNotEmpty) {
                    final success = await viewModel.addSettlement(
                      title: nameController.text,
                      amount: double.parse(amountController.text),
                      isOwed: isYouOwe,
                      participants: [],
                    );

                    if (success && context.mounted) {
                      ToastUtils.showSuccessToast(
                        context,
                        title: 'Success',
                        description: 'Settlement added successfully',
                      );
                      Navigator.pop(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text('Add Settlement'),
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettlementDetails(
      SettlementModel settlement, BuildContext context) {
    final viewModel = context.read<SettlementViewModel>();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              settlement.isOwed
                  ? 'You owe ${settlement.title}'
                  : '${settlement.title} owes you',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(16),
            Text(
              '₹${settlement.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: settlement.isOwed ? Colors.red : Colors.green,
                  ),
            ),
            const Gap(24),
            Text(
              'Related Transactions:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            ...settlement.relatedTransactions.map((t) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(t),
                )),
            const Gap(24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await viewModel.markAsPaid(settlement.id);
                  if (context.mounted) {
                    ToastUtils.showSuccessToast(
                      context,
                      title: 'Success',
                      description: settlement.isOwed
                          ? 'Payment marked as completed'
                          : 'Reminder sent successfully',
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  settlement.isOwed ? 'Pay Now' : 'Remind',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required ValueChanged<bool> onSelected,
    Color selectedColor = Colors.green,
    Color? labelColor,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: selectedColor.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? labelColor : null,
      ),
    );
  }
}
