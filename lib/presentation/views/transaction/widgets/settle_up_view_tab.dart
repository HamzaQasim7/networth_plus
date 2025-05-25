import 'package:finance_tracker/core/constants/console.dart';
import 'package:finance_tracker/core/utils/helpers.dart';
import 'package:finance_tracker/data/models/settlement_model.dart';
import 'package:finance_tracker/generated/l10n.dart';
import 'package:finance_tracker/viewmodels/settlement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/helper_utils.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../../../widgets/custom_text_field.dart';
import '../../../../core/utils/motion_toast.dart';
import '../../../../widgets/custom_loader.dart';

class SettleUpViewTab extends StatefulWidget {
  const SettleUpViewTab({super.key});

  @override
  State<StatefulWidget> createState() => _SettleUpViewTabState();
}

class _SettleUpViewTabState extends State<SettleUpViewTab> {
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  Future<void> _loadInitialData() async {
    final viewModel = context.read<SettlementViewModel>();
    if (_isInitialLoad && !viewModel.isLoading) {
      await viewModel.reLoadSettlement();
      _isInitialLoad = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.watch<SettlementViewModel>();

    // Only show error if it's new
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
    final local = AppLocalizations.of(context);
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () => _showAddSettlementDialog(context),
                icon: const Icon(Icons.add),
                label: Text(local.addNewSettlement),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                ),
              ),
            ),
            if (viewModel.settlements.isEmpty && !viewModel.isLoading)
              Expanded(
                child: Center(child: Text(local.noSettlementsFound)),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: viewModel.settlements.length,
                  itemBuilder: (context, index) {
                    final settlement = viewModel.settlements[index];
                    return _buildDismissibleSettlementCard(settlement, context);
                  },
                ),
              ),
          ],
        ),
        if (viewModel.isLoading) const CustomLoadingOverlay(),
      ],
    );
  }

  Widget _buildDismissibleSettlementCard(
      SettlementModel settlement, BuildContext context) {
    final local = AppLocalizations.of(context);
    return Dismissible(
      key: Key(settlement.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(local.deleteSettlement),
              content: Text(local.confirmDeleteSettlement),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(local.cancelButton),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(local.delete),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        final viewModel = context.read<SettlementViewModel>();
        viewModel.deleteSettlement(settlement.id);
        ToastUtils.showSuccessToast(context,
            title: local.deleted,
            description: local.settlementDeletedSuccessfully);
      },
      child: _buildSettlementCard(settlement, context),
    );
  }

  Widget _buildSettlementCard(
      SettlementModel settlement, BuildContext context) {
    final local = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(settlement.title[0]),
        ),
        title: Text(settlement.title),
        subtitle: Text(
          settlement.isOwed ? local.youOwe : local.owesYou,
          style: TextStyle(
            color: settlement.isOwed ? Colors.red : Colors.green,
          ),
        ),
        trailing: Text(
          '${Helpers.storeCurrency(context)}${settlement.amount.toStringAsFixed(2)}',
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
    final local = AppLocalizations.of(context);

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      local.addNewSettlement,
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
                    keyboardType: TextInputType.text,
                    labelText: local.personName,
                    icon: Icons.person_outline),
                const Gap(16),
                CustomTextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  labelText: local.amountLabel,
                  icon: Icons.currency_rupee,
                ),
                const Gap(16),
                Row(
                  children: [
                    Expanded(
                      child: _buildChip(
                        label: local.theyOweMe,
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
                        label: local.iOweThem,
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
                    if (nameController.text.isEmpty) {
                      ToastUtils.showErrorToast(
                        context,
                        title: local.invalidInput,
                        description: local.pleaseEnterAName,
                      );
                      return;
                    }

                    final amountText =
                        amountController.text.replaceAll(',', '.');
                    final amount = double.tryParse(amountText);

                    if (amount == null || amount <= 0) {
                      ToastUtils.showErrorToast(
                        context,
                        title: local.invalidAmount,
                        description: local.pleaseEnterAValidNumber,
                      );
                      return;
                    }

                    final success = await viewModel.addSettlement(
                      title: nameController.text,
                      amount: amount,
                      isOwed: isYouOwe,
                      participants: [],
                    );

                    if (success && context.mounted) {
                      ToastUtils.showSuccessToast(
                        context,
                        title: local.success,
                        description: local.settlementAddedSuccessfully,
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: Text(local.addSettlement),
                ),
                const Gap(16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSettlementDetails(
      SettlementModel settlement, BuildContext context) {
    final viewModel = context.read<SettlementViewModel>();
    final local = AppLocalizations.of(context);

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
                  ? '${local.youOwe} ${settlement.title}'
                  : '${settlement.title} ${local.owesYou}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(16),
            Text(
              '${Helpers.storeCurrency(context)}${settlement.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: settlement.isOwed ? Colors.red : Colors.green,
                  ),
            ),
            const Gap(24),
            Text(
              '${local.relatedTransactions}:',
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
                      title: local.success,
                      description: settlement.isOwed
                          ? local.paymentMarkedAsCompleted
                          : local.reminderSentSuccessfully,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  settlement.isOwed ? local.payNow : local.remind,
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
