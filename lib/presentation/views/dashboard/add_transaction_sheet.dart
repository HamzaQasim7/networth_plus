import 'package:finance_tracker/core/constants/categories_list.dart';
import 'package:finance_tracker/core/constants/theme_constants.dart';
import 'package:finance_tracker/data/models/transaction_model.dart';
import 'package:finance_tracker/viewmodels/transaction_viewmodel.dart';
import 'package:finance_tracker/widgets/custom_button.dart';
import 'package:finance_tracker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/console.dart';
import '../../../core/utils/motion_toast.dart';
import '../../../viewmodels/account_card_viewmodel.dart';
import '../../../widgets/custom_loader.dart';
import '../cards/add_card_sheet.dart';

class AddTransactionSheet extends StatefulWidget {
  final bool isEditing;
  final TransactionModel? transaction;
  final Future<void> Function(TransactionModel)? onSave;

  const AddTransactionSheet({
    super.key,
    this.isEditing = false,
    this.transaction,
    this.onSave,
  });

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  // Form Controllers
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  // Transaction State
  bool isIncome = false;
  bool isTransfer = false;
  String? selectedCategory;
  String? selectedPaymentMethod;
  DateTime selectedDate = DateTime.now();
  double? availableBudget;

  // Recurring Transaction State
  bool isRecurring = false;
  String recurringFrequency = 'Monthly';

  // Split Transaction State
  bool isSplitTransaction = false;
  String splitType = 'Equal';
  List<Map<String, dynamic>> splitWith = [];

  // Custom Categories
  final List<Map<String, dynamic>> _customCategories = [];

  // Constants
  static const _availableIcons = [
    FontAwesome.tag_solid,
    FontAwesome.bag_shopping_solid,
    FontAwesome.burger_solid,
    FontAwesome.cart_shopping_solid,
    FontAwesome.house_solid,
    FontAwesome.car_solid,
    FontAwesome.heart_pulse_solid,
    FontAwesome.graduation_cap_solid,
    FontAwesome.plane_solid,
    FontAwesome.money_bill_solid,
    FontAwesome.gift_solid,
    FontAwesome.shirt_solid,
    FontAwesome.phone_solid,
    FontAwesome.futbol_solid,
    FontAwesome.palette_solid,
  ];

  static const _paymentMethods = [
    'Debit Card',
    'Credit Card',
    'Cash Wallet',
    'EWallet',
  ];

  static const _recurringFrequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  void initState() {
    super.initState();
    _initializeDateTime();
    if (widget.isEditing && widget.transaction != null) {
      _initializeEditingMode();
    }
  }

  void _initializeDateTime() {
    _dateController.text = DateFormat('MMM d, yyyy').format(selectedDate);
    _timeController.text = DateFormat('hh:mm a').format(selectedDate);
  }

  void _initializeEditingMode() {
    final transaction = widget.transaction!;
    setState(() {
      isIncome = transaction.type==TransactionType.income;
      selectedCategory = transaction.category;
      _amountController.text = transaction.amount.toString();
      _descriptionController.text = transaction.description ?? '';
      selectedDate = transaction.date;
      selectedPaymentMethod = transaction.paymentMethod;
      _initializeDateTime();
    });
    _updateAvailableBudget(selectedCategory);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  // UI Building Methods
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<TransactionViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.error == 'Unauthorized') {
            return const Center(
              child: Text('Unauthorized'),
            );
          }
          if (viewModel.isLoading) {
            return const Center(child: CustomLoadingOverlay());
          }

