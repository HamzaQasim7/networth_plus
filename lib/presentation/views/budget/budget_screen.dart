import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../viewmodels/budget_viewmodel.dart';
import 'widgets/budget_monthly_selector_widget.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  DateTime _focusedDay = DateTime.now();

  void _onMonthChanged(DateTime newDate) {
    setState(() => _focusedDay = newDate);
    context.read<BudgetViewModel>().reloadBudgets();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null) {
          return Center(child: Text('Error: ${viewModel.error}'));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MonthSelectorWidget(
                focusedDay: _focusedDay,
                onMonthChanged: _onMonthChanged,
              ),
              BudgetSummaryCard(
                totalBudget: viewModel.totalBudget,
                totalSpent: viewModel.totalSpent,
              ),
              const BudgetCategorySection(
                title: 'Budgeted Categories',
              ),
            ],
          ),
        );
      },
    );
  }
}
