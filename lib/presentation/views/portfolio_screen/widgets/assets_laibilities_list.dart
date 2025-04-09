import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';

class AssetLiabilitiesList extends StatelessWidget {
  const AssetLiabilitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Assets:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: isDarkMode
                      ? ThemeConstants.textPrimaryDark
                      : ThemeConstants.textPrimaryLight,
                ),
          ),
          const SizedBox(height: 8),
          _buildListItem('• Home'),
          _buildListItem('• Car'),
          const SizedBox(height: 16),
          Text(
            'Top Liabilities:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: isDarkMode
                      ? ThemeConstants.textPrimaryDark
                      : ThemeConstants.textPrimaryLight,
                ),
          ),
          const SizedBox(height: 8),
          _buildListItem('• Home Loan'),
          _buildListItem('• Car Loan'),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Builder(builder: (context) {
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;

      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color:
                isDarkMode ? ThemeConstants.textSecondaryDark : Colors.black87,
          ),
        ),
      );
    });
  }
}
