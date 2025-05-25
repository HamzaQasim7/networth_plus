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

  /// `Portfolio`
  String get portfolio {
    return Intl.message(
      'Portfolio',
      name: 'portfolio',
      desc: 'Label for portfolio section',
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

  /// `Notifications`
  String get notificationsTitle {
    return Intl.message(
      'Notifications',
      name: 'notificationsTitle',
      desc: 'Title for the notifications screen',
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
      desc: 'Label for the balance field',
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

  /// `Yearly Growth`
  String get yearlyGrowth {
    return Intl.message(
      'Yearly Growth',
      name: 'yearlyGrowth',
      desc: 'Label for yearly growth',
      args: [],
    );
  }

  /// `vs Last Year`
  String get vsLastYear {
    return Intl.message(
      'vs Last Year',
      name: 'vsLastYear',
      desc: 'Label for comparison with the previous year',
      args: [],
    );
  }

  /// `Growth Trend`
  String get growthTrend {
    return Intl.message(
      'Growth Trend',
      name: 'growthTrend',
      desc: 'Label for growth trend',
      args: [],
    );
  }

  /// `Your Cards & Accounts`
  String get yourCardsAndAccounts {
    return Intl.message(
      'Your Cards & Accounts',
      name: 'yourCardsAndAccounts',
      desc: 'Label for the section displaying cards and accounts',
      args: [],
    );
  }

  /// `Retry`
  String get retryButton {
    return Intl.message(
      'Retry',
      name: 'retryButton',
      desc: 'Button text for retrying an action',
      args: [],
    );
  }

  /// `Add New Card`
  String get addNewCard {
    return Intl.message(
      'Add New Card',
      name: 'addNewCard',
      desc: 'Button text for adding a new card',
      args: [],
    );
  }

  /// `Available balance`
  String get availableBalance {
    return Intl.message(
      'Available balance',
      name: 'availableBalance',
      desc: 'Label for available balance',
      args: [],
    );
  }

  /// `Cash`
  String get cashLabel {
    return Intl.message(
      'Cash',
      name: 'cashLabel',
      desc: 'Label for cash balance',
      args: [],
    );
  }

  /// `Bank`
  String get bankLabel {
    return Intl.message(
      'Bank',
      name: 'bankLabel',
      desc: 'Label for bank balance',
      args: [],
    );
  }

  /// `Upcoming payments`
  String get upcomingPayments {
    return Intl.message(
      'Upcoming payments',
      name: 'upcomingPayments',
      desc: 'Label for upcoming payments section',
      args: [],
    );
  }

  /// `No upcoming payments`
  String get noUpcomingPayments {
    return Intl.message(
      'No upcoming payments',
      name: 'noUpcomingPayments',
      desc: 'Message displayed when there are no upcoming payments',
      args: [],
    );
  }

  /// `Last 30 days`
  String get last30Days {
    return Intl.message(
      'Last 30 days',
      name: 'last30Days',
      desc: 'Label for the last 30 days section',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message(
      'Income',
      name: 'income',
      desc: 'Label for income section',
      args: [],
    );
  }

  /// `Expense`
  String get expense {
    return Intl.message(
      'Expense',
      name: 'expense',
      desc: 'Label for expense section',
      args: [],
    );
  }

  /// `Savings`
  String get savings {
    return Intl.message(
      'Savings',
      name: 'savings',
      desc: 'Label for savings section',
      args: [],
    );
  }

  /// `What would you like to add?`
  String get whatWouldYouLikeToAdd {
    return Intl.message(
      'What would you like to add?',
      name: 'whatWouldYouLikeToAdd',
      desc: 'Prompt asking the user what they would like to add',
      args: [],
    );
  }

  /// `Add Asset`
  String get addAsset {
    return Intl.message(
      'Add Asset',
      name: 'addAsset',
      desc: 'Button or label for adding an asset',
      args: [],
    );
  }

  /// `Add Liability`
  String get addLiability {
    return Intl.message(
      'Add Liability',
      name: 'addLiability',
      desc: 'Button or label for adding a liability',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: 'Label for the report section',
      args: [],
    );
  }

  /// `Settle Up`
  String get settleUp {
    return Intl.message(
      'Settle Up',
      name: 'settleUp',
      desc: 'Button or label for settling up transactions',
      args: [],
    );
  }

  /// `By Category`
  String get byCategory {
    return Intl.message(
      'By Category',
      name: 'byCategory',
      desc: 'Filter option for categorizing items',
      args: [],
    );
  }

  /// `By Date Range`
  String get byDateRange {
    return Intl.message(
      'By Date Range',
      name: 'byDateRange',
      desc: 'Filter option for selecting a date range',
      args: [],
    );
  }

  /// `By Amount`
  String get byAmount {
    return Intl.message(
      'By Amount',
      name: 'byAmount',
      desc: 'Filter option for selecting by amount',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: 'Label for available items or balance',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: 'Label for error messages or titles',
      args: [],
    );
  }

  /// `No transactions found`
  String get noTransactionsFound {
    return Intl.message(
      'No transactions found',
      name: 'noTransactionsFound',
      desc: 'Message displayed when no transactions are available',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: 'Label for selecting a payment method',
      args: [],
    );
  }

  /// `Settlement`
  String get settlement {
    return Intl.message(
      'Settlement',
      name: 'settlement',
      desc: 'Label for settlement details or description',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: 'Label for edit action or button',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: 'Label for the delete action',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: 'Label for success messages or titles',
      args: [],
    );
  }

  /// `Transaction updated successfully`
  String get transactionUpdatedSuccessfully {
    return Intl.message(
      'Transaction updated successfully',
      name: 'transactionUpdatedSuccessfully',
      desc: 'Message displayed when a transaction is successfully updated',
      args: [],
    );
  }

  /// `Delete Transaction`
  String get deleteTransaction {
    return Intl.message(
      'Delete Transaction',
      name: 'deleteTransaction',
      desc: 'Label for delete transaction action or button',
      args: [],
    );
  }

  /// `Are you sure you want to delete this transaction?`
  String get confirmDeleteTransaction {
    return Intl.message(
      'Are you sure you want to delete this transaction?',
      name: 'confirmDeleteTransaction',
      desc: 'Confirmation message for deleting a transaction',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Label for cancel action or button',
      args: [],
    );
  }

  /// `Transaction deleted successfully`
  String get transactionDeletedSuccessfully {
    return Intl.message(
      'Transaction deleted successfully',
      name: 'transactionDeletedSuccessfully',
      desc: 'Message displayed when a transaction is successfully deleted',
      args: [],
    );
  }

  /// `Spending by Category`
  String get spendingByCategory {
    return Intl.message(
      'Spending by Category',
      name: 'spendingByCategory',
      desc: 'Title for the spending by category chart',
      args: [],
    );
  }

  /// `No expense data available for selected period`
  String get noExpenseDataAvailable {
    return Intl.message(
      'No expense data available for selected period',
      name: 'noExpenseDataAvailable',
      desc:
          'Message displayed when there is no expense data for the selected period',
      args: [],
    );
  }

  /// `Financial Summary`
  String get financialSummary {
    return Intl.message(
      'Financial Summary',
      name: 'financialSummary',
      desc: 'Title for the financial summary section',
      args: [],
    );
  }

  /// `Total Income`
  String get totalIncome {
    return Intl.message(
      'Total Income',
      name: 'totalIncome',
      desc: 'Label for total income',
      args: [],
    );
  }

  /// `Total Expenses`
  String get totalExpenses {
    return Intl.message(
      'Total Expenses',
      name: 'totalExpenses',
      desc: 'Label for total expenses',
      args: [],
    );
  }

  /// `Net Savings`
  String get netSavings {
    return Intl.message(
      'Net Savings',
      name: 'netSavings',
      desc: 'Label for net savings',
      args: [],
    );
  }

  /// `Operation Failed`
  String get operationFailed {
    return Intl.message(
      'Operation Failed',
      name: 'operationFailed',
      desc: 'Message displayed when an operation fails',
      args: [],
    );
  }

  /// `Add New Settlement`
  String get addNewSettlement {
    return Intl.message(
      'Add New Settlement',
      name: 'addNewSettlement',
      desc: 'Button or label for adding a new settlement',
      args: [],
    );
  }

  /// `No settlements found`
  String get noSettlementsFound {
    return Intl.message(
      'No settlements found',
      name: 'noSettlementsFound',
      desc: 'Message displayed when no settlements are available',
      args: [],
    );
  }

  /// `You owe`
  String get youOwe {
    return Intl.message(
      'You owe',
      name: 'youOwe',
      desc: 'Label indicating that the user owes someone',
      args: [],
    );
  }

  /// `Owes you`
  String get owesYou {
    return Intl.message(
      'Owes you',
      name: 'owesYou',
      desc: 'Label indicating that someone owes the user',
      args: [],
    );
  }

  /// `Person Name`
  String get personName {
    return Intl.message(
      'Person Name',
      name: 'personName',
      desc: 'Label for entering or displaying a person\'s name',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: 'Label for entering or displaying an amount',
      args: [],
    );
  }

  /// `They Owe Me`
  String get theyOweMe {
    return Intl.message(
      'They Owe Me',
      name: 'theyOweMe',
      desc: 'Label indicating that someone owes the user',
      args: [],
    );
  }

  /// `I Owe Them`
  String get iOweThem {
    return Intl.message(
      'I Owe Them',
      name: 'iOweThem',
      desc: 'Label indicating that the user owes someone',
      args: [],
    );
  }

  /// `Invalid Input`
  String get invalidInput {
    return Intl.message(
      'Invalid Input',
      name: 'invalidInput',
      desc: 'Message displayed when the user provides invalid input',
      args: [],
    );
  }

  /// `Please enter a name`
  String get pleaseEnterAName {
    return Intl.message(
      'Please enter a name',
      name: 'pleaseEnterAName',
      desc: 'Message prompting the user to enter a name',
      args: [],
    );
  }

  /// `Invalid Amount`
  String get invalidAmount {
    return Intl.message(
      'Invalid Amount',
      name: 'invalidAmount',
      desc: 'Message indicating that the entered amount is invalid',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get pleaseEnterAValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'pleaseEnterAValidNumber',
      desc: 'Message prompting the user to enter a valid number',
      args: [],
    );
  }

  /// `Settlement added successfully`
  String get settlementAddedSuccessfully {
    return Intl.message(
      'Settlement added successfully',
      name: 'settlementAddedSuccessfully',
      desc: 'Message displayed when a settlement is successfully added',
      args: [],
    );
  }

  /// `Add Settlement`
  String get addSettlement {
    return Intl.message(
      'Add Settlement',
      name: 'addSettlement',
      desc: 'Button or label for adding a settlement',
      args: [],
    );
  }

  /// `Related Transactions`
  String get relatedTransactions {
    return Intl.message(
      'Related Transactions',
      name: 'relatedTransactions',
      desc: 'Label for the section displaying related transactions',
      args: [],
    );
  }

  /// `Payment marked as completed`
  String get paymentMarkedAsCompleted {
    return Intl.message(
      'Payment marked as completed',
      name: 'paymentMarkedAsCompleted',
      desc:
          'Message displayed when a payment is successfully marked as completed',
      args: [],
    );
  }

  /// `Reminder sent successfully`
  String get reminderSentSuccessfully {
    return Intl.message(
      'Reminder sent successfully',
      name: 'reminderSentSuccessfully',
      desc: 'Message displayed when a reminder is successfully sent',
      args: [],
    );
  }

  /// `Pay Now`
  String get payNow {
    return Intl.message(
      'Pay Now',
      name: 'payNow',
      desc: 'Button or label for initiating a payment',
      args: [],
    );
  }

  /// `Remind`
  String get remind {
    return Intl.message(
      'Remind',
      name: 'remind',
      desc: 'Button or label for sending a reminder',
      args: [],
    );
  }

  /// `Budgeted Categories`
  String get budgetedCategories {
    return Intl.message(
      'Budgeted Categories',
      name: 'budgetedCategories',
      desc: 'Label for the section displaying budgeted categories',
      args: [],
    );
  }

  /// `No budgets available for this month.`
  String get noBudgetsAvailable {
    return Intl.message(
      'No budgets available for this month.',
      name: 'noBudgetsAvailable',
      desc:
          'Message displayed when there are no budgets available for the selected month',
      args: [],
    );
  }

  /// `Delete Budget`
  String get deleteBudget {
    return Intl.message(
      'Delete Budget',
      name: 'deleteBudget',
      desc: 'Label for the delete budget action or button',
      args: [],
    );
  }

  /// `Are you sure you want to delete this budget?`
  String get confirmDeleteBudget {
    return Intl.message(
      'Are you sure you want to delete this budget?',
      name: 'confirmDeleteBudget',
      desc: 'Confirmation message for deleting a budget',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: 'Label for the overview section',
      args: [],
    );
  }

  /// `Financial health:`
  String get financialHealth {
    return Intl.message(
      'Financial health:',
      name: 'financialHealth',
      desc: 'Label for financial health section or metric',
      args: [],
    );
  }

  /// `Portfolio Analysis`
  String get portfolioAnalysis {
    return Intl.message(
      'Portfolio Analysis',
      name: 'portfolioAnalysis',
      desc: 'Label for the portfolio analysis section',
      args: [],
    );
  }

  /// `Net Worth Trend`
  String get netWorthTrend {
    return Intl.message(
      'Net Worth Trend',
      name: 'netWorthTrend',
      desc: 'Label for the net worth trend section',
      args: [],
    );
  }

  /// `Track your net worth changes over time`
  String get trackNetWorthChanges {
    return Intl.message(
      'Track your net worth changes over time',
      name: 'trackNetWorthChanges',
      desc: 'Label for tracking net worth changes over time',
      args: [],
    );
  }

  /// `Asset Performance`
  String get assetPerformance {
    return Intl.message(
      'Asset Performance',
      name: 'assetPerformance',
      desc: 'Label for the asset performance section',
      args: [],
    );
  }

  /// `Analyze your assets growth and distribution`
  String get analyzeAssetsGrowth {
    return Intl.message(
      'Analyze your assets growth and distribution',
      name: 'analyzeAssetsGrowth',
      desc: 'Label for analyzing assets growth and distribution',
      args: [],
    );
  }

  /// `Liability Analysis`
  String get liabilityAnalysis {
    return Intl.message(
      'Liability Analysis',
      name: 'liabilityAnalysis',
      desc: 'Label for the liability analysis section',
      args: [],
    );
  }

  /// `Monitor your debt and repayment progress`
  String get monitorDebtProgress {
    return Intl.message(
      'Monitor your debt and repayment progress',
      name: 'monitorDebtProgress',
      desc: 'Label for monitoring debt and repayment progress',
      args: [],
    );
  }

  /// `Financial Insights`
  String get financialInsights {
    return Intl.message(
      'Financial Insights',
      name: 'financialInsights',
      desc: 'Label for the financial insights section',
      args: [],
    );
  }

  /// `Get personalized recommendations`
  String get personalizedRecommendations {
    return Intl.message(
      'Get personalized recommendations',
      name: 'personalizedRecommendations',
      desc: 'Label for personalized recommendations section',
      args: [],
    );
  }

  /// `Net Worth Trends`
  String get netWorthTrends {
    return Intl.message(
      'Net Worth Trends',
      name: 'netWorthTrends',
      desc: 'Label for the net worth trends section',
      args: [],
    );
  }

  /// `Current Net Worth`
  String get currentNetWorth {
    return Intl.message(
      'Current Net Worth',
      name: 'currentNetWorth',
      desc: 'Label for the current net worth section',
      args: [],
    );
  }

  /// `1M Growth`
  String get oneMonthGrowth {
    return Intl.message(
      '1M Growth',
      name: 'oneMonthGrowth',
      desc: 'Label for one-month growth metric',
      args: [],
    );
  }

  /// `6M Growth`
  String get sixMonthGrowth {
    return Intl.message(
      '6M Growth',
      name: 'sixMonthGrowth',
      desc: 'Label for six-month growth metric',
      args: [],
    );
  }

  /// `1Y Growth`
  String get oneYearGrowth {
    return Intl.message(
      '1Y Growth',
      name: 'oneYearGrowth',
      desc: 'Label for one-year growth metric',
      args: [],
    );
  }

  /// `Net Worth History`
  String get netWorthHistory {
    return Intl.message(
      'Net Worth History',
      name: 'netWorthHistory',
      desc: 'Label for the net worth history section',
      args: [],
    );
  }

  /// `Monthly Breakdown`
  String get monthlyBreakdown {
    return Intl.message(
      'Monthly Breakdown',
      name: 'monthlyBreakdown',
      desc: 'Label for the monthly breakdown section',
      args: [],
    );
  }

  /// `Asset Distribution`
  String get assetDistribution {
    return Intl.message(
      'Asset Distribution',
      name: 'assetDistribution',
      desc: 'Label for the asset distribution section',
      args: [],
    );
  }

  /// `Total Liabilities`
  String get totalLiabilities {
    return Intl.message(
      'Total Liabilities',
      name: 'totalLiabilities',
      desc: 'Label for the total liabilities section',
      args: [],
    );
  }

  /// `Monthly EMIs`
  String get monthlyEmis {
    return Intl.message(
      'Monthly EMIs',
      name: 'monthlyEmis',
      desc: 'Label for the monthly EMIs section',
      args: [],
    );
  }

  /// `Debt Ratio`
  String get debtRatio {
    return Intl.message(
      'Debt Ratio',
      name: 'debtRatio',
      desc: 'Label for the debt ratio section',
      args: [],
    );
  }

  /// `Debt Distribution`
  String get debtDistribution {
    return Intl.message(
      'Debt Distribution',
      name: 'debtDistribution',
      desc: 'Label for the debt distribution section',
      args: [],
    );
  }

  /// `Loan Details`
  String get loanDetails {
    return Intl.message(
      'Loan Details',
      name: 'loanDetails',
      desc: 'Label for the loan details section',
      args: [],
    );
  }

  /// `Financial Health Score`
  String get financialHealthScore {
    return Intl.message(
      'Financial Health Score',
      name: 'financialHealthScore',
      desc: 'Label for the financial health score section',
      args: [],
    );
  }

  /// `Key Metrics`
  String get keyMetrics {
    return Intl.message(
      'Key Metrics',
      name: 'keyMetrics',
      desc: 'Label for the key metrics section',
      args: [],
    );
  }

  /// `Recommendations`
  String get recommendations {
    return Intl.message(
      'Recommendations',
      name: 'recommendations',
      desc: 'Label for the recommendations section',
      args: [],
    );
  }

  /// `EMI`
  String get emiLabel {
    return Intl.message(
      'EMI',
      name: 'emiLabel',
      desc: 'Label for EMI (Equated Monthly Installment)',
      args: [],
    );
  }

  /// `Interest`
  String get interestLabel {
    return Intl.message(
      'Interest',
      name: 'interestLabel',
      desc: 'Label for interest rate',
      args: [],
    );
  }

  /// `Remaining`
  String get remainingLabel {
    return Intl.message(
      'Remaining',
      name: 'remainingLabel',
      desc: 'Label for remaining loan term in months',
      args: [],
    );
  }

  /// `Build Emergency Fund`
  String get buildEmergencyFund {
    return Intl.message(
      'Build Emergency Fund',
      name: 'buildEmergencyFund',
      desc: 'Label for building an emergency fund recommendation',
      args: [],
    );
  }

  /// `Increase emergency fund to cover 6 months of expenses`
  String get increaseEmergencyFund {
    return Intl.message(
      'Increase emergency fund to cover 6 months of expenses',
      name: 'increaseEmergencyFund',
      desc: 'Label for increasing emergency fund recommendation',
      args: [],
    );
  }

  /// `Reduce Debt`
  String get reduceDebt {
    return Intl.message(
      'Reduce Debt',
      name: 'reduceDebt',
      desc: 'Label for reducing debt recommendation',
      args: [],
    );
  }

  /// `Focus on paying down high-interest debt to improve financial health`
  String get focusOnHighInterestDebt {
    return Intl.message(
      'Focus on paying down high-interest debt to improve financial health',
      name: 'focusOnHighInterestDebt',
      desc: 'Recommendation to focus on paying down high-interest debt',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: 'Label for high priority',
      args: [],
    );
  }

  /// `Increase Savings`
  String get increaseSavings {
    return Intl.message(
      'Increase Savings',
      name: 'increaseSavings',
      desc: 'Label for increasing savings recommendation',
      args: [],
    );
  }

  /// `Optimize Investments`
  String get optimizeInvestments {
    return Intl.message(
      'Optimize Investments',
      name: 'optimizeInvestments',
      desc: 'Label for optimizing investments recommendation',
      args: [],
    );
  }

  /// `Consider diversifying your investment portfolio`
  String get considerDiversifyingInvestments {
    return Intl.message(
      'Consider diversifying your investment portfolio',
      name: 'considerDiversifyingInvestments',
      desc: 'Recommendation to consider diversifying the investment portfolio',
      args: [],
    );
  }

  /// `Maintain Financial Health`
  String get maintainFinancialHealth {
    return Intl.message(
      'Maintain Financial Health',
      name: 'maintainFinancialHealth',
      desc: 'Recommendation to maintain good financial habits',
      args: [],
    );
  }

  /// `Continue good financial habits to stay on track`
  String get continueGoodHabits {
    return Intl.message(
      'Continue good financial habits to stay on track',
      name: 'continueGoodHabits',
      desc: 'Recommendation to continue good financial habits',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: 'Label for low priority',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: 'Label for medium priority',
      args: [],
    );
  }

  /// `Top Assets`
  String get topAssets {
    return Intl.message(
      'Top Assets',
      name: 'topAssets',
      desc: 'Label for the top assets section',
      args: [],
    );
  }

  /// `Top Liabilities`
  String get topLiabilities {
    return Intl.message(
      'Top Liabilities',
      name: 'topLiabilities',
      desc: 'Label for the top liabilities section',
      args: [],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message(
      'Undo',
      name: 'undo',
      desc: 'Label for undo action or button',
      args: [],
    );
  }

  /// `Total Budget`
  String get totalBudget {
    return Intl.message(
      'Total Budget',
      name: 'totalBudget',
      desc: 'Label for total budget',
      args: [],
    );
  }

  /// `Spent`
  String get spent {
    return Intl.message(
      'Spent',
      name: 'spent',
      desc: 'Label for spent amount',
      args: [],
    );
  }

  /// `Remaining`
  String get remaining {
    return Intl.message(
      'Remaining',
      name: 'remaining',
      desc: 'Label for remaining amount',
      args: [],
    );
  }

  /// `Edit Card/Account`
  String get editCardAccount {
    return Intl.message(
      'Edit Card/Account',
      name: 'editCardAccount',
      desc: 'Label for editing a card or account',
      args: [],
    );
  }

  /// `Add New Card/Account`
  String get addNewCardAccount {
    return Intl.message(
      'Add New Card/Account',
      name: 'addNewCardAccount',
      desc: 'Button text for adding a new card or account',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: 'Label for selecting the type of card or account',
      args: [],
    );
  }

  /// `Card/Account Number`
  String get cardAccountNumber {
    return Intl.message(
      'Card/Account Number',
      name: 'cardAccountNumber',
      desc: 'Label for the card or account number field',
      args: [],
    );
  }

  /// `Please enter balance`
  String get pleaseEnterBalance {
    return Intl.message(
      'Please enter balance',
      name: 'pleaseEnterBalance',
      desc: 'Message prompting the user to enter a balance',
      args: [],
    );
  }

  /// `Update Card`
  String get updateCard {
    return Intl.message(
      'Update Card',
      name: 'updateCard',
      desc: 'Button text for updating an existing card',
      args: [],
    );
  }

  /// `Add Card`
  String get addCard {
    return Intl.message(
      'Add Card',
      name: 'addCard',
      desc: 'Button text for adding a new card',
      args: [],
    );
  }

  /// `Card Icon`
  String get cardIcon {
    return Intl.message(
      'Card Icon',
      name: 'cardIcon',
      desc: 'Label for selecting a card icon',
      args: [],
    );
  }

  /// `Card updated successfully`
  String get cardUpdatedSuccessfully {
    return Intl.message(
      'Card updated successfully',
      name: 'cardUpdatedSuccessfully',
      desc: 'Message displayed when a card is successfully updated',
      args: [],
    );
  }

  /// `Card added successfully`
  String get cardAddedSuccessfully {
    return Intl.message(
      'Card added successfully',
      name: 'cardAddedSuccessfully',
      desc: 'Message displayed when a card is successfully added',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: 'Label for update action or button',
      args: [],
    );
  }

  /// `Card Color`
  String get cardColor {
    return Intl.message(
      'Card Color',
      name: 'cardColor',
      desc: 'Label for Card Color',
      args: [],
    );
  }

  /// `Save more to build a stronger financial foundation`
  String get saveMoreToBuildFoundation {
    return Intl.message(
      'Save more to build a stronger financial foundation',
      name: 'saveMoreToBuildFoundation',
      desc: 'Recommendation to save more for a stronger financial foundation',
      args: [],
    );
  }

  /// `Unauthorized`
  String get unauthorized {
    return Intl.message(
      'Unauthorized',
      name: 'unauthorized',
      desc: 'Message displayed when the user is unauthorized',
      args: [],
    );
  }

  /// `Transfer Money`
  String get transferMoney {
    return Intl.message(
      'Transfer Money',
      name: 'transferMoney',
      desc: 'Label for transferring money',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message(
      'Transfer',
      name: 'transfer',
      desc: 'Label for the transfer action',
      args: [],
    );
  }

  /// `From Account`
  String get fromAccount {
    return Intl.message(
      'From Account',
      name: 'fromAccount',
      desc: 'Label for selecting the source account',
      args: [],
    );
  }

  /// `To Account`
  String get toAccount {
    return Intl.message(
      'To Account',
      name: 'toAccount',
      desc: 'Label for selecting the destination account',
      args: [],
    );
  }

  /// `Transfer Amount`
  String get transferAmount {
    return Intl.message(
      'Transfer Amount',
      name: 'transferAmount',
      desc: 'Label for the amount to be transferred',
      args: [],
    );
  }

  /// `Enter amount to transfer`
  String get enterAmountToTransfer {
    return Intl.message(
      'Enter amount to transfer',
      name: 'enterAmountToTransfer',
      desc:
          'Placeholder or message prompting the user to enter the transfer amount',
      args: [],
    );
  }

  /// `Available Budget`
  String get availableBudget {
    return Intl.message(
      'Available Budget',
      name: 'availableBudget',
      desc: 'Label for available budget',
      args: [],
    );
  }

  /// `Enter amount`
  String get enterAmount {
    return Intl.message(
      'Enter amount',
      name: 'enterAmount',
      desc: 'Placeholder or message prompting the user to enter an amount',
      args: [],
    );
  }

  /// `Please enter an amount`
  String get pleaseEnterAnAmount {
    return Intl.message(
      'Please enter an amount',
      name: 'pleaseEnterAnAmount',
      desc: 'Message prompting the user to enter an amount',
      args: [],
    );
  }

  /// `Please enter a valid amount greater than 0`
  String get pleaseEnterAValidAmount {
    return Intl.message(
      'Please enter a valid amount greater than 0',
      name: 'pleaseEnterAValidAmount',
      desc: 'Message prompting the user to enter a valid amount greater than 0',
      args: [],
    );
  }

  /// `Please add income first!`
  String get pleaseAddIncomeFirst {
    return Intl.message(
      'Please add income first!',
      name: 'pleaseAddIncomeFirst',
      desc: 'Message prompting the user to add income before proceeding',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: 'Label for description field',
      args: [],
    );
  }

  /// `Enter description`
  String get enterDescription {
    return Intl.message(
      'Enter description',
      name: 'enterDescription',
      desc: 'Placeholder or message prompting the user to enter a description',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: 'Label for selecting a date',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: 'Label for selecting a time',
      args: [],
    );
  }

  /// `Cash Wallet`
  String get cashWallet {
    return Intl.message(
      'Cash Wallet',
      name: 'cashWallet',
      desc: 'Label for the cash wallet payment method',
      args: [],
    );
  }

  /// `Add New Account`
  String get addNewAccount {
    return Intl.message(
      'Add New Account',
      name: 'addNewAccount',
      desc: 'Button text for adding a new account',
      args: [],
    );
  }

  /// `Please select a payment method`
  String get pleaseSelectAPaymentMethod {
    return Intl.message(
      'Please select a payment method',
      name: 'pleaseSelectAPaymentMethod',
      desc: 'Message prompting the user to select a payment method',
      args: [],
    );
  }

  /// `Recurring Transaction`
  String get recurringTransaction {
    return Intl.message(
      'Recurring Transaction',
      name: 'recurringTransaction',
      desc: 'Label for enabling or disabling recurring transactions',
      args: [],
    );
  }

  /// `Frequency`
  String get frequency {
    return Intl.message(
      'Frequency',
      name: 'frequency',
      desc: 'Label for selecting the frequency of a transaction',
      args: [],
    );
  }

  /// `Split Transaction`
  String get splitTransaction {
    return Intl.message(
      'Split Transaction',
      name: 'splitTransaction',
      desc: 'Label for splitting a transaction',
      args: [],
    );
  }

  /// `Update Transaction`
  String get updateTransaction {
    return Intl.message(
      'Update Transaction',
      name: 'updateTransaction',
      desc: 'Label for updating a transaction',
      args: [],
    );
  }

  /// `Save Transaction`
  String get saveTransaction {
    return Intl.message(
      'Save Transaction',
      name: 'saveTransaction',
      desc: 'Label for saving a transaction',
      args: [],
    );
  }

  /// `Transaction added successfully`
  String get transactionAddedSuccessfully {
    return Intl.message(
      'Transaction added successfully',
      name: 'transactionAddedSuccessfully',
      desc: 'Message displayed when a transaction is successfully added',
      args: [],
    );
  }

  /// `Select Category`
  String get selectCategory {
    return Intl.message(
      'Select Category',
      name: 'selectCategory',
      desc: 'Label for selecting a category',
      args: [],
    );
  }

  /// `New Category`
  String get newCategory {
    return Intl.message(
      'New Category',
      name: 'newCategory',
      desc: 'Label for creating a new category',
      args: [],
    );
  }

  /// `Add New Category`
  String get addNewCategory {
    return Intl.message(
      'Add New Category',
      name: 'addNewCategory',
      desc: 'Button text for adding a new category',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryName {
    return Intl.message(
      'Category Name',
      name: 'categoryName',
      desc: 'Label for entering the name of a category',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: 'Button text for adding an item',
      args: [],
    );
  }

  /// `Account Name`
  String get accountName {
    return Intl.message(
      'Account Name',
      name: 'accountName',
      desc: 'Label for entering the name of an account',
      args: [],
    );
  }

  /// `Account Type`
  String get accountType {
    return Intl.message(
      'Account Type',
      name: 'accountType',
      desc: 'Label for selecting the type of account',
      args: [],
    );
  }

  /// `Bank Account`
  String get bankAccount {
    return Intl.message(
      'Bank Account',
      name: 'bankAccount',
      desc: 'Label for bank account type',
      args: [],
    );
  }

  /// `Credit Card`
  String get creditCard {
    return Intl.message(
      'Credit Card',
      name: 'creditCard',
      desc: 'Label for credit card type',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: 'Label for cash type',
      args: [],
    );
  }

  /// `Add Person to Split`
  String get addPersonToSplit {
    return Intl.message(
      'Add Person to Split',
      name: 'addPersonToSplit',
      desc: 'Button text for adding a person to split',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: 'Label for the name field',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'Label for entering a person\'s email',
      args: [],
    );
  }

  /// `Please enter the email`
  String get pleaseEnterTheEmail {
    return Intl.message(
      'Please enter the email',
      name: 'pleaseEnterTheEmail',
      desc: 'Message prompting the user to enter an email',
      args: [],
    );
  }

  /// `Split Equally`
  String get splitEqually {
    return Intl.message(
      'Split Equally',
      name: 'splitEqually',
      desc: 'Label for the split equally option',
      args: [],
    );
  }

  /// `Custom Split`
  String get customSplit {
    return Intl.message(
      'Custom Split',
      name: 'customSplit',
      desc: 'Label for the custom split option',
      args: [],
    );
  }

  /// `Budget Period`
  String get budgetPeriod {
    return Intl.message(
      'Budget Period',
      name: 'budgetPeriod',
      desc: 'Label for selecting the budget period',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: 'Label for the monthly budget period',
      args: [],
    );
  }

  /// `Quarterly`
  String get quarterly {
    return Intl.message(
      'Quarterly',
      name: 'quarterly',
      desc: 'Label for the quarterly budget period',
      args: [],
    );
  }

  /// `Yearly`
  String get yearly {
    return Intl.message(
      'Yearly',
      name: 'yearly',
      desc: 'Label for the yearly budget period',
      args: [],
    );
  }

  /// `Custom`
  String get custom {
    return Intl.message(
      'Custom',
      name: 'custom',
      desc: 'Label for the custom budget period',
      args: [],
    );
  }

  /// `Alerts & Notifications`
  String get alertsAndNotifications {
    return Intl.message(
      'Alerts & Notifications',
      name: 'alertsAndNotifications',
      desc: 'Label for the alerts and notifications section',
      args: [],
    );
  }

  /// `80% of budget used`
  String get eightyPercentBudgetUsed {
    return Intl.message(
      '80% of budget used',
      name: 'eightyPercentBudgetUsed',
      desc: 'Notification message for 80% of the budget being used',
      args: [],
    );
  }

  /// `90% of budget used`
  String get ninetyPercentBudgetUsed {
    return Intl.message(
      '90% of budget used',
      name: 'ninetyPercentBudgetUsed',
      desc: 'Notification message for 90% of the budget being used',
      args: [],
    );
  }

  /// `Budget exceeded`
  String get budgetExceeded {
    return Intl.message(
      'Budget exceeded',
      name: 'budgetExceeded',
      desc: 'Notification message for when the budget is exceeded',
      args: [],
    );
  }

  /// `Budget Amount`
  String get budgetAmount {
    return Intl.message(
      'Budget Amount',
      name: 'budgetAmount',
      desc: 'Label for entering the budget amount',
      args: [],
    );
  }

  /// `Enter Budget Amount`
  String get enterBudgetAmount {
    return Intl.message(
      'Enter Budget Amount',
      name: 'enterBudgetAmount',
      desc:
          'Placeholder or message prompting the user to enter a budget amount',
      args: [],
    );
  }

  /// `Set your budget limit for this category`
  String get setYourBudgetLimit {
    return Intl.message(
      'Set your budget limit for this category',
      name: 'setYourBudgetLimit',
      desc: 'Message prompting the user to set a budget limit for a category',
      args: [],
    );
  }

  /// `Please enter a budget amount`
  String get pleaseEnterABudgetAmount {
    return Intl.message(
      'Please enter a budget amount',
      name: 'pleaseEnterABudgetAmount',
      desc: 'Message prompting the user to enter a budget amount',
      args: [],
    );
  }

  /// `Amount must be greater than 0`
  String get amountMustBeGreaterThanZero {
    return Intl.message(
      'Amount must be greater than 0',
      name: 'amountMustBeGreaterThanZero',
      desc: 'Message indicating that the amount must be greater than 0',
      args: [],
    );
  }

  /// `Amount is too large`
  String get amountIsTooLarge {
    return Intl.message(
      'Amount is too large',
      name: 'amountIsTooLarge',
      desc: 'Message indicating that the entered amount is too large',
      args: [],
    );
  }

  /// `Recurring Options`
  String get recurringOptions {
    return Intl.message(
      'Recurring Options',
      name: 'recurringOptions',
      desc: 'Label for recurring budget options',
      args: [],
    );
  }

  /// `Make this budget recurring?`
  String get makeThisBudgetRecurring {
    return Intl.message(
      'Make this budget recurring?',
      name: 'makeThisBudgetRecurring',
      desc: 'Prompt asking if the budget should be made recurring',
      args: [],
    );
  }

  /// `Budget will automatically reset each period`
  String get budgetWillResetEachPeriod {
    return Intl.message(
      'Budget will automatically reset each period',
      name: 'budgetWillResetEachPeriod',
      desc: 'Message indicating that the budget will reset each period',
      args: [],
    );
  }

  /// `Budget will automatically reset at the beginning of each period`
  String get budgetWillResetAtBeginning {
    return Intl.message(
      'Budget will automatically reset at the beginning of each period',
      name: 'budgetWillResetAtBeginning',
      desc:
          'Message indicating that the budget will reset at the start of each period',
      args: [],
    );
  }

  /// `Carry over remaining balance`
  String get carryOverRemainingBalance {
    return Intl.message(
      'Carry over remaining balance',
      name: 'carryOverRemainingBalance',
      desc: 'Option to carry over the remaining balance to the next period',
      args: [],
    );
  }

  /// `Collaborators`
  String get collaborators {
    return Intl.message(
      'Collaborators',
      name: 'collaborators',
      desc: 'Label for the collaborators section',
      args: [],
    );
  }

  /// `Add Collaborators`
  String get addCollaborators {
    return Intl.message(
      'Add Collaborators',
      name: 'addCollaborators',
      desc: 'Button text for adding collaborators',
      args: [],
    );
  }

  /// `Share this budget with others`
  String get shareThisBudget {
    return Intl.message(
      'Share this budget with others',
      name: 'shareThisBudget',
      desc: 'Message prompting the user to share the budget with others',
      args: [],
    );
  }

  /// `Add Collaborator`
  String get addCollaborator {
    return Intl.message(
      'Add Collaborator',
      name: 'addCollaborator',
      desc: 'Button text for adding a single collaborator',
      args: [],
    );
  }

  /// `Enter email or name`
  String get enterEmailOrName {
    return Intl.message(
      'Enter email or name',
      name: 'enterEmailOrName',
      desc:
          'Placeholder or message prompting the user to enter an email or name',
      args: [],
    );
  }

  /// `Validation Error`
  String get validationError {
    return Intl.message(
      'Validation Error',
      name: 'validationError',
      desc: 'Label for validation error messages',
      args: [],
    );
  }

  /// `Please fill in all required fields`
  String get pleaseFillRequiredFields {
    return Intl.message(
      'Please fill in all required fields',
      name: 'pleaseFillRequiredFields',
      desc: 'Message prompting the user to fill in all required fields',
      args: [],
    );
  }

  /// `Invalid Date Range`
  String get invalidDateRange {
    return Intl.message(
      'Invalid Date Range',
      name: 'invalidDateRange',
      desc: 'Message indicating that the selected date range is invalid',
      args: [],
    );
  }

  /// `Start date must be before end date`
  String get startDateBeforeEndDate {
    return Intl.message(
      'Start date must be before end date',
      name: 'startDateBeforeEndDate',
      desc:
          'Message indicating that the start date must be earlier than the end date',
      args: [],
    );
  }

  /// `Duplicate Budget`
  String get duplicateBudget {
    return Intl.message(
      'Duplicate Budget',
      name: 'duplicateBudget',
      desc:
          'Message indicating that a budget for the category already exists in the selected month',
      args: [],
    );
  }

  /// `Failed to save budget. Please try again.`
  String get failedToSaveBudget {
    return Intl.message(
      'Failed to save budget. Please try again.',
      name: 'failedToSaveBudget',
      desc: 'Message displayed when saving the budget fails',
      args: [],
    );
  }

  /// `Budget updated successfully`
  String get budgetUpdatedSuccessfully {
    return Intl.message(
      'Budget updated successfully',
      name: 'budgetUpdatedSuccessfully',
      desc: 'Message displayed when a budget is successfully updated',
      args: [],
    );
  }

  /// `Budget created successfully`
  String get budgetCreatedSuccessfully {
    return Intl.message(
      'Budget created successfully',
      name: 'budgetCreatedSuccessfully',
      desc: 'Message displayed when a budget is successfully created',
      args: [],
    );
  }

  /// `Set Budget`
  String get setBudget {
    return Intl.message(
      'Set Budget',
      name: 'setBudget',
      desc: 'Button text for setting a budget',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: 'Button text for saving',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: 'Button text for going back',
      args: [],
    );
  }

  /// `Continue`
  String get continueButton {
    return Intl.message(
      'Continue',
      name: 'continueButton',
      desc: 'Button text for continuing to the next step',
      args: [],
    );
  }

  /// `Enter Custom Category`
  String get enterCustomCategory {
    return Intl.message(
      'Enter Custom Category',
      name: 'enterCustomCategory',
      desc: 'Label for entering a custom category',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message(
      'Start Date',
      name: 'startDate',
      desc: 'Label for selecting the start date',
      args: [],
    );
  }

  /// `End Date`
  String get endDate {
    return Intl.message(
      'End Date',
      name: 'endDate',
      desc: 'Label for selecting the end date',
      args: [],
    );
  }

  /// `Custom Alert Threshold (%)`
  String get customAlertThreshold {
    return Intl.message(
      'Custom Alert Threshold (%)',
      name: 'customAlertThreshold',
      desc: 'Label for entering a custom alert threshold percentage',
      args: [],
    );
  }

  /// `Enter a custom percentage for alerts`
  String get enterCustomPercentage {
    return Intl.message(
      'Enter a custom percentage for alerts',
      name: 'enterCustomPercentage',
      desc: 'Helper text for entering a custom alert percentage',
      args: [],
    );
  }

  /// `Required Field`
  String get requiredField {
    return Intl.message(
      'Required Field',
      name: 'requiredField',
      desc: 'Message indicating that a required field is missing',
      args: [],
    );
  }

  /// `Please select a category`
  String get pleaseSelectACategory {
    return Intl.message(
      'Please select a category',
      name: 'pleaseSelectACategory',
      desc: 'Message prompting the user to select a category',
      args: [],
    );
  }

  /// `Budget amount must be greater than 0`
  String get budgetAmountMustBeGreaterThanZero {
    return Intl.message(
      'Budget amount must be greater than 0',
      name: 'budgetAmountMustBeGreaterThanZero',
      desc:
          'Message indicating that the budget amount must be greater than zero',
      args: [],
    );
  }

  /// `Start date must be before end date`
  String get startDateMustBeBeforeEndDate {
    return Intl.message(
      'Start date must be before end date',
      name: 'startDateMustBeBeforeEndDate',
      desc:
          'Message indicating that the start date must be earlier than the end date',
      args: [],
    );
  }

  /// `Budget period must be at least 1 day`
  String get budgetPeriodMustBeAtLeastOneDay {
    return Intl.message(
      'Budget period must be at least 1 day',
      name: 'budgetPeriodMustBeAtLeastOneDay',
      desc:
          'Message indicating that the budget period must be at least one day',
      args: [],
    );
  }

  /// `Asset`
  String get asset {
    return Intl.message(
      'Asset',
      name: 'asset',
      desc: 'Label for asset type',
      args: [],
    );
  }

  /// `Liability`
  String get liability {
    return Intl.message(
      'Liability',
      name: 'liability',
      desc: 'Label for liability type',
      args: [],
    );
  }

  /// `Enter Custom Type`
  String get enterCustomType {
    return Intl.message(
      'Enter Custom Type',
      name: 'enterCustomType',
      desc: 'Label for entering a custom type',
      args: [],
    );
  }

  /// `Please enter a custom type`
  String get pleaseEnterACustomType {
    return Intl.message(
      'Please enter a custom type',
      name: 'pleaseEnterACustomType',
      desc: 'Message prompting the user to enter a custom type',
      args: [],
    );
  }

  /// `Value/Amount`
  String get valueOrAmount {
    return Intl.message(
      'Value/Amount',
      name: 'valueOrAmount',
      desc: 'Label for entering a value or amount',
      args: [],
    );
  }

  /// `Asset Value`
  String get assetValue {
    return Intl.message(
      'Asset Value',
      name: 'assetValue',
      desc: 'Label for entering the value of an asset',
      args: [],
    );
  }

  /// `Liability Amount`
  String get liabilityAmount {
    return Intl.message(
      'Liability Amount',
      name: 'liabilityAmount',
      desc: 'Label for entering the amount of a liability',
      args: [],
    );
  }

  /// `Current market value`
  String get currentMarketValue {
    return Intl.message(
      'Current market value',
      name: 'currentMarketValue',
      desc: 'Helper text for entering the current market value',
      args: [],
    );
  }

  /// `Outstanding amount`
  String get outstandingAmount {
    return Intl.message(
      'Outstanding amount',
      name: 'outstandingAmount',
      desc: 'Helper text for entering the outstanding amount',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: 'Label for the details section',
      args: [],
    );
  }

  /// `Name/Description`
  String get nameOrDescription {
    return Intl.message(
      'Name/Description',
      name: 'nameOrDescription',
      desc: 'Label for entering a name or description',
      args: [],
    );
  }

  /// `Please enter a name/description`
  String get pleaseEnterANameOrDescription {
    return Intl.message(
      'Please enter a name/description',
      name: 'pleaseEnterANameOrDescription',
      desc: 'Message prompting the user to enter a name or description',
      args: [],
    );
  }

  /// `Purchase/Start Date`
  String get purchaseOrStartDate {
    return Intl.message(
      'Purchase/Start Date',
      name: 'purchaseOrStartDate',
      desc: 'Label for selecting the purchase or start date',
      args: [],
    );
  }

  /// `Please select a date`
  String get pleaseSelectADate {
    return Intl.message(
      'Please select a date',
      name: 'pleaseSelectADate',
      desc: 'Message prompting the user to select a date',
      args: [],
    );
  }

  /// `Interest Rate (%)`
  String get interestRate {
    return Intl.message(
      'Interest Rate (%)',
      name: 'interestRate',
      desc: 'Label for entering the interest rate',
      args: [],
    );
  }

  /// `Please enter an interest rate`
  String get pleaseEnterAnInterestRate {
    return Intl.message(
      'Please enter an interest rate',
      name: 'pleaseEnterAnInterestRate',
      desc: 'Message prompting the user to enter an interest rate',
      args: [],
    );
  }

  /// `Interest rate cannot be negative`
  String get interestRateCannotBeNegative {
    return Intl.message(
      'Interest rate cannot be negative',
      name: 'interestRateCannotBeNegative',
      desc: 'Message indicating that the interest rate cannot be negative',
      args: [],
    );
  }

  /// `Payment Schedule`
  String get paymentSchedule {
    return Intl.message(
      'Payment Schedule',
      name: 'paymentSchedule',
      desc: 'Label for selecting a payment schedule',
      args: [],
    );
  }

  /// `Select payment frequency`
  String get selectPaymentFrequency {
    return Intl.message(
      'Select payment frequency',
      name: 'selectPaymentFrequency',
      desc: 'Placeholder for selecting a payment frequency',
      args: [],
    );
  }

  /// `Please select a payment schedule`
  String get pleaseSelectAPaymentSchedule {
    return Intl.message(
      'Please select a payment schedule',
      name: 'pleaseSelectAPaymentSchedule',
      desc: 'Message prompting the user to select a payment schedule',
      args: [],
    );
  }

  /// `Documents/Attachments`
  String get documentsOrAttachments {
    return Intl.message(
      'Documents/Attachments',
      name: 'documentsOrAttachments',
      desc: 'Label for the documents or attachments section',
      args: [],
    );
  }

  /// `Add Document`
  String get addDocument {
    return Intl.message(
      'Add Document',
      name: 'addDocument',
      desc: 'Button text for adding a document',
      args: [],
    );
  }

  /// `Value Updates`
  String get valueUpdates {
    return Intl.message(
      'Value Updates',
      name: 'valueUpdates',
      desc: 'Label for value updates tracking option',
      args: [],
    );
  }

  /// `Payment Reminders`
  String get paymentReminders {
    return Intl.message(
      'Payment Reminders',
      name: 'paymentReminders',
      desc: 'Label for payment reminders tracking option',
      args: [],
    );
  }

  /// `Document Expiry`
  String get documentExpiry {
    return Intl.message(
      'Document Expiry',
      name: 'documentExpiry',
      desc: 'Label for document expiry tracking option',
      args: [],
    );
  }

  /// `Interest Rate Changes`
  String get interestRateChanges {
    return Intl.message(
      'Interest Rate Changes',
      name: 'interestRateChanges',
      desc: 'Label for interest rate changes tracking option',
      args: [],
    );
  }

  /// `Tracking Preferences`
  String get trackingPreferences {
    return Intl.message(
      'Tracking Preferences',
      name: 'trackingPreferences',
      desc: 'Label for tracking preferences section',
      args: [],
    );
  }

  /// `Custom Tracking Note`
  String get customTrackingNote {
    return Intl.message(
      'Custom Tracking Note',
      name: 'customTrackingNote',
      desc: 'Label for custom tracking note field',
      args: [],
    );
  }

  /// `Add any specific tracking requirements`
  String get addSpecificTrackingRequirements {
    return Intl.message(
      'Add any specific tracking requirements',
      name: 'addSpecificTrackingRequirements',
      desc: 'Helper text for adding specific tracking requirements',
      args: [],
    );
  }

  /// `Please select a type`
  String get pleaseSelectAType {
    return Intl.message(
      'Please select a type',
      name: 'pleaseSelectAType',
      desc: 'Message prompting the user to select a type',
      args: [],
    );
  }

  /// `Please fill in all required liability fields`
  String get pleaseFillRequiredLiabilityFields {
    return Intl.message(
      'Please fill in all required liability fields',
      name: 'pleaseFillRequiredLiabilityFields',
      desc:
          'Message prompting the user to fill in all required liability fields',
      args: [],
    );
  }

  /// `Change Currency`
  String get changeCurrency {
    return Intl.message(
      'Change Currency',
      name: 'changeCurrency',
      desc: 'Label for changing the currency',
      args: [],
    );
  }

  /// `Select Your Currency`
  String get selectYourCurrency {
    return Intl.message(
      'Select Your Currency',
      name: 'selectYourCurrency',
      desc: 'Title for selecting the user\'s currency',
      args: [],
    );
  }

  /// `Choose your preferred currency to get started.`
  String get choosePreferredCurrency {
    return Intl.message(
      'Choose your preferred currency to get started.',
      name: 'choosePreferredCurrency',
      desc: 'Message prompting the user to choose their preferred currency',
      args: [],
    );
  }

  /// `This will be used for all your financial transactions and reports.`
  String get currencyUsageInfo {
    return Intl.message(
      'This will be used for all your financial transactions and reports.',
      name: 'currencyUsageInfo',
      desc: 'Message explaining the purpose of selecting a currency',
      args: [],
    );
  }

  /// `Select Currency`
  String get selectCurrency {
    return Intl.message(
      'Select Currency',
      name: 'selectCurrency',
      desc: 'Button text for selecting a currency',
      args: [],
    );
  }

  /// `Change Currency`
  String get changeCurrencyButton {
    return Intl.message(
      'Change Currency',
      name: 'changeCurrencyButton',
      desc: 'Button text for changing the currency',
      args: [],
    );
  }

  /// `Next`
  String get nextButton {
    return Intl.message(
      'Next',
      name: 'nextButton',
      desc: 'Button text for proceeding to the next step',
      args: [],
    );
  }

  /// `Wait`
  String get wait {
    return Intl.message(
      'Wait',
      name: 'wait',
      desc: 'Message displayed when the user needs to wait',
      args: [],
    );
  }

  /// `Ad not ready yet`
  String get adNotReadyYet {
    return Intl.message(
      'Ad not ready yet',
      name: 'adNotReadyYet',
      desc: 'Message displayed when an ad is not ready to be shown',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Label for the settings section',
      args: [],
    );
  }

  /// `Reports & Analytics`
  String get reportsAndAnalytics {
    return Intl.message(
      'Reports & Analytics',
      name: 'reportsAndAnalytics',
      desc: 'Label for the reports and analytics section',
      args: [],
    );
  }

  /// `Future Projections`
  String get futureProjections {
    return Intl.message(
      'Future Projections',
      name: 'futureProjections',
      desc: 'Label for the future projections section',
      args: [],
    );
  }

  /// `View financial forecasts and trends`
  String get viewFinancialForecastsAndTrends {
    return Intl.message(
      'View financial forecasts and trends',
      name: 'viewFinancialForecastsAndTrends',
      desc: 'Message prompting the user to view financial forecasts and trends',
      args: [],
    );
  }

  /// `Past Performance`
  String get pastPerformance {
    return Intl.message(
      'Past Performance',
      name: 'pastPerformance',
      desc: 'Label for the past performance section',
      args: [],
    );
  }

  /// `Historical financial analysis`
  String get historicalFinancialAnalysis {
    return Intl.message(
      'Historical financial analysis',
      name: 'historicalFinancialAnalysis',
      desc: 'Label for analyzing historical financial data',
      args: [],
    );
  }

  /// `Income & Expense Analysis`
  String get incomeAndExpenseAnalysis {
    return Intl.message(
      'Income & Expense Analysis',
      name: 'incomeAndExpenseAnalysis',
      desc: 'Label for the income and expense analysis section',
      args: [],
    );
  }

  /// `Compare income, expenses and savings`
  String get compareIncomeExpensesAndSavings {
    return Intl.message(
      'Compare income, expenses and savings',
      name: 'compareIncomeExpensesAndSavings',
      desc:
          'Message prompting the user to compare income, expenses, and savings',
      args: [],
    );
  }

  /// `Budget vs Actual`
  String get budgetVsActual {
    return Intl.message(
      'Budget vs Actual',
      name: 'budgetVsActual',
      desc: 'Label for the budget vs actual performance section',
      args: [],
    );
  }

  /// `Track budget performance`
  String get trackBudgetPerformance {
    return Intl.message(
      'Track budget performance',
      name: 'trackBudgetPerformance',
      desc: 'Message prompting the user to track budget performance',
      args: [],
    );
  }

  /// `Download Reports`
  String get downloadReports {
    return Intl.message(
      'Download Reports',
      name: 'downloadReports',
      desc: 'Button text for downloading financial reports',
      args: [],
    );
  }

  /// `Export financial reports`
  String get exportFinancialReports {
    return Intl.message(
      'Export financial reports',
      name: 'exportFinancialReports',
      desc: 'Button text for exporting financial reports',
      args: [],
    );
  }

  /// `App Preferences`
  String get appPreferences {
    return Intl.message(
      'App Preferences',
      name: 'appPreferences',
      desc: 'Label for the app preferences section',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: 'Label for the currency settings section',
      args: [],
    );
  }

  /// `Set your preferred currency`
  String get setYourPreferredCurrency {
    return Intl.message(
      'Set your preferred currency',
      name: 'setYourPreferredCurrency',
      desc: 'Message prompting the user to set their preferred currency',
      args: [],
    );
  }

  /// `App Theme`
  String get appTheme {
    return Intl.message(
      'App Theme',
      name: 'appTheme',
      desc: 'Label for the app theme settings section',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: 'Label for the dark mode theme option',
      args: [],
    );
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message(
      'Light Mode',
      name: 'lightMode',
      desc: 'Label for the light mode theme option',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: 'Label for the language settings section',
      args: [],
    );
  }

  /// `Choose your preferred language`
  String get chooseYourPreferredLanguage {
    return Intl.message(
      'Choose your preferred language',
      name: 'chooseYourPreferredLanguage',
      desc: 'Message prompting the user to choose their preferred language',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: 'Label for the notifications section',
      args: [],
    );
  }

  /// `Budget Limits`
  String get budgetLimits {
    return Intl.message(
      'Budget Limits',
      name: 'budgetLimits',
      desc: 'Label for the budget limits section',
      args: [],
    );
  }

  /// `Get alerts when nearing budget limits`
  String get getAlertsWhenNearingBudgetLimits {
    return Intl.message(
      'Get alerts when nearing budget limits',
      name: 'getAlertsWhenNearingBudgetLimits',
      desc:
          'Message prompting the user to enable alerts for nearing budget limits',
      args: [],
    );
  }

  /// `Bill Payment Reminders`
  String get billPaymentReminders {
    return Intl.message(
      'Bill Payment Reminders',
      name: 'billPaymentReminders',
      desc: 'Label for the bill payment reminders section',
      args: [],
    );
  }

  /// `Never miss a payment deadline`
  String get neverMissAPaymentDeadline {
    return Intl.message(
      'Never miss a payment deadline',
      name: 'neverMissAPaymentDeadline',
      desc: 'Message encouraging the user to set up bill payment reminders',
      args: [],
    );
  }

  /// `Planning & Financial Goals`
  String get planningAndFinancialGoals {
    return Intl.message(
      'Planning & Financial Goals',
      name: 'planningAndFinancialGoals',
      desc: 'Label for the planning and financial goals section',
      args: [],
    );
  }

  /// `Savings Goals`
  String get savingsGoals {
    return Intl.message(
      'Savings Goals',
      name: 'savingsGoals',
      desc: 'Label for the savings goals section',
      args: [],
    );
  }

  /// `Set and track savings targets`
  String get setAndTrackSavingsTargets {
    return Intl.message(
      'Set and track savings targets',
      name: 'setAndTrackSavingsTargets',
      desc: 'Message prompting the user to set and track savings targets',
      args: [],
    );
  }

  /// `Debt Repayment Plan`
  String get debtRepaymentPlan {
    return Intl.message(
      'Debt Repayment Plan',
      name: 'debtRepaymentPlan',
      desc: 'Label for the debt repayment plan section',
      args: [],
    );
  }

  /// `Manage and track debt payments`
  String get manageAndTrackDebtPayments {
    return Intl.message(
      'Manage and track debt payments',
      name: 'manageAndTrackDebtPayments',
      desc: 'Message prompting the user to manage and track debt payments',
      args: [],
    );
  }

  /// `Retirement Planning`
  String get retirementPlanning {
    return Intl.message(
      'Retirement Planning',
      name: 'retirementPlanning',
      desc: 'Label for the retirement planning section',
      args: [],
    );
  }

  /// `Plan for your retirement`
  String get planForYourRetirement {
    return Intl.message(
      'Plan for your retirement',
      name: 'planForYourRetirement',
      desc: 'Message encouraging the user to plan for their retirement',
      args: [],
    );
  }

  /// `Financial Calculator`
  String get financialCalculator {
    return Intl.message(
      'Financial Calculator',
      name: 'financialCalculator',
      desc: 'Label for the financial calculator section',
      args: [],
    );
  }

  /// `Calculate loans, investments & more`
  String get calculateLoansInvestmentsAndMore {
    return Intl.message(
      'Calculate loans, investments & more',
      name: 'calculateLoansInvestmentsAndMore',
      desc:
          'Message prompting the user to use the financial calculator for various calculations',
      args: [],
    );
  }

  /// `Account Settings`
  String get accountSettings {
    return Intl.message(
      'Account Settings',
      name: 'accountSettings',
      desc: 'Label for the account settings section',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: 'Label for the profile section',
      args: [],
    );
  }

  /// `Manage personal information`
  String get managePersonalInformation {
    return Intl.message(
      'Manage personal information',
      name: 'managePersonalInformation',
      desc: 'Message prompting the user to manage their personal information',
      args: [],
    );
  }

  /// `Subscription Plan`
  String get subscriptionPlan {
    return Intl.message(
      'Subscription Plan',
      name: 'subscriptionPlan',
      desc: 'Label for the subscription plan section',
      args: [],
    );
  }

  /// `Manage your subscription`
  String get manageYourSubscription {
    return Intl.message(
      'Manage your subscription',
      name: 'manageYourSubscription',
      desc: 'Message prompting the user to manage their subscription',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: 'Label for the security section',
      args: [],
    );
  }

  /// `App lock, biometrics & backup`
  String get appLockBiometricsAndBackup {
    return Intl.message(
      'App lock, biometrics & backup',
      name: 'appLockBiometricsAndBackup',
      desc:
          'Message describing security features like app lock, biometrics, and backup',
      args: [],
    );
  }

  /// `Data Backup & Sync`
  String get dataBackupAndSync {
    return Intl.message(
      'Data Backup & Sync',
      name: 'dataBackupAndSync',
      desc: 'Label for the data backup and sync section',
      args: [],
    );
  }

  /// `Manage your data across devices`
  String get manageYourDataAcrossDevices {
    return Intl.message(
      'Manage your data across devices',
      name: 'manageYourDataAcrossDevices',
      desc: 'Message prompting the user to manage their data across devices',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: 'Label for the more section',
      args: [],
    );
  }

  /// `Help & Support`
  String get helpAndSupport {
    return Intl.message(
      'Help & Support',
      name: 'helpAndSupport',
      desc: 'Label for the help and support section',
      args: [],
    );
  }

  /// `FAQ, Contact & Support`
  String get faqContactAndSupport {
    return Intl.message(
      'FAQ, Contact & Support',
      name: 'faqContactAndSupport',
      desc: 'Message describing FAQ, contact, and support options',
      args: [],
    );
  }

  /// `Terms & Privacy`
  String get termsAndPrivacy {
    return Intl.message(
      'Terms & Privacy',
      name: 'termsAndPrivacy',
      desc: 'Label for the terms and privacy section',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: 'Label for the terms of service section',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: 'Label for the privacy policy section',
      args: [],
    );
  }

  /// `About App`
  String get aboutApp {
    return Intl.message(
      'About App',
      name: 'aboutApp',
      desc: 'Label for the about app section',
      args: [],
    );
  }

  /// `A comprehensive finance tracking application to manage your expenses, budgets, and financial portfolio.`
  String get comprehensiveFinanceTrackingApp {
    return Intl.message(
      'A comprehensive finance tracking application to manage your expenses, budgets, and financial portfolio.',
      name: 'comprehensiveFinanceTrackingApp',
      desc: 'Message describing the purpose of the application',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: 'Label for the sign-out action',
      args: [],
    );
  }

  /// `Support the App`
  String get supportTheApp {
    return Intl.message(
      'Support the App',
      name: 'supportTheApp',
      desc: 'Label for supporting the app',
      args: [],
    );
  }

  /// `Donate`
  String get donate {
    return Intl.message(
      'Donate',
      name: 'donate',
      desc: 'Label for the donate action',
      args: [],
    );
  }

  /// `Watch Ad`
  String get watchAd {
    return Intl.message(
      'Watch Ad',
      name: 'watchAd',
      desc: 'Label for the watch ad action',
      args: [],
    );
  }

  /// `Are you sure you want to sign out?`
  String get areYouSureYouWantToSignOut {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'areYouSureYouWantToSignOut',
      desc: 'Confirmation message for signing out',
      args: [],
    );
  }

  /// `Error signing out`
  String get errorSigningOut {
    return Intl.message(
      'Error signing out',
      name: 'errorSigningOut',
      desc: 'Message displayed when there is an error signing out',
      args: [],
    );
  }

  /// `Frequently Asked Questions`
  String get frequentlyAskedQuestions {
    return Intl.message(
      'Frequently Asked Questions',
      name: 'frequentlyAskedQuestions',
      desc: 'Label for the FAQ section',
      args: [],
    );
  }

  /// `Contact Support`
  String get contactSupport {
    return Intl.message(
      'Contact Support',
      name: 'contactSupport',
      desc: 'Label for contacting support',
      args: [],
    );
  }

  /// `Live Chat Support`
  String get liveChatSupport {
    return Intl.message(
      'Live Chat Support',
      name: 'liveChatSupport',
      desc: 'Label for live chat support',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: 'Label for the close action',
      args: [],
    );
  }

  /// `Data Usage`
  String get dataUsage {
    return Intl.message(
      'Data Usage',
      name: 'dataUsage',
      desc: 'Label for the data usage section',
      args: [],
    );
  }

  /// `Scan to Donate`
  String get scanToDonate {
    return Intl.message(
      'Scan to Donate',
      name: 'scanToDonate',
      desc: 'Label for the scan to donate action',
      args: [],
    );
  }

  /// `Card Details`
  String get cardDetails {
    return Intl.message(
      'Card Details',
      name: 'cardDetails',
      desc: 'Label for the card details section',
      args: [],
    );
  }

  /// `Number`
  String get number {
    return Intl.message(
      'Number',
      name: 'number',
      desc: 'Label for the number field',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: 'Label for the balance field',
      args: [],
    );
  }

  /// `Delete Card`
  String get deleteCard {
    return Intl.message(
      'Delete Card',
      name: 'deleteCard',
      desc: 'Label for the delete card action',
      args: [],
    );
  }

  /// `Are you sure you want to delete this card?`
  String get areYouSureYouWantToDeleteThisCard {
    return Intl.message(
      'Are you sure you want to delete this card?',
      name: 'areYouSureYouWantToDeleteThisCard',
      desc: 'Confirmation message for deleting a card',
      args: [],
    );
  }

  /// `Deleted`
  String get deleted {
    return Intl.message(
      'Deleted',
      name: 'deleted',
      desc: 'Label for deleted status',
      args: [],
    );
  }

  /// `Card deleted successfully`
  String get cardDeletedSuccessfully {
    return Intl.message(
      'Card deleted successfully',
      name: 'cardDeletedSuccessfully',
      desc: 'Message displayed when a card is successfully deleted',
      args: [],
    );
  }

  /// `Please select an account`
  String get pleaseSelectAnAccount {
    return Intl.message(
      'Please select an account',
      name: 'pleaseSelectAnAccount',
      desc: 'Message prompting the user to select an account',
      args: [],
    );
  }

  /// `Insufficient balance`
  String get insufficientBalance {
    return Intl.message(
      'Insufficient balance',
      name: 'insufficientBalance',
      desc: 'Message displayed when the account has insufficient balance',
      args: [],
    );
  }

  /// `Note (Optional)`
  String get noteOptional {
    return Intl.message(
      'Note (Optional)',
      name: 'noteOptional',
      desc: 'Label for an optional note field',
      args: [],
    );
  }

  /// `Transfer completed successfully`
  String get transferCompletedSuccessfully {
    return Intl.message(
      'Transfer completed successfully',
      name: 'transferCompletedSuccessfully',
      desc: 'Message displayed when a transfer is successfully completed',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: 'Greeting message for returning users',
      args: [],
    );
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: 'Label for the email address field',
      args: [],
    );
  }

  /// `Please enter your email`
  String get pleaseEnterYourEmail {
    return Intl.message(
      'Please enter your email',
      name: 'pleaseEnterYourEmail',
      desc: 'Message prompting the user to enter their email',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get pleaseEnterAValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'pleaseEnterAValidEmail',
      desc: 'Message prompting the user to enter a valid email',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Label for the password field',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterYourPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterYourPassword',
      desc: 'Message prompting the user to enter their password',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMustBeAtLeast6Characters {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMustBeAtLeast6Characters',
      desc: 'Message indicating the password length requirement',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: 'Label for the forgot password action',
      args: [],
    );
  }

  /// `Don't have account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have account?',
      name: 'dontHaveAccount',
      desc:
          'Message prompting the user to sign up if they don\'t have an account',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: 'Label for the sign-up action',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc:
          'Message prompting the user to log in if they already have an account',
      args: [],
    );
  }

  /// `Or Sign Up With`
  String get orSignUpWith {
    return Intl.message(
      'Or Sign Up With',
      name: 'orSignUpWith',
      desc: 'Label for the alternative sign-up options section',
      args: [],
    );
  }

  /// `I agree to Terms & Conditions`
  String get agreeToTerms {
    return Intl.message(
      'I agree to Terms & Conditions',
      name: 'agreeToTerms',
      desc: 'Message indicating agreement to terms and conditions',
      args: [],
    );
  }

  /// `Create your account`
  String get createYourAccount {
    return Intl.message(
      'Create your account',
      name: 'createYourAccount',
      desc: 'Label for the account creation section',
      args: [],
    );
  }

  /// `Validation Failed`
  String get validationFailed {
    return Intl.message(
      'Validation Failed',
      name: 'validationFailed',
      desc: 'Message indicating that validation has failed',
      args: [],
    );
  }

  /// `Please agree to Terms & Conditions`
  String get pleaseAgreeToTerms {
    return Intl.message(
      'Please agree to Terms & Conditions',
      name: 'pleaseAgreeToTerms',
      desc: 'Message prompting the user to agree to terms and conditions',
      args: [],
    );
  }

  /// `Type`
  String get typeLabel {
    return Intl.message(
      'Type',
      name: 'typeLabel',
      desc: 'Label for selecting the type of card or account',
      args: [],
    );
  }

  /// `Delete Settlement`
  String get deleteSettlement {
    return Intl.message(
      'Delete Settlement',
      name: 'deleteSettlement',
      desc: 'Title for the delete settlement dialog',
      args: [],
    );
  }

  /// `Are you sure you want to delete this settlement?`
  String get confirmDeleteSettlement {
    return Intl.message(
      'Are you sure you want to delete this settlement?',
      name: 'confirmDeleteSettlement',
      desc: 'Confirmation message for deleting a settlement',
      args: [],
    );
  }

  /// `Settlement deleted successfully`
  String get settlementDeletedSuccessfully {
    return Intl.message(
      'Settlement deleted successfully',
      name: 'settlementDeletedSuccessfully',
      desc: 'Message displayed when a settlement is successfully deleted',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
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
