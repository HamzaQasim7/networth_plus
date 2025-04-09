import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../widgets/donut_card_widget.dart';
import '../home_screen.dart';

class DataOverViewCard extends StatelessWidget {
  const DataOverViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? ThemeConstants.cardDark : Colors.white,
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.black12,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last 30 days',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode 
                        ? ThemeConstants.textPrimaryDark 
                        : ThemeConstants.textPrimaryLight,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz, 
                    size: 20,
                    color: isDarkMode 
                        ? ThemeConstants.textPrimaryDark 
                        : ThemeConstants.textPrimaryLight,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: DonutChartWidget(),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: Column(
                    children: [
                      _SummaryItem(
                        label: 'Income',
                        amount: '₹1,500.00',
                        textColor: ThemeConstants.primaryColor,
                      ),
                      SizedBox(height: 8),
                      _SummaryItem(
                        label: 'Expense',
                        amount: '₹100.00',
                        textColor: ThemeConstants.negativeColor,
                      ),
                      SizedBox(height: 8),
                      _SummaryItem(
                        label: 'Savings',
                        amount: '₹1,400.00',
                        textColor: ThemeConstants.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String amount;
  final Color textColor;

  const _SummaryItem({
    required this.label,
    required this.amount,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode 
                ? ThemeConstants.textPrimaryDark 
                : ThemeConstants.textPrimaryLight,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
