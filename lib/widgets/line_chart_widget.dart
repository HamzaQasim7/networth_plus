import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../core/constants/theme_constants.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample monthly net worth data for the past 12 months
    final monthlyNetWorth = [
      const FlSpot(0, 50000), // Jan
      const FlSpot(1, 52000), // Feb
      const FlSpot(2, 51500), // Mar
      const FlSpot(3, 53000), // Apr
      const FlSpot(4, 54500), // May
      const FlSpot(5, 54000), // Jun
      const FlSpot(6, 56000), // Jul
      const FlSpot(7, 57500), // Aug
      const FlSpot(8, 58000), // Sep
      const FlSpot(9, 59500), // Oct
      const FlSpot(10, 61000), // Nov
      const FlSpot(11, 62000), // Dec
    ];

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${(value / 1000).toStringAsFixed(0)}K',
                  style: const TextStyle(fontSize: 10),
                );
              },
              reservedSize: 35,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                              'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                if (value >= 0 && value < months.length) {
                  return Text(
                    months[value.toInt()],
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: monthlyNetWorth,
            isCurved: true,
            color: ThemeConstants.primaryColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: ThemeConstants.primaryColor.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
