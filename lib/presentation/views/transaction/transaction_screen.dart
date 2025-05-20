import 'package:finance_tracker/presentation/views/transaction/widgets/report_transaction_tab.dart';
import 'package:finance_tracker/presentation/views/transaction/widgets/settle_up_view_tab.dart';
import 'package:finance_tracker/presentation/views/transaction/widgets/transaction_monthly_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/theme_constants.dart';
import '../../../generated/l10n.dart';
import '../../../viewmodels/transaction_viewmodel.dart';
import '../../../widgets/summary_card_widget.dart';
import 'widgets/transactions_tab.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

// Change the enum definition to be outside the state class
enum FilterOption { categories, dates, amounts }

class _TransactionScreenState extends State<TransactionScreen> {
  DateTime _focusedDay = DateTime.now();
  int _selectedTabIndex = 0;

  late List<String> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      AppLocalizations.of(context).transactionsTitle,
      AppLocalizations.of(context).report,
      AppLocalizations.of(context).settleUp
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TransactionViewModel>()
          .loadTransactionsForMonth(_focusedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      body: Column(
        children: [
          TransactionMonthSelector(
            focusedDay: _focusedDay,
            onMonthChanged: (newDate) {
              setState(() => _focusedDay = newDate);
              context
                  .read<TransactionViewModel>()
                  .loadTransactionsForMonth(newDate);
            },
          ),
          // Summary Cards
          Consumer<TransactionViewModel>(
            builder: (context, viewModel, _) {
              final monthlyStats = viewModel.getMonthlyStatistics();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: SummaryCardWidget(
                        title: localization.incomeLabel,
                        amount: viewModel.totalIncome.toString(),
                        textColor: Colors.green,
                      ),
                    ),
                    Expanded(
                      child: SummaryCardWidget(
                        title: localization.expenseLabel,
                        amount: viewModel.totalExpense.toString(),
                        textColor: Colors.red,
                      ),
                    ),
                    Expanded(
                      child: SummaryCardWidget(
                        title: localization.available,
                        amount: viewModel.availableBalance.toString(),
                        textColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // Tab buttons
          _buildTabButtons(),
          // Content
          Expanded(
            child: _selectedTabIndex == 0
                ? const TransactionsTab()
                : _selectedTabIndex == 1
                    ? const ReportTransactionTab()
                    : const SettleUpViewTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButtons() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: _tabs.asMap().entries.map((entry) {
          final isSelected = _selectedTabIndex == entry.key;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedTabIndex = entry.key;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).brightness == Brightness.dark
                          ? ThemeConstants.surfaceDark
                          : Colors.white,
                  foregroundColor: isSelected
                      ? Colors.white
                      : Theme.of(context).brightness == Brightness.dark
                          ? ThemeConstants.textPrimaryDark
                          : ThemeConstants.textPrimaryLight,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[700]!
                              : Colors.grey[300]!,
                    ),
                  ),
                ),
                child: Text(
                  entry.value,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).brightness == Brightness.dark
                                ? ThemeConstants.textPrimaryDark
                                : ThemeConstants.textPrimaryLight,
                      ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
