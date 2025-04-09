import 'package:finance_tracker/widgets/line_chart_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../widgets/app_header_text.dart';
import 'progress_indicator_widget.dart';

class AnalyticsRow extends StatelessWidget {
  const AnalyticsRow({
    super.key,
    required this.value,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Container(
          height: 150,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ThemeConstants.primaryColor,
                ThemeConstants.primaryColor.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.6, 1.0],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ProgressIndicatorWidget(value: value),
        ),
        const AppHeaderText(text: 'Growth Trend', fontSize: 18),
        const SizedBox(
          height: 200,
          child: LineChartWidget(),
        ),
      ],
    );
  }
}
