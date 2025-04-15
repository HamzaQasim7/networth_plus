import 'package:finance_tracker/widgets/app_header_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../viewmodels/asset_liability_viewmodel.dart';

class NetValueRowWidget extends StatelessWidget {
  const NetValueRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AssetLiabilityViewModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeaderText(
                text: 'Net Worth: ${Helpers.formatCurrency(vm.netWorth)}'),
            // Text(
            //   '▲ ${Helpers.formatCurrency(vm.totalAssets)} Assets'
            //   ' ▼ ${Helpers.formatCurrency(vm.totalLiabilities)} Liabilities',
            //   style: Theme.of(context).textTheme.bodyMedium,
            // ),
          ],
        ),
        _buildLoadingOrRefresh(vm),
      ],
    );
  }

  Widget _buildLoadingOrRefresh(AssetLiabilityViewModel vm) {
    return vm.isLoading
        ? const CircularProgressIndicator()
        : IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: vm.reloadItems,
            tooltip: 'Refresh Net Worth',
          );
  }
}
