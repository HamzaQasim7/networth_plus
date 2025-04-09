import 'package:finance_tracker/core/services/session_manager.dart';
import 'package:finance_tracker/presentation/views/home/widgets/account_cards_widget.dart';
import 'package:finance_tracker/presentation/views/home/widgets/analaytic_row_widget.dart';
import 'package:finance_tracker/presentation/views/home/widgets/balance_card_widget.dart';
import 'package:finance_tracker/presentation/views/home/widgets/net_value_row_widget.dart';
import 'package:finance_tracker/presentation/views/home/widgets/over_view_data_widget.dart';
import 'package:finance_tracker/presentation/views/home/widgets/upcoming_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final sessionManager = context.read<SessionManager>();
    await sessionManager.clearSession();
    // No need to navigate manually, SessionWrapper will handle it
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NetValueRowWidget(),
              AnalyticsRow(value: 0.7),
              AccountCardsWidget(),
              BalanceCard(),
              UpcomingPaymentsCard(),
              DataOverViewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
