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
      desc: 'Label for payment method',
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
      desc: 'Label for delete action or button',
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
      desc: 'Message displayed when the user provides an invalid amount',
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
  String get typeLabel {
    return Intl.message(
      'Type',
      name: 'typeLabel',
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
