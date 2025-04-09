import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constants.dart';

class AddAssetLiabilitySheet extends StatefulWidget {
  final bool isAsset;

  const AddAssetLiabilitySheet({
    super.key,
    required this.isAsset,
  });

  @override
  State<AddAssetLiabilitySheet> createState() => _AddAssetLiabilitySheetState();
}

class _AddAssetLiabilitySheetState extends State<AddAssetLiabilitySheet> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Form data
  String _type = '';
  double _amount = 0;
  String _name = '';
  DateTime _startDate = DateTime.now();
  double? _interestRate;
  String? _paymentSchedule;
  List<String> _attachments = [];
  List<String> _trackingPreferences = [];

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
                      'Add ${widget.isAsset ? "Asset" : "Liability"}',
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
                      onPressed: _currentStep == 4 ? _saveAssetLiability : null,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: _currentStep == 4
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
                          children: List.generate(5, (index) {
                            return Expanded(
                              child: Container(
                                height: 4,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
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
                        if (_currentStep == 0) _buildTypeStepContent(),
                        if (_currentStep == 1) _buildAmountStepContent(),
                        if (_currentStep == 2) _buildDetailsStepContent(),
                        if (_currentStep == 3) _buildAttachmentsStepContent(),
                        if (_currentStep == 4) _buildTrackingStepContent(),

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
                                        foregroundColor:
                                            ThemeConstants.primaryColor,
                                        side: const BorderSide(
                                            color: ThemeConstants.primaryColor),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: const Text('Back'),
                                    )
                                  : const SizedBox(),
                            ),
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_currentStep < 4) {
                                    setState(() {
                                      _currentStep++;
                                    });
                                  } else {
                                    _saveAssetLiability();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ThemeConstants.primaryColor,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(100, 48),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text(
                                    _currentStep == 4 ? 'Save' : 'Continue'),
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

  Widget _buildTypeStepContent() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final types = widget.isAsset
        ? [
            'Cash',
            'Bank',
            'Real Estate',
            'Trading Balance',
            'Stocks',
            'Mutual Funds',
            'Bonds',
            'ETFs',
            'CryptoCurrencies',
            'Retirement Accounts',
            'Business',
            'Intellectual Properties',
            'Receivables',
            'Others'
          ]
        : [
            'Credit Card',
            'Personal Loan',
            'Home Loan',
            'Car Loan',
            'Student Loan',
            'Business Loan',
            'Bank Overdraft',
            'Unpaid Taxes',
            'Payables',
            'Others'
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDarkMode
                    ? ThemeConstants.textPrimaryDark
                    : ThemeConstants.textPrimaryLight,
              ),
        ),
        const SizedBox(height: 16),
        ...types.map(
          (type) => ListTile(
            title: Text(
              type,
              style: TextStyle(
                color: isDarkMode
                    ? ThemeConstants.textPrimaryDark
                    : ThemeConstants.textPrimaryLight,
              ),
            ),
            leading: Radio<String>(
              value: type,
              groupValue: _type,
              activeColor: ThemeConstants.primaryColor,
              onChanged: (value) {
                setState(() => _type = value!);
              },
            ),
          ),
        ),
        if (_type == 'Other')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Custom Type',
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
                setState(() {
                  _type = value;
                });
              },
            ),
          ),
      ],
    );
  }

  Widget _buildAmountStepContent() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Value/Amount',
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
            labelText: widget.isAsset ? 'Asset Value' : 'Liability Amount',
            border: const OutlineInputBorder(),
            helperText:
                widget.isAsset ? 'Current market value' : 'Outstanding amount',
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
      ],
    );
  }

  Widget _buildDetailsStepContent() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDarkMode
                    ? ThemeConstants.textPrimaryDark
                    : ThemeConstants.textPrimaryLight,
              ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Name/Description',
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
            setState(() {
              _name = value;
            });
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Purchase/Start Date',
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.calendar_today),
            labelStyle: TextStyle(
              color: isDarkMode
                  ? ThemeConstants.textSecondaryDark
                  : ThemeConstants.textSecondaryLight,
            ),
          ),
          readOnly: true,
          controller: TextEditingController(
            text: '${_startDate.day}/${_startDate.month}/${_startDate.year}',
          ),
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _startDate,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              setState(() {
                _startDate = picked;
              });
            }
          },
          style: TextStyle(
            color: isDarkMode
                ? ThemeConstants.textPrimaryDark
                : ThemeConstants.textPrimaryLight,
          ),
        ),
        if (!widget.isAsset) ...[
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Interest Rate (%)',
              border: const OutlineInputBorder(),
              suffixText: '%',
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
              setState(() {
                _interestRate = double.tryParse(value);
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Payment Schedule',
              border: const OutlineInputBorder(),
              labelStyle: TextStyle(
                color: isDarkMode
                    ? ThemeConstants.textSecondaryDark
                    : ThemeConstants.textSecondaryLight,
              ),
            ),
            value: _paymentSchedule,
            hint: const Text('Select payment frequency'),
            items: ['Monthly', 'Quarterly', 'Yearly']
                .map((schedule) => DropdownMenuItem(
                      value: schedule,
                      child: Text(schedule),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _paymentSchedule = value;
              });
            },
            style: TextStyle(
              color: isDarkMode
                  ? ThemeConstants.textPrimaryDark
                  : ThemeConstants.textPrimaryLight,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAttachmentsStepContent() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Documents/Attachments',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDarkMode
                    ? ThemeConstants.textPrimaryDark
                    : ThemeConstants.textPrimaryLight,
              ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () async {
            // Implement file picking logic
            // You'll need to add file_picker package for this
            // final result = await FilePicker.platform.pickFiles();
            // if (result != null) {
            //   setState(() {
            //     _attachments.add(result.files.single.path!);
            //   });
            // }
          },
          icon: const Icon(Icons.attach_file),
          label: const Text('Add Document'),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isDarkMode ? ThemeConstants.cardDark : Colors.grey[200],
            foregroundColor:
                isDarkMode ? ThemeConstants.textPrimaryDark : Colors.grey[800],
          ),
        ),
        if (_attachments.isNotEmpty) ...[
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _attachments.length,
            itemBuilder: (context, index) {
              final attachment = _attachments[index];
              return ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: Text(
                  attachment.split('/').last,
                  style: TextStyle(
                    color: isDarkMode
                        ? ThemeConstants.textPrimaryDark
                        : Colors.grey[800],
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _attachments.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildTrackingStepContent() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final trackingOptions = [
      'Value Updates',
      'Payment Reminders',
      'Document Expiry',
      'Interest Rate Changes',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tracking Preferences',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDarkMode
                    ? ThemeConstants.textPrimaryDark
                    : ThemeConstants.textPrimaryLight,
              ),
        ),
        const SizedBox(height: 16),
        ...trackingOptions.map(
          (option) => CheckboxListTile(
            title: Text(
              option,
              style: TextStyle(
                color: isDarkMode
                    ? ThemeConstants.textPrimaryDark
                    : ThemeConstants.textPrimaryLight,
              ),
            ),
            value: _trackingPreferences.contains(option),
            onChanged: (bool? value) {
              setState(() {
                if (value ?? false) {
                  _trackingPreferences.add(option);
                } else {
                  _trackingPreferences.remove(option);
                }
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Custom Tracking Note',
            border: const OutlineInputBorder(),
            helperText: 'Add any specific tracking requirements',
            labelStyle: TextStyle(
              color: isDarkMode
                  ? ThemeConstants.textSecondaryDark
                  : ThemeConstants.textSecondaryLight,
            ),
          ),
          maxLines: 2,
          style: TextStyle(
            color: isDarkMode
                ? ThemeConstants.textPrimaryDark
                : ThemeConstants.textPrimaryLight,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                _trackingPreferences.add('Custom: $value');
              });
            }
          },
        ),
      ],
    );
  }

  void _saveAssetLiability() {
    if (_formKey.currentState?.validate() ?? false) {
      final assetLiability = {
        'type': _type,
        'amount': _amount,
        'name': _name,
        'startDate': _startDate,
        'isAsset': widget.isAsset,
        if (!widget.isAsset) ...{
          'interestRate': _interestRate,
          'paymentSchedule': _paymentSchedule,
        },
        'attachments': _attachments,
        'trackingPreferences': _trackingPreferences,
      };

      Navigator.pop(context, assetLiability);
    }
  }
}
