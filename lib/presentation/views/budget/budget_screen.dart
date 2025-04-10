import 'package:finance_tracker/presentation/views/budget/widgets/budget_item_widget.dart';
import 'package:finance_tracker/presentation/views/budget/widgets/non_budget_item_widget.dart';
import 'package:finance_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:finance_tracker/core/models/collaborator.dart';
import 'widgets/budget_monthly_selector_widget.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  DateTime _focusedDay = DateTime.now();

  List<Collaborator> _collaborators = [];

  final List<Map<String, dynamic>> _budgetedCategories = [
    {
      'name': 'Dining',
      'icon': Icons.restaurant,
      'limit': 1000.00,
      'spent': 256.00,
      'remaining': 744.00,
      'isShared': false,
      'collaborators': <Collaborator>[],
    },
    {
      'name': 'Groceries',
      'icon': Icons.shopping_cart,
      'limit': 500.00,
      'spent': 256.00,
      'remaining': 244.00,
      'isShared': false,
      'collaborators': <Collaborator>[],
    },
  ];

  final List<Map<String, dynamic>> _nonBudgetedCategories = [
    {
      'name': 'Entertainment',
      'icon': Icons.movie,
    },
    {
      'name': 'Fuel',
      'icon': Icons.local_gas_station,
    },
    {
      'name': 'Movies',
      'icon': Icons.movie_creation,
    },
  ];

  double get _totalBudget => _budgetedCategories.fold(
        0.0,
        (sum, category) => sum + (category['limit'] as double),
      );

  double get _totalSpent => _budgetedCategories.fold(
        0.0,
        (sum, category) => sum + (category['spent'] as double),
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MonthSelectorWidget(
            focusedDay: _focusedDay,
            onMonthChanged: (newDate) => setState(() => _focusedDay = newDate),
          ),
          BudgetSummaryCard(
            totalBudget: _totalBudget,
            totalSpent: _totalSpent,
          ),
          BudgetCategorySection(
            title: 'Budgeted Categories',
            children: _budgetedCategories
                .map((category) => BudgetItem(
                      name: category['name'],
                      icon: category['icon'],
                      limit: category['limit'],
                      spent: category['spent'],
                      remaining: category['remaining'],
                      isShared: category['isShared'],
                      collaborators: category['collaborators'] ?? [],
                      onEdit: () {
                        _showSetBudgetDialog(
                            category['name'], category['icon']);
                      },
                      onShare: () {
                        _manageCollaborators();
                      },
                      onDelete: () {
                        _deleteBudget(category['name']);
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  void _manageCollaborators() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Manage Collaborators', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: _collaborators.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  title: Text(_collaborators[index].name),
                  value: _collaborators[index].isSelected,
                  onChanged: (v) => setState(() {
                    _collaborators[index].isSelected = v!;
                  }),
                ),
              ),
            ),
            CustomButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Save Collaborators'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSetBudgetDialog(String categoryName, IconData categoryIcon) {
    double budgetAmount = 0.0;
    String selectedRecurrence = 'Monthly';
    String customPeriod = '';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Set Budget for $categoryName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Budget Amount',
                  prefixIcon: Icon(Iconsax.money_2_bold),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    budgetAmount = double.tryParse(value) ?? 0.0,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedRecurrence,
                items: const [
                  DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
                  DropdownMenuItem(value: 'Yearly', child: Text('Yearly')),
                  DropdownMenuItem(value: 'Custom', child: Text('Custom')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedRecurrence = value!;
                    // Reset custom period when switching away from Custom
                    if (value != 'Custom') {
                      customPeriod = '';
                    }
                  });
                },
              ),
              if (selectedRecurrence == 'Custom') ...[
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Custom Period (e.g., 2 weeks, 3 months)',
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: 'Enter custom budget period',
                  ),
                  onChanged: (value) {
                    setState(() {
                      customPeriod = value;
                    });
                  },
                ),
              ],
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Iconsax.people_bold),
                title: const Text('Add Collaborators'),
                trailing: const Icon(Iconsax.arrow_right_3_bold),
                onTap: _manageCollaborators,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Validate custom period is not empty when Custom is selected
                if (selectedRecurrence == 'Custom' && customPeriod.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a custom budget period'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                _addBudgetToCategory(
                  categoryName,
                  categoryIcon,
                  budgetAmount,
                  selectedRecurrence == 'Custom'
                      ? customPeriod
                      : selectedRecurrence,
                );
                Navigator.pop(context);
              },
              child: const Text('Save Budget'),
            ),
          ],
        ),
      ),
    );
  }

  void _addBudgetToCategory(
    String name,
    IconData icon,
    double limit,
    String recurrence,
  ) {
    setState(() {
      // Remove from non-budgeted
      _nonBudgetedCategories.removeWhere((cat) => cat['name'] == name);

      // Add to budgeted
      _budgetedCategories.add({
        'name': name,
        'icon': icon,
        'limit': limit,
        'spent': 0.0,
        'remaining': limit,
        'recurrence': recurrence,
        'isShared': false,
        'collaborators': <Collaborator>[],
        'isCustomPeriod': !['Monthly', 'Yearly'].contains(recurrence),
      });
    });
  }

  void _deleteBudget(String categoryName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Budget'),
        content: Text(
            'Are you sure you want to remove the budget for $categoryName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                final category = _budgetedCategories.firstWhere(
                  (cat) => cat['name'] == categoryName,
                );
                _budgetedCategories.remove(category);
                _nonBudgetedCategories.add({
                  'name': categoryName,
                  'icon': category['icon'],
                });
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
/*
BudgetCategorySection(
            title: 'Categories without Budget',
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _nonBudgetedCategories.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 0.1, color: Colors.grey.shade200),
                itemBuilder: (context, index) {
                  final category = _nonBudgetedCategories[index];
                  return NonBudgetItem(
                    name: category['name'],
                    icon: category['icon'],
                    onPress: () => _showSetBudgetDialog(
                        category['name'], category['icon']),
                  );
                },
              ),
            ],
          ),
 */
