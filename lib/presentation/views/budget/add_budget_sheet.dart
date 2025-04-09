import 'package:flutter/material.dart';
import '../../../core/constants/theme_constants.dart';

class AddBudgetSheet extends StatefulWidget {
  final String categoryName;
  final IconData categoryIcon;

  const AddBudgetSheet({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
  });

  @override
  State<AddBudgetSheet> createState() => _AddBudgetSheetState();
}

class _AddBudgetSheetState extends State<AddBudgetSheet> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Form data
  String _category = '';
  IconData _categoryIcon = Icons.category;
  double _budgetAmount = 0;
  String _period = 'Monthly';
  bool _isRecurring = false;
  List<String> _collaborators = [];
  List<String> _alerts = [];

  @override
  void initState() {
    super.initState();
    // Initialize with the provided category if available
    _category = widget.categoryName;
    _categoryIcon = widget.categoryIcon;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Material(
      color: isDarkMode ? ThemeConstants.surfaceDark : Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Set Budget',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: isDarkMode 
                            ? ThemeConstants.textPrimaryDark 
                            : ThemeConstants.textPrimaryLight,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 80,
                    child: TextButton(
                      onPressed: _currentStep == 5 ? _saveBudget : null,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: _currentStep == 5 
                              ? ThemeConstants.primaryColor 
                              : isDarkMode 
                                  ? Colors.grey[600] 
                                  : Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1, 
              color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Step indicator
                        Row(
                          children: List.generate(6, (index) {
                            return Expanded(
                              child: Container(
                                height: 4,
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: index <= _currentStep
                                      ? Theme.of(context).primaryColor
                                      : isDarkMode 
                                          ? Colors.grey[700] 
                                          : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 24),

                        // Step content
                        if (_currentStep == 0) _buildCategoryStepContent(),
                        if (_currentStep == 1) _buildAmountStepContent(),
                        if (_currentStep == 2) _buildPeriodStepContent(),
                        if (_currentStep == 3) _buildRecurringStepContent(),
                        if (_currentStep == 4) _buildCollaboratorsStepContent(),
                        if (_currentStep == 5) _buildAlertsStepContent(),

                        const SizedBox(height: 24),

                        // Navigation buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: _currentStep > 0
                                  ? OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          _currentStep--;
                                        });
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: ThemeConstants.primaryColor,
                                        side: BorderSide(color: ThemeConstants.primaryColor),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)),
                                      ),
                                      child: const Text('Back'),
                                    )
                                  : const SizedBox(),
                            ),
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_currentStep < 5) {
                                    setState(() {
                                      _currentStep++;
                                    });
                                  } else {
                                    _saveBudget();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ThemeConstants.primaryColor,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(100, 48),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text(_currentStep == 5 ? 'Save' : 'Continue'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryStepContent() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final categories = [
      {'name': 'Food', 'icon': Icons.restaurant},
      {'name': 'Transport', 'icon': Icons.directions_car},
      {'name': 'Shopping', 'icon': Icons.shopping_bag},
      {'name': 'Bills', 'icon': Icons.receipt_long},
      {'name': 'Entertainment', 'icon': Icons.movie},
      {'name': 'Health', 'icon': Icons.health_and_safety},
      {'name': 'Education', 'icon': Icons.school},
      {'name': 'Housing', 'icon': Icons.home},
      {'name': 'Other', 'icon': Icons.more_horiz},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Category',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isDarkMode 
                ? ThemeConstants.textPrimaryDark 
                : ThemeConstants.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = _category == category['name'];
            
            return InkWell(
              onTap: () {
                setState(() {
                  _category = category['name'] as String;
                  _categoryIcon = category['icon'] as IconData;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Theme.of(context).primaryColor.withOpacity(0.2)
                      : isDarkMode 
                          ? ThemeConstants.cardDark 
                          : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category['icon'] as IconData,
                      color: isSelected 
                          ? Theme.of(context).primaryColor
                          : isDarkMode 
                              ? ThemeConstants.textPrimaryDark 
                              : Colors.grey[700],
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name'] as String,
                      style: TextStyle(
                        color: isSelected 
                            ? Theme.of(context).primaryColor
                            : isDarkMode 
                                ? ThemeConstants.textPrimaryDark 
                                : Colors.grey[800],
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (_category == 'Other') ...[
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter Custom Category',
              border: const OutlineInputBorder(),
              labelStyle: TextStyle(
                color: isDarkMode 
                    ? ThemeConstants.textSecondaryDark 
                    : ThemeConstants.textSecondaryLight,
              ),
            ),
            style: TextStyle(
              color: isDarkMode 
                  ? ThemeConstants.textPrimaryDark 
                  : ThemeConstants.textPrimaryLight,
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  _category = value;
                });
              }
            },
          ),
        ],
      ],
    );
  }

  Widget _buildAmountStepContent() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Budget Amount',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isDarkMode 
                ? ThemeConstants.textPrimaryDark 
                : ThemeConstants.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixText: '₹ ',
            labelText: 'Enter Budget Amount',
            border: const OutlineInputBorder(),
            helperText: 'Set your budget limit for this category',
            labelStyle: TextStyle(
              color: isDarkMode 
                  ? ThemeConstants.textSecondaryDark 
                  : ThemeConstants.textSecondaryLight,
            ),
            helperStyle: TextStyle(
              color: isDarkMode 
                  ? ThemeConstants.textSecondaryDark 
                  : ThemeConstants.textSecondaryLight,
            ),
          ),
          style: TextStyle(
            color: isDarkMode 
                ? ThemeConstants.textPrimaryDark 
                : ThemeConstants.textPrimaryLight,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a budget amount';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              _budgetAmount = double.tryParse(value) ?? 0;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPeriodStepContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Budget Period',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        ListTile(
          title: const Text('Monthly'),
          leading: Radio<String>(
            value: 'Monthly',
            groupValue: _period,
            onChanged: (value) {
              setState(() => _period = value!);
            },
          ),
        ),
        ListTile(
          title: const Text('Quarterly'),
          leading: Radio<String>(
            value: 'Quarterly',
            groupValue: _period,
            onChanged: (value) {
              setState(() => _period = value!);
            },
          ),
        ),
        ListTile(
          title: const Text('Yearly'),
          leading: Radio<String>(
            value: 'Yearly',
            groupValue: _period,
            onChanged: (value) {
              setState(() => _period = value!);
            },
          ),
        ),
        ListTile(
          title: const Text('Custom'),
          leading: Radio<String>(
            value: 'Custom',
            groupValue: _period,
            onChanged: (value) {
              setState(() => _period = value!);
            },
          ),
        ),
        if (_period == 'Custom')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        // Handle custom date selection
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        // Handle custom date selection
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildRecurringStepContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recurring Options',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Make this budget recurring?'),
          subtitle: const Text('Budget will automatically reset each period'),
          value: _isRecurring,
          onChanged: (bool value) {
            setState(() {
              _isRecurring = value;
            });
          },
        ),
        if (_isRecurring) ...[
          const SizedBox(height: 16),
          const Text(
            'Budget will automatically reset at the beginning of each period',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            title: const Text('Carry over remaining balance'),
            value: false, // Add state variable if needed
            onChanged: (bool? value) {
              // Handle carry over option
            },
          ),
        ],
      ],
    );
  }

  Widget _buildCollaboratorsStepContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Collaborators',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        ListTile(
          title: const Text('Add Collaborators'),
          subtitle: const Text('Share this budget with others'),
          trailing: IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // Show collaborator selection dialog
              _showCollaboratorDialog();
            },
          ),
        ),
        if (_collaborators.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: _collaborators
                .map(
                  (collaborator) => Chip(
                    label: Text(collaborator),
                    onDeleted: () {
                      setState(() {
                        _collaborators.remove(collaborator);
                      });
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildAlertsStepContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alerts & Notifications',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          title: const Text('80% of budget used'),
          value: _alerts.contains('80%'),
          onChanged: (bool? value) {
            setState(() {
              if (value ?? false) {
                _alerts.add('80%');
              } else {
                _alerts.remove('80%');
              }
            });
          },
        ),
        CheckboxListTile(
          title: const Text('90% of budget used'),
          value: _alerts.contains('90%'),
          onChanged: (bool? value) {
            setState(() {
              if (value ?? false) {
                _alerts.add('90%');
              } else {
                _alerts.remove('90%');
              }
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Budget exceeded'),
          value: _alerts.contains('exceeded'),
          onChanged: (bool? value) {
            setState(() {
              if (value ?? false) {
                _alerts.add('exceeded');
              } else {
                _alerts.remove('exceeded');
              }
            });
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Custom Alert Threshold (%)',
            border: OutlineInputBorder(),
            helperText: 'Enter a custom percentage for alerts',
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.isNotEmpty) {
              final threshold = int.tryParse(value);
              if (threshold != null && threshold > 0 && threshold < 100) {
                setState(() {
                  _alerts.add('$threshold%');
                });
              }
            }
          },
        ),
      ],
    );
  }

  void _showCollaboratorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Collaborator'),
        content: SizedBox(
          width: double.maxFinite,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter email or name',
              border: OutlineInputBorder(),
            ),
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  _collaborators.add(value);
                });
                Navigator.pop(context);
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Handle collaborator addition
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _saveBudget() {
    if (_formKey.currentState?.validate() ?? false) {
      final budget = {
        'categoryName': _category,
        'categoryIcon': _categoryIcon,
        'amount': _budgetAmount,
        'period': _period,
        'isRecurring': _isRecurring,
        'collaborators': _collaborators,
        'alerts': _alerts,
      };

      // Here you would typically:
      // 1. Save to local database
      // 2. Sync with backend
      // 3. Update UI

      Navigator.pop(context, budget);
    }
  }
}
