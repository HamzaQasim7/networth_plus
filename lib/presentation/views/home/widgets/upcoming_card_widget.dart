import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';

class UpcomingPaymentsCard extends StatelessWidget {
  const UpcomingPaymentsCard({super.key});

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
                  'Upcoming payments',
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
            const _PaymentItem(
              date: '28 Feb 2025',
              title: 'Credit Card',
              amount: '₹1,000',
              subtitle: 'Credit Card',
              textColor: ThemeConstants.negativeColor,
            ),
            const SizedBox(height: 12),
            const _PaymentItem(
              date: '28 Feb 2025',
              title: 'Car Loan EMI',
              amount: '₹5,000',
              subtitle: 'Car Loan EMI',
              textColor: ThemeConstants.primaryColor,
            ),
            const SizedBox(height: 12),
            const _PaymentItem(
              date: '28 Feb 2025',
              title: 'Home Loan EMI',
              amount: '₹8,455',
              subtitle: 'Home Loan EMI',
              textColor: ThemeConstants.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  final String date;
  final String title;
  final String subtitle;
  final String amount;
  final Color textColor;

  const _PaymentItem({
    required this.date,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDarkMode 
                    ? ThemeConstants.textPrimaryDark 
                    : ThemeConstants.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: isDarkMode 
                    ? ThemeConstants.textSecondaryDark 
                    : ThemeConstants.textSecondaryLight,
                fontSize: 12,
              ),
            ),
          ],
        ),
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
