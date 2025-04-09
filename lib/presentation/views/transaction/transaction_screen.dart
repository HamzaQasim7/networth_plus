import 'package:finance_tracker/presentation/views/dashboard/add_transaction_sheet.dart';
import 'package:finance_tracker/presentation/views/transaction/widgets/report_item_widget.dart';
import 'package:finance_tracker/presentation/views/transaction/widgets/settle_up_view_tab.dart';
import 'package:finance_tracker/presentation/views/transaction/widgets/transaction_chart_widget.dart';
import 'package:finance_tracker/widgets/custom_text_field.dart';
import 'package:finance_tracker/widgets/summary_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/transaction_viewmodel.dart';
import '../../../widgets/transaction_item.dart';
import '../../../core/constants/theme_constants.dart';

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
  int _touchedIndex = -1;

  final List<String> _tabs = ['Transactions', 'Report', 'Settle Up'];

  // Dummy data for transactions
  final List<Map<String, dynamic>> _transactions = [
    {
      'date': DateTime(2024, 2, 11),
      'icon': Icons.restaurant,
      'title': 'Dining',
      'description': 'Cash - John owes ₹7.5',
      'amount': 7.50,
      'isExpense': true,
    },
    {
      'date': DateTime(2024, 2, 11),
      'icon': Icons.fitness_center,
      'title': 'Gym',
      'description': 'Cash',
      'amount': 200.00,
      'isExpense': true,
    },
    {
      'date': DateTime(2024, 2, 11),
      'icon': Icons.shopping_cart,
      'title': 'Groceries',
      'description': 'Card',
      'amount': 15.00,
      'isExpense': true,
    },
    {
      'date': DateTime(2024, 2, 11),
      'icon': Icons.movie,
      'title': 'Movies',
      'description': 'Cash - You owe John ₹25',
      'amount': 25.00,
      'isExpense': false,
    },
  ];

  // Add new chart data calculation methods
  Map<String, double> get _categoryExpenses {
    final Map<String, double> categoryMap = {};
    for (var transaction in _transactions) {
      final category = transaction['title'];
      final amount = transaction['amount'] as double;
      categoryMap.update(
        category,
        (value) => value + amount,
        ifAbsent: () => amount,
      );
    }
    return categoryMap;
  }

  List<PieChartSectionData> get _pieChartSections {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return _categoryExpenses.entries
        .mapIndexed(
          (index, entry) => PieChartSectionData(
            color: _getChartColor(index),
            value: entry.value,
            title: '',
            radius: index == _touchedIndex ? 50 : 40,
            titlePositionPercentageOffset: 0.5,
            borderSide: BorderSide(
                color: isDarkMode ? ThemeConstants.surfaceDark : Colors.white,
                width: 2),
          ),
        )
        .toList();
  }

  Color _getChartColor(int index) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final lightModeColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
    ];

    final darkModeColors = [
      Colors.blue.shade300,
      Colors.green.shade300,
      Colors.orange.shade300,
      Colors.red.shade300,
      Colors.purple.shade300,
    ];

    return isDarkMode
        ? darkModeColors[index % darkModeColors.length]
        : lightModeColors[index % lightModeColors.length];
  }

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
                  onTap: () => _showMonthPicker(),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ThemeConstants.surfaceDark
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[700]!
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('MMMM, yyyy').format(_focusedDay),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(width: 4),
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
                              const SizedBox(width: 8),
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
                ? _buildTransactionsView()
                : _selectedTabIndex == 1
                    ? _buildReportView()
                    : const SettleUpViewTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsView() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _transactions.length,
      separatorBuilder: (context, index) => Divider(
        height: 0.1,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.grey[200],
      ),
      itemBuilder: (context, index) {
        final transaction = _transactions[index];
        return InkWell(
          onTap: () => _showTransactionDetails(transaction),
          child: TransactionItem(
            date: transaction['date'],
            categoryIcon: transaction['icon'],
            title: transaction['title'],
            description: transaction['description'],
            amount: transaction['amount'],
            isExpense: true,
          ),
        );
      },
    );
  }

  Widget _buildReportView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TransactionChartWidget(
                  title: 'Spending by Category',
                  chart: AspectRatio(
                    aspectRatio: 1.5,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (event, response) {
                            setState(() {
                              _touchedIndex = response
                                      ?.touchedSection?.touchedSectionIndex ??
                                  -1;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 50,
                        sections: _pieChartSections,
                      ),
                    ),
                  ),
                ),
                _buildReportSection(
                  title: 'Financial Summary',
                  child: Column(
                    children: [
                      ReportItemWidget(
                        label: 'Total Income',
                        value: '₹${totalIncome.toStringAsFixed(2)}',
                      ),
                      ReportItemWidget(
                        label: 'Total Expenses',
                        value: '₹${totalExpense.toStringAsFixed(2)}',
                      ),
                      ReportItemWidget(
                        label: 'Net Savings',
                        value: '₹${netSavings.toStringAsFixed(2)}',
                        textColor: netSavings >= 0 ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
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
            const SizedBox(height: 24),
            _buildDetailRow('Category', transaction['title']),
            _buildDetailRow('Amount', '₹${transaction['amount']}'),
            _buildDetailRow(
                'Date', DateFormat('MMM d, yyyy').format(transaction['date'])),
            _buildDetailRow('Description', transaction['description']),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _editTransaction(transaction);
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _deleteTransaction(_transactions.indexOf(transaction));
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
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

  void _handleFilterSelection(FilterOption option) {
    // Implement filter logic based on the selected option
  }

  void _editTransaction(Map<String, dynamic> transaction) {
    final index = _transactions.indexOf(transaction);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransactionSheet(
          isEditing: true,
          transaction: transaction,
          onSave: (editedTransaction) {
            setState(() {
              _transactions[index] = editedTransaction;
            });
          },
        ),
      ),
    );
  }

  void _deleteTransaction(int index) {
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
            onPressed: () {
              setState(() {
                _transactions.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  double get totalIncome => _transactions
      .where((t) => t['isExpense'] == false)
      .fold(0.0, (sum, t) => sum + (t['amount'] as double));

  double get totalExpense => _transactions
      .where((t) => t['isExpense'])
      .fold(0.0, (sum, t) => sum + (t['amount'] as double));

  double get netSavings => totalIncome - totalExpense;

  Widget _buildReportSection({required String title, required Widget child}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? ThemeConstants.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.primaryColor,
              ),
            ),
            const Gap(12),
            child,
          ],
        ),
      ),
    );
  }

  void _showMonthPicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _focusedDay,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        _focusedDay = DateTime(picked.year, picked.month);
      });
    }
  }
}
