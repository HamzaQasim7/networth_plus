import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/theme_constants.dart';

class NetWorthDisplay extends StatelessWidget {
  const NetWorthDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildGrowthChip('1M', '1.6%', Colors.green),
            const SizedBox(width: 8),
            _buildGrowthChip('6M', '-2.5%', Colors.red),
            const SizedBox(width: 8),
            _buildGrowthChip('1Y', '3.6%', Colors.green),
          ],
        ),
        const Gap(20),
        Text(
          '₹10,00,000.00',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? ThemeConstants.textPrimaryDark
                    : ThemeConstants.textPrimaryLight,
              ),
        ),
        Divider(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
            indent: 0.5,
            endIndent: 0.5)
      ],
    );
  }

  Widget _buildGrowthChip(String period, String percentage, Color color) {
    final isNegative = percentage.startsWith('-');
    return Builder(builder: (context) {
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          '$period ${isNegative ? '↓' : '↑'} $percentage',
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    });
  }
}
