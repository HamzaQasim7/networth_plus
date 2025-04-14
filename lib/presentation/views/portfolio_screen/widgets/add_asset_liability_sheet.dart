import 'package:finance_tracker/core/constants/app_constants.dart';
import 'package:finance_tracker/core/utils/motion_toast.dart';
import 'package:finance_tracker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../viewmodels/asset_liability_viewmodel.dart';
import '../../../../data/models/asset_liability_model.dart';

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
    return Consumer<AssetLiabilityViewModel>(
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Material(
              color: Theme.of(context).brightness == Brightness.dark
                  ? ThemeConstants.surfaceDark
                  : Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: _buildMainContent(context),
            ),
            if (viewModel.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (viewModel.error != null)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          viewModel.error!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: viewModel.clearError,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDragHandle(),
          _buildTitleBar(),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Expanded(
                            child: Container(
                              height: 4,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: index <= _currentStep
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey[700]
                                        : Colors.grey[300],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          );
                        }),
                      ),
                      const Gap(24),
                      if (_currentStep == 0) _buildTypeStepContent(),
                      if (_currentStep == 1) _buildAmountStepContent(),
                      if (_currentStep == 2) _buildDetailsStepContent(),
                      if (_currentStep == 3) _buildAttachmentsStepContent(),
                      if (_currentStep == 4) _buildTrackingStepContent(),
                      const Gap(24),
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
                                minimumSize: const Size(100, 48),
                              ),
                              child:
                                  Text(_currentStep == 4 ? 'Save' : 'Continue'),
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
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[700]
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildTitleBar() {
    return Consumer<AssetLiabilityViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Add ${widget.isAsset ? "Asset" : "Liability"}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ThemeConstants.textPrimaryDark
                            : ThemeConstants.textPrimaryLight,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Gap(8),
              SizedBox(
                width: 80,
                child: TextButton(
                  onPressed: viewModel.isLoading ? null : _saveAssetLiability,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: viewModel.isLoading
                          ? Colors.grey
                          : (_currentStep == 4
                              ? ThemeConstants.primaryColor
                              : Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[600]
                                  : Colors.grey[400]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTypeStepContent() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final types =
        widget.isAsset ? AppConstants.assetsList : AppConstants.liabilityList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildReusableText('Type'),
        const Gap(16),
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
            child: CustomTextField(
              labelText: 'Enter Custom Type',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildReusableText('Value/Amount'),
        const Gap(16),
        CustomTextField(
          keyboardType: TextInputType.number,
          prefixText: '₹ ',
          labelText: widget.isAsset ? 'Asset Value' : 'Liability Amount',
          helperText:
              widget.isAsset ? 'Current market value' : 'Outstanding amount',
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
        buildReusableText('Details'),
        const SizedBox(height: 16),
        CustomTextField(
          labelText: 'Name/Description',
          onChanged: (value) {
            setState(() {
              _name = value;
            });
          },
        ),
        const Gap(16),
        CustomTextField(
          labelText: 'Purchase/Start Date',
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
        ),
        if (!widget.isAsset) ...[
          const Gap(16),
          CustomTextField(
            keyboardType: TextInputType.number,
            labelText: 'Interest Rate (%)',
            suffixText: '%',
            onChanged: (value) {
              setState(() {
                _interestRate = double.tryParse(value);
              });
            },
          ),
          const Gap(16),
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
        buildReusableText('Documents/Attachments'),
        const Gap(16),
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
          const Gap(16),
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
        const Gap(16),
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
        const Gap(16),
        CustomTextField(
          labelText: 'Custom Tracking Note',
          maxLines: 2,
          helperText: 'Add any specific tracking requirements',
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
      if (!mounted) return;

      final viewModel =
          Provider.of<AssetLiabilityViewModel>(context, listen: false);

      final newItem = AssetLiabilityModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: viewModel.authViewModel.currentUser!.id,
        isAsset: widget.isAsset,
        type: _type,
        amount: _amount,
        name: _name,
        startDate: _startDate,
        interestRate: _interestRate,
        paymentSchedule: _paymentSchedule,
        attachments: _attachments,
        trackingPreferences: _trackingPreferences,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
      );

      viewModel.createAssetLiability(newItem).then((success) {
        if (mounted && success) {
          Navigator.pop(context);
          ToastUtils.showSuccessToast(context,
              title: 'Success',
              description:
                  '${widget.isAsset ? "Asset" : "Liability"} added successfully');
        }
      });
    }
  }

  Widget buildReusableText(String text) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isDarkMode
                ? ThemeConstants.textPrimaryDark
                : ThemeConstants.textPrimaryLight,
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
