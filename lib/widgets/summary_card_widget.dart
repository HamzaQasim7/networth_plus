import 'package:flutter/material.dart';
import '../core/constants/theme_constants.dart';

class SummaryCardWidget extends StatelessWidget {
  const SummaryCardWidget(
      {super.key,
      required this.title,
      required this.amount,
      required this.textColor});

  final String title, amount;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? ThemeConstants.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDarkMode 
                      ? ThemeConstants.textSecondaryDark 
                      : ThemeConstants.textSecondaryLight,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
