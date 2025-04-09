import 'package:flutter/material.dart';
import '../../../../core/constants/theme_constants.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    super.key,
    required this.value,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode 
        ? Colors.white.withOpacity(0.15) 
        : Colors.white.withOpacity(0.2);
    
    // Calculate yearly growth percentage (example calculation)
    final yearlyGrowthPercentage = 24.5; // This should come from your actual data
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Yearly Growth',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${yearlyGrowthPercentage.toStringAsFixed(1)}%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'vs Last Year',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        const Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: yearlyGrowthPercentage / 100, // Convert percentage to decimal
            backgroundColor: backgroundColor,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
