import 'package:finance_tracker/core/constants/console.dart';
import 'package:finance_tracker/core/utils/helpers.dart';
import 'package:finance_tracker/widgets/custom_loader.dart';
import 'package:finance_tracker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../viewmodels/account_card_viewmodel.dart';
import '../../../data/models/account_card_model.dart';
import '../../../core/utils/motion_toast.dart';

class AddCardSheet extends StatefulWidget {
  final AccountCardModel? card;
  final bool isEditing;

  const AddCardSheet({
    super.key,
    this.card,
    this.isEditing = false,
  });

  @override
  State<AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<AddCardSheet> {
  final _formKey = GlobalKey<FormState>();
  late String _cardType;
  late String _cardName;
  late String _cardNumber;
  late double _balance;
  late Color _cardColor;
  late IconData _cardIcon;

  @override
  void initState() {
    super.initState();
    _cardType = widget.card?.type ?? 'Bank Account';
    _cardName = widget.card?.name ?? '';
    _cardNumber = widget.card?.number ?? '';
    _balance = widget.card?.balance ?? 0.0;
    _cardColor = widget.card?.color ?? Colors.blue;
    _cardIcon = widget.card?.icon ?? Icons.account_balance;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDarkMode ? ThemeConstants.surfaceDark : Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.isEditing
                      ? 'Edit Card/Account'
                      : 'Add New Card/Account',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? ThemeConstants.textPrimaryDark
                            : ThemeConstants.textPrimaryLight,
                      ),
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  value: _cardType,
                  decoration: InputDecoration(
                    labelText: 'Type',
                    border: const OutlineInputBorder(),
                    labelStyle: TextStyle(
                      color: isDarkMode
                          ? ThemeConstants.textSecondaryDark
                          : ThemeConstants.textSecondaryLight,
                    ),
                  ),
                  items:
                      ['Bank Account', 'Credit Card', 'Debit Card', 'E-Wallet']
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                  onChanged: (value) {
                    setState(() => _cardType = value!);
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  initialValue: _cardName,
                  labelText: 'Name',
                  onChanged: (value) => _cardName = value,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter a name' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  initialValue: _cardNumber,
                  labelText: 'Card/Account Number',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _cardNumber = value,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter a number' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  initialValue: _balance.toString(),
                  labelText: 'Balance',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _balance = double.tryParse(value) ?? 0,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter balance' : null,
                ),
                const SizedBox(height: 16),
                _buildColorSelector(),
                const SizedBox(height: 16),
                _buildIconSelector(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveCard,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(widget.isEditing ? 'Update Card' : 'Add Card'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorSelector() {
    final colors = [
      Colors.blue,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Card Color'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: colors.map((color) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _cardColor = color;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        _cardColor == color ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildIconSelector() {
    final icons = [
      Icons.account_balance,
      Icons.credit_card,
      Icons.account_balance_wallet,
      Icons.savings,
      Icons.payment,
      Icons.monetization_on,
      Icons.money,
      Icons.business,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Card Icon'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: icons.map((icon) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _cardIcon = icon;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _cardIcon == icon
                      ? _cardColor.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: _cardIcon == icon ? _cardColor : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _saveCard() async {
    if (_formKey.currentState?.validate() ?? false) {
      final viewModel = context.read<AccountCardViewModel>();
      if (viewModel.isLoading) {
        const CustomLoadingOverlay();
        console('DEBUG: ViewModel is already loading, skipping save operation');
        return;
      }

      print('DEBUG: Starting card save operation');
      print('DEBUG: Card type: $_cardType');
      print('DEBUG: Card name: $_cardName');
      print('DEBUG: Card number: $_cardNumber');
      print('DEBUG: Card balance: $_balance');

      try {
        bool success;

        if (widget.isEditing && widget.card != null) {
          // Update existing card
          print('DEBUG: Updating existing card with ID: ${widget.card!.id}');
          final updatedCard = widget.card!.copyWith(
            name: _cardName,
            number: _cardNumber,
            type: _cardType,
            balance: _balance,
            color: _cardColor,
            icon: _cardIcon,
          );

          success = await viewModel.updateAccountCard(updatedCard);
        } else {
          // Create new card
          print('DEBUG: Creating new card');
          success = await viewModel.createAccountCard(
            name: _cardName,
            number: _cardNumber,
            type: _cardType,
            balance: _balance,
            color: _cardColor,
            icon: _cardIcon,
          );
        }

        print('DEBUG: Card operation result: $success');

        if (success && mounted) {
          Navigator.pop(context);
          ToastUtils.showSuccessToast(
            context,
            title: 'Success',
            description: widget.isEditing
                ? 'Card updated successfully'
                : 'Card added successfully',
          );
        }
      } catch (e) {
        print('DEBUG: Error saving card: $e');
        if (mounted) {
          ToastUtils.showErrorToast(
            context,
            title: 'Error',
            description: e.toString(),
          );
        }
      }
    } else {
      print('DEBUG: Form validation failed');
    }
  }
}
