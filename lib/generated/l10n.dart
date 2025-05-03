// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Finance Manager`
  String get appTitle {
    return Intl.message(
      'Finance Manager',
      name: 'appTitle',
      desc: 'The title of the application',
      args: [],
    );
  }

  /// `Dashboard`
  String get homeTitle {
    return Intl.message(
      'Dashboard',
      name: 'homeTitle',
      desc: 'Title for the home screen',
      args: [],
    );
  }

  /// `Transactions`
  String get transactionsTitle {
    return Intl.message(
      'Transactions',
      name: 'transactionsTitle',
      desc: 'Title for the transactions screen',
      args: [],
    );
  }

  /// `Budget`
  String get budgetTitle {
    return Intl.message(
      'Budget',
      name: 'budgetTitle',
      desc: 'Title for the budget screen',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: 'Title for the settings screen',
      args: [],
    );
  }

  /// `Language`
  String get languageTitle {
    return Intl.message(
      'Language',
      name: 'languageTitle',
      desc: 'Title for the language selection option',
      args: [],
    );
  }

  /// `Income`
  String get incomeLabel {
    return Intl.message(
      'Income',
      name: 'incomeLabel',
      desc: 'Label for income',
      args: [],
    );
  }

  /// `Expenses`
  String get expenseLabel {
    return Intl.message(
      'Expenses',
      name: 'expenseLabel',
      desc: 'Label for expenses',
      args: [],
    );
  }

  /// `Balance`
  String get balanceLabel {
    return Intl.message(
      'Balance',
      name: 'balanceLabel',
      desc: 'Label for balance',
      args: [],
    );
  }

  /// `Savings`
  String get savingsLabel {
    return Intl.message(
      'Savings',
      name: 'savingsLabel',
      desc: 'Label for savings',
      args: [],
    );
  }

  /// `Investments`
  String get investmentsLabel {
    return Intl.message(
      'Investments',
      name: 'investmentsLabel',
      desc: 'Label for investments',
      args: [],
    );
  }

  /// `Add Transaction`
  String get addTransaction {
    return Intl.message(
      'Add Transaction',
      name: 'addTransaction',
      desc: 'Button to add a new transaction',
      args: [],
    );
  }

  /// `Category`
  String get categoryLabel {
    return Intl.message(
      'Category',
      name: 'categoryLabel',
      desc: 'Label for category',
      args: [],
    );
  }

  /// `Amount`
  String get amountLabel {
    return Intl.message(
      'Amount',
      name: 'amountLabel',
      desc: 'Label for amount',
      args: [],
    );
  }

  /// `Date`
  String get dateLabel {
    return Intl.message(
      'Date',
      name: 'dateLabel',
      desc: 'Label for date',
      args: [],
    );
  }

  /// `Notes`
  String get notesLabel {
    return Intl.message(
      'Notes',
      name: 'notesLabel',
      desc: 'Label for notes',
      args: [],
    );
  }

  /// `Save`
  String get saveButton {
    return Intl.message(
      'Save',
      name: 'saveButton',
      desc: 'Save button text',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelButton {
    return Intl.message(
      'Cancel',
      name: 'cancelButton',
      desc: 'Cancel button text',
      args: [],
    );
  }

  /// `System Default`
  String get systemDefault {
    return Intl.message(
      'System Default',
      name: 'systemDefault',
      desc: 'System default language option',
      args: [],
    );
  }

  /// `Net Worth`
  String get netWorth {
    return Intl.message(
      'Net Worth',
      name: 'netWorth',
      desc: 'Net Worth label',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
