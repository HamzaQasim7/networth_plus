import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

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
                  'Available balance',
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
                    Icons.arrow_forward, 
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _BalanceItem(
                  title: 'Cash',
                  amount: '₹5,600.70',
                  textColor: ThemeConstants.primaryColor,
                ),
                _BalanceItem(
                  title: 'Bank',
                  amount: '₹1,25,000.50',
                  textColor: ThemeConstants.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceItem extends StatelessWidget {
  final String title;
  final String amount;
  final Color textColor;

  const _BalanceItem({
    required this.title,
    required this.amount,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: isDarkMode 
                ? ThemeConstants.textSecondaryDark 
                : ThemeConstants.textSecondaryLight,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