          return Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    const Gap(24),
                    _buildTransactionTypeSelector(),
                    const Gap(16),
                    if (!isTransfer) ...[
                      _buildTransactionForm(),
                    ] else ...[
                      _buildTransferForm(),
                    ],
                    const Gap(24),
                    if (viewModel.error != null) ...[
                      Text(
                        viewModel.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const Gap(16),
                    ],
                    _buildSubmitButton(),
                    const Gap(16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isTransfer ? 'Transfer Money' : 'Add Transaction',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Iconsax.tag_cross_bold),
        ),
      ],
    );
  }

  Widget _buildTransactionTypeSelector() {
    return Row(
      children: [
        _buildTypeChip(
          label: 'Expense',
          isSelected: !isIncome && !isTransfer,
          color: Colors.red[400]!,
          onSelected: (_) => setState(() {
            isIncome = false;
            isTransfer = false;
            selectedCategory = null;
          }),
        ),
        const Gap(8),
        _buildTypeChip(
          label: 'Income',
          isSelected: isIncome && !isTransfer,
          color: ThemeConstants.primaryColor,
          onSelected: (_) => setState(() {
            isIncome = true;
            isTransfer = false;
            selectedCategory = null;
          }),
        ),
        const Gap(8),
        _buildTypeChip(
          label: 'Transfer',
          isSelected: isTransfer,
          color: Theme.of(context).colorScheme.primary,
          onSelected: (_) => setState(() {
            isTransfer = true;
            selectedCategory = null;
          }),
        ),
      ],
    );
  }

  Widget _buildTypeChip({
    required String label,
    required bool isSelected,
    required Color color,
    required Function(bool) onSelected,
  }) {
    return Expanded(
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: onSelected,
        selectedColor: color.withOpacity(0.8),
        backgroundColor: color.withOpacity(0.1),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : color,
          fontWeight: FontWeight.bold,
        ),
        side: BorderSide(color: isSelected ? Colors.white : color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildTransactionForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategorySelector(),
        const Gap(16),
        _buildAmountField(),
        const Gap(16),
        _buildDescriptionField(),
        const Gap(16),
        _buildDateTimePicker(),
        const Gap(16),
        _buildPaymentMethodField(),
        if (!isTransfer) ...[
          const Gap(16),
          _buildRecurringSection(),
          const Gap(16),
          _buildSplitSection(),
        ],
      ],
    );
  }

  Widget _buildTransferForm() {
    return Column(
      children: [
        _buildAccountDropdown('From Account'),
        const Gap(16),
        _buildAccountDropdown('To Account'),
        const Gap(16),
        const CustomTextField(
          labelText: 'Transfer Amount',
          hintText: 'Enter amount to transfer',
          icon: Iconsax.money_2_bold,
          keyboardType: TextInputType.number,
        ),
        const Gap(16),
        _buildDescriptionField(),
        const Gap(16),
        _buildDateTimePicker(),
      ],
    );
  }

  Widget _buildAccountDropdown(String label) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.account_balance_wallet),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: _paymentMethods
          .map((method) => DropdownMenuItem(
                value: method,
                child: Text(method),
              ))
          .toList(),
      onChanged: (value) => setState(() => selectedPaymentMethod = value),
    );
  }

  // Helper Methods for UI Components
  Widget _buildCategorySelector() {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(text: selectedCategory),
      decoration: InputDecoration(
        labelText: 'Category',
        prefixIcon: const Icon(Iconsax.category_2_bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: const Icon(Iconsax.arrow_down_1_bold),
      ),
      onTap: _showCategoryBottomSheet,
    );
  }

  Widget _buildAmountField() {
    final viewModel = context.read<TransactionViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: _amountController,
          labelText: 'Amount',
          hintText: 'Enter amount',
          icon: Iconsax.money_2_bold,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an amount';
            }
            final amount = double.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Please enter a valid amount';
            }
            if (!isIncome && amount > viewModel.availableBalance) {
              return 'Amount exceeds available balance';
            }
            return null;
          },
        ),
        if (!isIncome) ...[
          const Gap(4),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Available Balance: ₹${viewModel.availableBalance.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withOpacity(0.5),
                    fontSize: 12,
                  ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDescriptionField() {
    return CustomTextField(
      controller: _descriptionController,
      labelText: 'Description',
      hintText: 'Enter description',
      icon: Iconsax.note_1_bold,
      maxLines: 3,
    );
  }

  Widget _buildDateTimePicker() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _buildDateField(),
        ),
        const Gap(5),
        Expanded(
          child: _buildTimeField(),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Date',
        prefixIcon: const Icon(Iconsax.calendar_1_bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          setState(() {
            selectedDate = DateTime(
              date.year,
              date.month,
              date.day,
              selectedDate.hour,
              selectedDate.minute,
            );
            _dateController.text =
                DateFormat('MMM d, yyyy').format(selectedDate);
          });
        }
      },
    );
  }

  Widget _buildTimeField() {
    return TextFormField(
      controller: _timeController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Time',
        prefixIcon: const Icon(Iconsax.clock_bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate),
        );
        if (time != null) {
          setState(() {
            selectedDate = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              time.hour,
              time.minute,
            );
            _timeController.text = DateFormat('hh:mm a').format(selectedDate);
          });
        }
      },
    );
  }

  Widget _buildPaymentMethodField() {
    final accountViewModel = context.watch<AccountCardViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Payment Method',
            prefixIcon: const Icon(Icons.payment_rounded),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          value: selectedPaymentMethod ?? 'Cash Wallet',
          items: [
            const DropdownMenuItem(
                value: 'Cash Wallet', child: Text('Cash Wallet')),
            ...accountViewModel.accountCards.map((card) =>
                DropdownMenuItem(value: card.name, child: Text(card.name))),
            const DropdownMenuItem(
              value: 'add_new',
              child: Row(
                children: [
                  Icon(Icons.add),
                  Gap(8),
                  Text('Add New Account'),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            if (value == 'add_new') {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const AddCardSheet(),
              ).then((_) {
                // Reset to previous selection or Cash Wallet
                setState(() => selectedPaymentMethod =
                    selectedPaymentMethod ?? 'Cash Wallet');
              });
            } else {
              setState(() => selectedPaymentMethod = value);
            }
          },
          validator: (value) =>
              value == null ? 'Please select a payment method' : null,
        ),
      ],
    );
  }

  Widget _buildRecurringSection() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Recurring Transaction'),
          value: isRecurring,
          onChanged: (value) => setState(() => isRecurring = value),
        ),
        if (isRecurring) ...[
          const Gap(8),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Frequency',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            value: recurringFrequency,
            items: _recurringFrequencies
                .map((freq) => DropdownMenuItem(
                      value: freq,
                      child: Text(freq),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() => recurringFrequency = value!);
            },
          ),
        ],
      ],
    );
  }

  Widget _buildSplitSection() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Split Transaction'),
          value: isSplitTransaction,
          onChanged: (value) => setState(() => isSplitTransaction = value),
        ),
        if (isSplitTransaction) ...[
          const Gap(8),
          _buildSplitTypeSelector(),
          const Gap(8),
          _buildSplitMembersList(),
        ],
      ],
    );
  }

  Widget _buildSubmitButton() {
    return CustomButton(
      onPressed: _handleSubmit,
      child: Text(
        widget.isEditing
            ? 'Update Transaction'
            : (isTransfer ? 'Transfer Money' : 'Save Transaction'),
      ),
    );
  }

  // Action Methods
  void _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final viewModel = context.read<TransactionViewModel>();
      console('Handle button Testing', type: DebugType.info);
      try {
        final transaction = TransactionModel(
          id: widget.isEditing ? widget.transaction!.id : const Uuid().v4(),
          userId: viewModel.currentUserId ?? '',
          amount: double.tryParse(_amountController.text) ?? 0.0,
          type: isIncome ? TransactionType.income : TransactionType.expense,
          category: selectedCategory ?? 'Uncategorized',
          description: _descriptionController.text,
          date: selectedDate,
          paymentMethod: selectedPaymentMethod ?? 'Cash Wallet',
          isRecurring: isRecurring,
          recurringFrequency: isRecurring ? recurringFrequency : null,
          splitWith: isSplitTransaction ? splitWith : null,
        );
        console('Transaction: ${transaction.description}',
            type: DebugType.response);
        bool success;
        if (widget.isEditing) {
          success = await viewModel.updateTransaction(transaction);
        } else {
          success = await viewModel.addTransaction(transaction);
        }

        if (success && mounted) {
          Navigator.pop(context);
          ToastUtils.showSuccessToast(context,
              title: 'Success',
              description: widget.isEditing
                  ? 'Transaction updated successfully'
                  : 'Transaction added successfully');
        }
      } catch (e) {
        if (mounted) {
          console('$e', type: DebugType.error);
          ToastUtils.showErrorToast(context,
              title: 'Failed', description: 'Error: ${e.toString()}');
        }
      }
    }
  }

  dynamic _getSelectedIcon() {
    if (selectedCategory == null) return Icons.category;
    return (CategoryList.categories.firstWhere(
      (cat) => cat['title'] == selectedCategory,
      orElse: () => _customCategories.firstWhere(
        (cat) => cat['title'] == selectedCategory,
        orElse: () => {'icon': Icons.category},
      ),
    ))['icon'];
  }

  void _showCategoryBottomSheet() {
    final baseCategories = isIncome
        ? CategoryList.categories.sublist(0, 9)
        : CategoryList.categories.sublist(9);

    final allCategories = [...baseCategories, ..._customCategories];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Category',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _showAddCategoryDialog();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('New Category'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: allCategories.length,
                itemBuilder: (context, index) {
                  final category = allCategories[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = category['title'];
                        _updateAvailableBudget(category['title']);
                      });
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedCategory == category['title']
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'],
                            size: 28,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Gap(8),
                          Text(
                            category['title'],
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCategoryDialog() {
    final formKey = GlobalKey<FormState>();
    String categoryName = '';
    IconData selectedIcon = FontAwesome.tag_solid; // Default icon

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text('Add New Category'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a name' : null,
                onChanged: (value) => categoryName = value,
              ),
              const Gap(16),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: _availableIcons.length,
                  itemBuilder: (context, index) {
                    final icon = _availableIcons[index];
                    return IconButton(
                      onPressed: () {
                        selectedIcon = icon;
                        (context as Element).markNeedsBuild();
                      },
                      icon: Icon(
                        icon,
                        color: selectedIcon == icon
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                // Add the new category to custom categories
                final newCategory = {
                  "title": categoryName,
                  "icon": selectedIcon,
                };

                setState(() {
                  _customCategories.add(newCategory);
                });

                Navigator.pop(context);
                _showCategoryBottomSheet(); // Reopen category selector
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _updateAvailableBudget(String? category) {
    if (category == null) {
      setState(() {
        availableBudget = null;
      });
      return;
    }
    // Mock budget data - replace with actual budget fetching logic
    setState(() {
      availableBudget = 1000.0; // Example budget
    });
  }

  void _showAddAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Account Name',
              ),
            ),
            const Gap(16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Account Type',
              ),
              items: ['Bank Account', 'Credit Card', 'Cash']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add account logic here
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddSplitMemberDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text('Add Person to Split'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name or Email',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                splitWith.add({
                  'name': 'New Person',
                  'percentage':
                      splitType == 'Equal' ? 100 / (splitWith.length + 2) : 0,
                });
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Text('Split Equally'),
            selected: splitType == 'Equal',
            onSelected: (selected) => setState(() => splitType = 'Equal'),
          ),
        ),
        const Gap(8),
        Expanded(
          child: ChoiceChip(
            label: const Text('Custom Split'),
            selected: splitType == 'Custom',
            onSelected: (selected) => setState(() => splitType = 'Custom'),
          ),
        ),
      ],
    );
  }

  Widget _buildSplitMembersList() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _showAddSplitMemberDialog,
          icon: const Icon(Icons.person_add),
          label: const Text('Add Person to Split'),
        ),
        if (splitWith.isNotEmpty) ...[
          const Gap(8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: splitWith.length,
            itemBuilder: (context, index) {
              final person = splitWith[index];
              return ListTile(
                title: Text(person['name']),
                trailing: splitType == 'Custom'
                    ? SizedBox(
                        width: 100,
                        child: TextField(
                          decoration: const InputDecoration(suffix: Text('%')),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => setState(() => splitWith[index]
                              ['percentage'] = double.tryParse(value) ?? 0),
                        ),
                      )
                    : Text('${100 / (splitWith.length + 1)}%'),
                leading: const CircleAvatar(child: Icon(Icons.person)),
              );
            },
          ),
        ],
      ],
    );
  }
}
