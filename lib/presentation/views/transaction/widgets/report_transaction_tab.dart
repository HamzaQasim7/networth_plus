import 'package:collection/collection.dart';
import 'package:finance_tracker/presentation/views/transaction/widgets/report_item_widget.dart';
import 'package:finance_tracker/presentation/views/transaction/widgets/transaction_chart_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/theme_constants.dart';

class ReportTransactionTab extends StatefulWidget {
  const ReportTransactionTab({super.key});

  @override
  State<ReportTransactionTab> createState() => _ReportTransactionTabState();
}

class _ReportTransactionTabState extends State<ReportTransactionTab> {
  int _touchedIndex = -1;

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

  double get totalIncome => _transactions
      .where((t) => t['isExpense'] == false)
      .fold(0.0, (sum, t) => sum + (t['amount'] as double));

  double get totalExpense => _transactions
      .where((t) => t['isExpense'])
      .fold(0.0, (sum, t) => sum + (t['amount'] as double));

  double get netSavings => totalIncome - totalExpense;
}
