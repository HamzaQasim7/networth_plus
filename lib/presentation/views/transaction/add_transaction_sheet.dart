import 'package:flutter/material.dart';
import '../../../widgets/custom_bottom_sheet.dart';

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Form data
  String _transactionType = 'Expense';
  double _amount = 0;
  String _category = '';
  DateTime _date = DateTime.now();
  String _notes = '';
  List<String> _attachments = [];
  List<String> _splitWith = [];

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: 'Add Transaction',
      onSave: _currentStep == 5 ? _saveTransaction : null,
      children: [
        Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 5) {
              setState(() => _currentStep++);
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            }
          },
          steps: [
            _buildTransactionTypeStep(),
            _buildAmountStep(),
            _buildCategoryStep(),
            _buildDateTimeStep(),
            _buildNotesStep(),
            _buildSplitStep(),
          ],
        ),
      ],
    );
  }

  Step _buildTransactionTypeStep() {
    return Step(
      title: const Text('Transaction Type'),
      content: SegmentedButton(
        segments: const [
          ButtonSegment(value: 'Expense', label: Text('Expense')),
          ButtonSegment(value: 'Income', label: Text('Income')),
        ],
        selected: {_transactionType},
        onSelectionChanged: (Set<String> newSelection) {
          setState(() => _transactionType = newSelection.first);
        },
      ),
      isActive: _currentStep == 0,
    );
  }

  Step _buildAmountStep() {
    return Step(
      title: const Text('Amount'),
      content: TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          prefixText: '₹ ',
          labelText: 'Enter Amount',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an amount';
          }
          if (double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            _amount = double.tryParse(value) ?? 0;
          });
        },
      ),
      isActive: _currentStep == 1,
    );
  }

  Step _buildCategoryStep() {
    final categories = _transactionType == 'Expense'
        ? ['Food', 'Transport', 'Shopping', 'Bills', 'Entertainment', 'Other']
        : ['Salary', 'Investment', 'Gift', 'Other'];

    return Step(
      title: const Text('Category'),
      content: Column(
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: categories.map((category) {
              return ChoiceChip(
                label: Text(category),
                selected: _category == category,
                onSelected: (selected) {
                  setState(() {
                    _category = selected ? category : '';
                  });
                },
              );
            }).toList(),
          ),
          if (_category == 'Other')
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Custom Category',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
              ),
            ),
        ],
      ),
      isActive: _currentStep == 2,
    );
  }

  Step _buildDateTimeStep() {
    return Step(
      title: const Text('Date & Time'),
      content: Column(
        children: [
          ListTile(
            title: const Text('Date'),
            subtitle: Text(
              '${_date.day}/${_date.month}/${_date.year}',
              style: const TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() {
                  _date = DateTime(
                    picked.year,
                    picked.month,
                    picked.day,
                    _date.hour,
                    _date.minute,
                  );
                });
              }
            },
          ),
          ListTile(
            title: const Text('Time'),
            subtitle: Text(
              '${_date.hour}:${_date.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.access_time),
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(_date),
              );
              if (picked != null) {
                setState(() {
                  _date = DateTime(
                    _date.year,
                    _date.month,
                    _date.day,
                    picked.hour,
                    picked.minute,
                  );
                });
              }
            },
          ),
        ],
      ),
      isActive: _currentStep == 3,
    );
  }

  Step _buildNotesStep() {
    return Step(
      title: const Text('Notes & Attachments'),
      content: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Add Notes',
              border: OutlineInputBorder(),
              hintText: 'Enter any additional details...',
            ),
            maxLines: 3,
            onChanged: (value) {
              setState(() {
                _notes = value;
              });
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () async {
              // Implement file picking logic
              // You'll need to add image_picker package for this
              // final ImagePicker picker = ImagePicker();
              // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              // if (image != null) {
              //   setState(() {
              //     _attachments.add(image.path);
              //   });
              // }
            },
            icon: const Icon(Icons.attach_file),
            label: const Text('Add Attachment'),
          ),
          if (_attachments.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: _attachments
                  .map(
                    (path) => Chip(
                      label: Text(path.split('/').last),
                      onDeleted: () {
                        setState(() {
                          _attachments.remove(path);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
      isActive: _currentStep == 4,
    );
  }

  Step _buildSplitStep() {
    return Step(
      title: const Text('Split/Share'),
      content: Column(
        children: [
          SwitchListTile(
            title: const Text('Split this transaction?'),
            value: _splitWith.isNotEmpty,
            onChanged: (bool value) {
              setState(() {
                if (!value) {
                  _splitWith.clear();
                }
              });
            },
          ),
          if (_splitWith.isNotEmpty) ...[
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Add Person',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.person_add),
              ),
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _splitWith.add(value);
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: _splitWith
                  .map(
                    (person) => Chip(
                      label: Text(person),
                      onDeleted: () {
                        setState(() {
                          _splitWith.remove(person);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
      isActive: _currentStep == 5,
    );
  }

  @override
  void _saveTransaction() {
    if (_formKey.currentState?.validate() ?? false) {
      final transaction = {
        'type': _transactionType,
        'amount': _amount,
        'category': _category,
        'date': _date,
        'notes': _notes,
        'attachments': _attachments,
        'splitWith': _splitWith,
      };

      // Here you would typically:
      // 1. Save to local database
      // 2. Sync with backend
      // 3. Update UI

      Navigator.pop(context, transaction);
    }
  }
}
