import 'package:finance_tracker/presentation/views/portfolio_screen/widgets/assets_laibilities_list.dart';
import 'package:finance_tracker/presentation/views/portfolio_screen/widgets/over_view_header_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';
import 'net_worth_display_widget.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: isDarkMode ? ThemeConstants.cardDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode
                        ? ThemeConstants.textPrimaryDark
                        : ThemeConstants.textPrimaryLight,
                  ),
            ),
            const OverviewHeader(),
            const SizedBox(height: 8),
            const NetWorthDisplay(),
            const SizedBox(height: 16),
            Row(
              children: [
                // Pie Chart
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 150,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: 70,
                            color: ThemeConstants.primaryColor.withOpacity(0.7),
                            title: '',
                            radius: 40,
                          ),
                          PieChartSectionData(
                            value: 30,
                            color: isDarkMode
                                ? Colors.grey.shade700
                                : Colors.grey.shade200,
                            title: '',
                            radius: 40,
                          ),
                        ],
                        sectionsSpace: 0,
                        centerSpaceRadius: 30,
                      ),
                    ),
                  ),
                ),
                // Assets and Liabilities List
                const Expanded(
                  flex: 3,
                  child: AssetLiabilitiesList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
