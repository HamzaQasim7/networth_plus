import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../core/constants/theme_constants.dart';

class DonutChartWidget extends StatelessWidget {
  const DonutChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      swapAnimationCurve: Curves.easeInOut,
      swapAnimationDuration: const Duration(microseconds: 800),
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 30,
        sections: [
          PieChartSectionData(
            value: 93.33, // (1400/1500)*100
            color: ThemeConstants.primaryColor,
            title: '',
            radius: 20,
          ),
          PieChartSectionData(
            value: 6.67, // (100/1500)*100
            color: Colors.orange,
            title: '',
            radius: 20,
          ),
        ],
      ),
    );
  }
}
