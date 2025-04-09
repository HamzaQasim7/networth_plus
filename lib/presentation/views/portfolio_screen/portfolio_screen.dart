import 'package:finance_tracker/presentation/views/portfolio_screen/widgets/assets_laibilities_section.dart';
import 'package:finance_tracker/presentation/views/portfolio_screen/widgets/over_view_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OverviewCard(),
          const Gap(16),
          AssetsLiabilitiesSection(key: _sectionKey),
        ],
      ),
    );
  }
}
