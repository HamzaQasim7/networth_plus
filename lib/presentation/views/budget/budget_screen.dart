import 'package:finance_tracker/widgets/custom_button.dart';
import 'package:finance_tracker/widgets/summary_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:finance_tracker/core/models/collaborator.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  bool _isCalendarVisible = false;
  CalendarFormat _calendarFormat = CalendarFormat.month;
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
          _buildMonthSelector(),
          _buildBudgetSummary(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Budgeted Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ..._budgetedCategories.map((category) => _buildBudgetItem(
                name: category['name'],
                icon: category['icon'],
                limit: category['limit'],
                spent: category['spent'],
                remaining: category['remaining'],
                isShared: category['isShared'],
                collaborators: category['collaborators'] ?? [],
              )),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Categories without Budget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                onPress: () =>
                    _showSetBudgetDialog(category['name'], category['icon']),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _focusedDay =
                        DateTime(_focusedDay.year, _focusedDay.month - 1);
                  });
                },
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isCalendarVisible = !_isCalendarVisible;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        DateFormat('MMMM, yyyy').format(_focusedDay),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _focusedDay =
                        DateTime(_focusedDay.year, _focusedDay.month + 1);
                  });
                },
              ),
            ],
          ),
        ),
        if (_isCalendarVisible)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _isCalendarVisible = false;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBudgetSummary() {
    final remainingTotal = _totalBudget - _totalSpent;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Total Budget Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Budget',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '₹${_totalBudget.toStringAsFixed(2)}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                  ],
                ),
              ),
              // Spent Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Spent',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '₹${_totalSpent.toStringAsFixed(2)}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.red,
                              ),
                    ),
                  ],
                ),
              ),
              // Remaining Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Remaining',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '₹${remainingTotal.toStringAsFixed(2)}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.green,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _totalSpent / _totalBudget,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                _totalSpent / _totalBudget > 0.9 ? Colors.red : Colors.green,
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetItem({
    required String name,
    required IconData icon,
    required double limit,
    required double spent,
    required double remaining,
    required bool isShared,
    required List<dynamic> collaborators,
  }) {
    final List<Collaborator> typedCollaborators =
        collaborators.map((c) => c as Collaborator).toList();

    final progress = spent / limit;

    return Container(
      padding: const EdgeInsets.all(16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              _showSetBudgetDialog(name, icon);
                              break;
                            case 'share':
                              _manageCollaborators();
                              break;
                            case 'delete':
                              _deleteBudget(name);
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit Budget'),
                          ),
                          const PopupMenuItem(
                            value: 'share',
                            child: Text('Share Budget'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete Budget'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Budget details in vertical layout
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Limit: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: '₹${limit.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Spent: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: '₹${spent.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Remaining: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: '₹${remaining.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress > 0.9 ? Colors.red : Colors.green,
                      ),
                      minHeight: 4,
                    ),
                  ),
                  if (isShared && typedCollaborators.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _buildCollaboratorAvatars(typedCollaborators),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollaboratorAvatars(List<Collaborator> collaborators) {
    return Stack(
      children: [
        ...collaborators.take(3).map((c) => CircleAvatar(
              backgroundImage: NetworkImage(c!.avatarUrl),
              radius: 12,
            )),
        if (collaborators.length > 3)
          CircleAvatar(
            radius: 12,
            child: Text('+${collaborators.length - 3}'),
          ),
      ],
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
                  selectedRecurrence == 'Custom' ? customPeriod : selectedRecurrence,
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

class NonBudgetItem extends StatelessWidget {
  const NonBudgetItem({
    super.key,
    required this.name,
    required this.icon,
    required this.onPress,
  });

  final String name;
  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.grey[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 130,
            child: TextButton(
              onPressed: onPress,
              style: TextButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('SET BUDGET'),
            ),
          ),
        ],
      ),
    );
  }
}
