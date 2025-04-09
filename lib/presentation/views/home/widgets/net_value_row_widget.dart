import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../settings/settings_view.dart';

class NetValueRowWidget extends StatelessWidget {
  const NetValueRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total NetWorth: \$122000',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
