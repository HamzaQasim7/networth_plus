import 'package:currency_picker/currency_picker.dart';
import 'package:finance_tracker/core/services/session_manager.dart';
import 'package:finance_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/routes.dart';

class CurrencyPickerScreen extends StatefulWidget {
  const CurrencyPickerScreen({super.key});

  @override
  State<CurrencyPickerScreen> createState() => _CurrencyPickerScreenState();
}

class _CurrencyPickerScreenState extends State<CurrencyPickerScreen> {
  Currency? selectedCurrency;

  void _selectCurrency(BuildContext context, String currency) async {
    final sessionManager = context.read<SessionManager>();
    await sessionManager.setSelectedCurrency(currency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(40),
              Text(
                'Select Your Currency',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const Gap(16),
              Text(
                'Choose your preferred currency to get started. '
                'This will be used for all your financial transactions and reports.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
              ),
              const Gap(24),
              if (selectedCurrency != null) ...[
                const SizedBox(height: 24),
                Text(
                  'Selected Currency: ${selectedCurrency!.code}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    CustomButton(
                      onPressed: () {
                        showCurrencyPicker(
                          context: context,
                          showFlag: true,
                          showCurrencyName: true,
                          showCurrencyCode: true,
                          theme: CurrencyPickerThemeData(
                            flagSize: 25,
                            titleTextStyle:
                                Theme.of(context).textTheme.titleLarge,
                            subtitleTextStyle:
                                Theme.of(context).textTheme.bodyMedium,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          onSelect: (Currency currency) {
                            setState(() {
                              selectedCurrency = currency;
                            });
                            _selectCurrency(context, currency.code);
                          },
                        );
                      },
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        selectedCurrency == null
                            ? 'Select Currency'
                            : 'Change Currency',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (selectedCurrency != null) ...[
                      const Gap(16),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.dashboard);
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}
