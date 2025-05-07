import 'package:finance_tracker/presentation/views/portfolio_screen/widgets/assets_laibilities_section.dart';
import 'package:finance_tracker/presentation/views/portfolio_screen/widgets/over_view_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/asset_liability_viewmodel.dart';
import '../../../viewmodels/budget_viewmodel.dart';
import '../../../widgets/app_header_text.dart';
import '../../../widgets/line_chart_widget.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final GlobalKey<AssetsLiabilitiesSectionState> _sectionKey = GlobalKey();

  bool get isAssetTabSelected =>
      _sectionKey.currentState?.selectedTabIndex == 0;

  @override
  Widget build(BuildContext context) {
    final budgetVM = context.watch<BudgetViewModel>();
    final assetVM = context.watch<AssetLiabilityViewModel>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OverviewCard(),
          const Gap(16),
          const AppHeaderText(text: 'Growth Trend', fontSize: 18),
          const Gap(16),
          SizedBox(
            height: 200,
            child: LineChartWidget(
              netWorthHistory: assetVM.netWorthHistory
                  .map((h) => FlSpot(h.date.month.toDouble(), h.amount))
                  .toList(),
            ),
          ),
          const Gap(16),
          AssetsLiabilitiesSection(key: _sectionKey),
        ],
      ),
    );
  }
}
