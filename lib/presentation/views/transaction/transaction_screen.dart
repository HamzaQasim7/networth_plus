import 'package:finance_tracker/presentation/views/transaction/widgets/report_transaction_tab.dart';
import 'package:finance_tracker/presentation/views/transaction/widgets/settle_up_view_tab.dart';
import 'package:finance_tracker/widgets/summary_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/theme_constants.dart';
import '../../../viewmodels/transaction_viewmodel.dart';
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

  final List<String> _tabs = ['Transactions', 'Report', 'Settle Up'];

  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _focusedDay =
                          DateTime(_focusedDay.year, _focusedDay.month - 1);
                    });
                  },
                ),
                InkWell(
                  onTap: () async {
                    final newRange = await showDateRangePicker(
                      context: context,
                      initialDateRange: _selectedDateRange,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (newRange != null) {
                      setState(() {
                        _selectedDateRange = newRange;
                      });
                      // Reload transactions for all tabs
                      context.read<TransactionViewModel>().loadTransactions(
                            startDate: _selectedDateRange.start,
                            endDate: _selectedDateRange.end,
                          );
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${DateFormat('MMM dd').format(_selectedDateRange.start)} - '
                          '${DateFormat('MMM dd').format(_selectedDateRange.end)}',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const Gap(4),
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? ThemeConstants.textPrimaryDark
                              : ThemeConstants.textPrimaryLight,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _focusedDay =
                          DateTime(_focusedDay.year, _focusedDay.month + 1);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    final isDarkMode =
                        Theme.of(context).brightness == Brightness.dark;
                    showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                      color: isDarkMode
                          ? ThemeConstants.surfaceDark
                          : Colors.white,
                      items: [
                        PopupMenuItem<FilterOption>(
                          value: FilterOption.categories,
                          child: Row(
                            children: [
                              Icon(Iconsax.category_2_bold,
                                  size: 20,
                                  color: isDarkMode
                                      ? ThemeConstants.textPrimaryDark
                                      : null),
                              const Gap(8),
                              Text('By Category',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        PopupMenuItem<FilterOption>(
                          value: FilterOption.dates,
                          child: Row(
                            children: [
                              Icon(Iconsax.calendar_1_bold,
                                  size: 20,
                                  color: isDarkMode
                                      ? ThemeConstants.textPrimaryDark
                                      : null),
                              const SizedBox(width: 8),
                              Text('By Date Range',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        PopupMenuItem<FilterOption>(
                          value: FilterOption.amounts,
                          child: Row(
                            children: [
                              Icon(Iconsax.money_2_bold,
                                  size: 20,
                                  color: isDarkMode
                                      ? ThemeConstants.textPrimaryDark
                                      : null),
                              const SizedBox(width: 8),
                              Text('By Amount',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ).then((value) {
                      if (value != null) {
                        _handleFilterSelection(value);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          // Summary Cards
          Consumer<TransactionViewModel>(builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: SummaryCardWidget(
                        title: 'Income',
                        amount: '₹${provider.totalIncome}',
                        textColor: Colors.green),
                  ),
                  Expanded(
                    child: SummaryCardWidget(
                        title: 'Expense',
                        amount: '₹${provider.totalExpense}',
                        textColor: Colors.red),
                  ),
                  Expanded(
                    child: SummaryCardWidget(
                        title: 'Available',
                        amount: '₹${provider.availableBalance}',
                        textColor: Colors.blue),
                  ),
                ],
              ),
            );
          }),
          // Tab buttons
          Padding(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : Theme.of(context).brightness ==
                                        Brightness.dark
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
                                  : Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ThemeConstants.textPrimaryDark
                                      : ThemeConstants.textPrimaryLight,
                            ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
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

  void _handleFilterSelection(FilterOption option) {
    // Implement filter logic based on the selected option
  }
}
