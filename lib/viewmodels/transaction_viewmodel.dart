import 'package:finance_tracker/core/services/recurring_transaction_notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/repositories/transaction_repository.dart';
import '../data/models/transaction_model.dart';
import 'package:collection/collection.dart';
import '../viewmodels/auth_viewmodel.dart';

class TransactionViewModel extends ChangeNotifier {
  final TransactionRepository _repository;
  final AuthViewModel _authViewModel;
  final RecurringTransactionNotificationService _notificationService;
  
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _error;
  bool _disposed = false;
  DateTime _selectedMonth = DateTime.now(); // Add selected month tracking
  
  // Total tracking variables
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  double _availableBalance = 0.0;

  // Getters for totals
  // double get totalIncome => _totalIncome;
  // double get totalExpense => _totalExpense;
  // double get availableBalance => _availableBalance;
  
  // Filters
  DateTime? _startDate;
  DateTime? _endDate;
  TransactionType? _filterType;

  // Add new filter
  String? _filterPaymentMethod;

  TransactionViewModel({
    required AuthViewModel authViewModel,
    TransactionRepository? repository,
    RecurringTransactionNotificationService? notificationService,
  })  : _authViewModel = authViewModel,
        _repository = repository ?? TransactionRepository(),
        _notificationService = notificationService ?? RecurringTransactionNotificationService() {
    _init();
  }

  // Getters
  List<TransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentUserId => _authViewModel.currentUser?.id;
  DateTime get selectedMonth => _selectedMonth;

  // Filtered transactions for selected month
  List<TransactionModel> get filteredTransactions => _transactions
      .where((t) =>
          t.date.month == _selectedMonth.month &&
          t.date.year == _selectedMonth.year)
      .toList();

  // Monthly totals
  double get totalIncome => filteredTransactions
      .where((t) => t.type == TransactionType.income)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpense => filteredTransactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get availableBalance => totalIncome - totalExpense;

  void _init() {
    if (_authViewModel.currentUser != null) {
      loadTransactionsForMonth(_selectedMonth);
    }
  }

  // Add this method for setting selected month
  void setSelectedMonth(DateTime month) {
    _selectedMonth = DateTime(month.year, month.month, 1);
    loadTransactionsForMonth(_selectedMonth);
    notifyListeners();
  }

  // Add this method for loading transactions for a specific month
  Future<void> loadTransactionsForMonth(DateTime month) async {
    if (currentUserId == null) return;

    try {
      _setLoading(true);
      _error = null;

      final startDate = DateTime(month.year, month.month, 1);
      final endDate = DateTime(month.year, month.month + 1, 0);

      _transactions = await _repository.getTransactions(
        userId: currentUserId!,
        startDate: startDate,
        endDate: endDate,
      );

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Add this method for getting monthly statistics
  Map<String, dynamic> getMonthlyStatistics() {
    final startDate = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final endDate = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);

    // Get category breakdown
    final categoryBreakdown = groupBy(
      filteredTransactions.where((t) => t.type == TransactionType.expense),
      (TransactionModel t) => t.category,
    ).map((category, transactions) => MapEntry(
          category,
          transactions.fold(0.0, (sum, t) => sum + t.amount),
        ));

    // Get previous month comparison
    final previousMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    final previousMonthStats = _getPreviousMonthComparison(previousMonth);

    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'balance': availableBalance,
      'transactionCount': filteredTransactions.length,
      'startDate': startDate,
      'endDate': endDate,
      'categoryBreakdown': categoryBreakdown,
      'previousMonth': previousMonthStats,
    };
  }

  // Add this helper method for previous month comparison
  Map<String, double> _getPreviousMonthComparison(DateTime previousMonth) {
    final previousTransactions = _transactions.where((t) =>
        t.date.month == previousMonth.month && t.date.year == previousMonth.year);

    final previousIncome = previousTransactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);

    final previousExpense = previousTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);

    final previousBalance = previousIncome - previousExpense;

    return {
      'incomeChange': totalIncome > 0 && previousIncome > 0
          ? ((totalIncome - previousIncome) / previousIncome) * 100
          : 0.0,
      'expenseChange': totalExpense > 0 && previousExpense > 0
          ? ((totalExpense - previousExpense) / previousExpense) * 100
          : 0.0,
      'balanceChange': availableBalance != 0 && previousBalance != 0
          ? ((availableBalance - previousBalance) / previousBalance.abs()) * 100
          : 0.0,
    };
  }

  // Load transactions with optional filters
  Future<void> loadTransactions({
    DateTime? startDate,
    DateTime? endDate,
    TransactionType? type,
    String? paymentMethod,
  }) async {
    if (currentUserId == null) return;

    try {
      _setLoading(true);
      _error = null;
      
      _startDate = startDate ?? _startDate;
      _endDate = endDate ?? _endDate;
      
      _transactions = await _repository.getTransactions(
        userId: currentUserId!,
        startDate: _startDate,
        endDate: _endDate,
        type: type,
        paymentMethod: paymentMethod,
      );
      
      _calculateTotals(transactions);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Get transactions by payment method
  Future<List<TransactionModel>> getTransactionsByPaymentMethod(String paymentMethod) async {
    if (currentUserId == null) return [];

    try {
      return await _repository.getTransactions(
        userId: currentUserId!,
        paymentMethod: paymentMethod,
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  // Get recurring transactions
  Future<List<TransactionModel>> getRecurringTransactions() async {
    if (currentUserId == null) return [];

    try {
      final transactions = await _repository.getTransactions(
        userId: currentUserId!,
      );
      return transactions.where((t) => t.isRecurring).toList();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  // Load total amounts
  Future<void> _loadTotals() async {
    if (currentUserId == null) return;

    try {
      final transactions = await _repository.getTransactions(userId: currentUserId!);
      _calculateTotals(transactions);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Calculate totals from transactions
  void _calculateTotals(List<TransactionModel> transactions) {
    _totalIncome = 0.0;
    _totalExpense = 0.0;

    for (var transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        _totalIncome += transaction.amount;
      } else if (transaction.type == TransactionType.expense) {
        _totalExpense += transaction.amount;
      }
    }

    _availableBalance = _totalIncome - _totalExpense;
    notifyListeners();
  }

  // Override addTransaction to handle recurring notifications
  Future<bool> addTransaction(TransactionModel transaction) async {
    if (currentUserId == null) return false;

    try {
      _setLoading(true);
      _error = null;

      final newTransaction = await _repository.addTransaction(
        transaction.copyWith(userId: currentUserId),
      );
      
      // Update totals based on transaction type
      if (transaction.type == TransactionType.income) {
        _totalIncome += transaction.amount;
      } else if (transaction.type == TransactionType.expense) {
        _totalExpense += transaction.amount;
      }
      _availableBalance = _totalIncome - _totalExpense;
      
      _transactions.insert(0, newTransaction);

      // Schedule notifications if it's a recurring transaction
      if (transaction.isRecurring) {
        await _notificationService.scheduleRecurringTransactionNotifications(newTransaction);
      }

      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Override updateTransaction to handle notification updates
  Future<bool> updateTransaction(TransactionModel transaction) async {
    try {
      _setLoading(true);
      _error = null;

      await _repository.updateTransaction(transaction);
      
      // Reload all transactions to recalculate totals
      await _loadTotals();
      
      final index = _transactions.indexWhere((t) => t.id == transaction.id);
      if (index != -1) {
        _transactions[index] = transaction;
      }

      // Update notifications if it's a recurring transaction
      if (transaction.isRecurring) {
        await _notificationService.updateRecurringNotifications(transaction);
      } else {
        // Cancel notifications if it's no longer recurring
        await _notificationService.cancelRecurringNotifications(transaction.id!);
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Override deleteTransaction to handle notification cleanup
  Future<bool> deleteTransaction(String id) async {
    try {
      _setLoading(true);
      _error = null;

      // Find the transaction before removing it
      final deletedTransaction = _transactions.firstWhere((t) => t.id == id);
      
      await _repository.deleteTransaction(id);
      
      // Update totals based on deleted transaction
      if (deletedTransaction.type == TransactionType.income) {
        _totalIncome -= deletedTransaction.amount;
      } else if (deletedTransaction.type == TransactionType.expense) {
        _totalExpense -= deletedTransaction.amount;
      }
      _availableBalance = _totalIncome - _totalExpense;
      
      _transactions.removeWhere((t) => t.id == id);

      // Cancel notifications if it was a recurring transaction
      if (deletedTransaction.isRecurring) {
        await _notificationService.cancelRecurringNotifications(id);
      }

      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Get category totals
  Future<Map<String, double>> getCategoryTotals({
    required DateTime startDate,
    required DateTime endDate,
    required TransactionType type,
  }) async {
    if (currentUserId == null) return {};

    try {
      return await _repository.getCategoryTotals(
        userId: currentUserId!,
        startDate: startDate,
        endDate: endDate,
        type: type,
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return {};
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Clear any error messages
  void clearError() {
    _error = null;
    notifyListeners();
  }

  double getTotalByType(TransactionType type, DateTime start, DateTime end) {
    return _transactions
        .where((t) => t.type == type && 
                      t.date.isAfter(start) && 
                      t.date.isBefore(end))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double getTotalByTypeAndCategory(
    TransactionType type,
    String category,
    DateTime startDate,
    DateTime endDate,
  ) {
    return transactions
        .where((t) =>
            t.type == type &&
            t.category == category &&
            t.date.isAfter(startDate) &&
            t.date.isBefore(endDate))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  List<TransactionModel> getTransactionsInRange(DateTime startDate, DateTime endDate) {
    return transactions.where((transaction) {
      // Convert dates to start/end of day to ensure inclusive range
      final start = DateTime(startDate.year, startDate.month, startDate.day);
      final end = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
      
      return transaction.date.isAfter(start.subtract(const Duration(seconds: 1))) && 
             transaction.date.isBefore(end.add(const Duration(seconds: 1)));
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // Sort by date descending
  }

  // Helper method to get transactions by type in a date range
  List<TransactionModel> getTransactionsByTypeInRange(
    TransactionType type,
    DateTime startDate,
    DateTime endDate,
  ) {
    return getTransactionsInRange(startDate, endDate)
        .where((t) => t.type == type)
        .toList();
  }

  // Helper method to get total amount by type in a date range
  double getTotalByTypeInRange(
    TransactionType type,
    DateTime startDate,
    DateTime endDate,
  ) {
    return getTransactionsByTypeInRange(type, startDate, endDate)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  // Helper method to get transactions grouped by category in a date range
  Map<String, List<TransactionModel>> getTransactionsByCategoryInRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    final transactionsInRange = getTransactionsInRange(startDate, endDate);
    return groupBy(transactionsInRange, (TransactionModel t) => t.category);
  }

  // Helper method to get total amount by category in a date range
  Map<String, double> getTotalByCategoryInRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    final groupedTransactions = getTransactionsByCategoryInRange(startDate, endDate);
    return groupedTransactions.map(
      (category, transactions) => MapEntry(
        category,
        transactions.fold(0.0, (sum, t) => sum + t.amount),
      ),
    );
  }

  // Add method to process recurring transactions
  Future<bool> processRecurringTransaction(TransactionModel recurringTransaction) async {
    if (!recurringTransaction.isRecurring) return false;

    try {
      // Create new transaction from recurring template
      final newTransaction = recurringTransaction.copyWith(
        id: null, // Will be generated
        date: DateTime.now(),
        isRecurring: false,
        recurringFrequency: null,
      );

      final success = await addTransaction(newTransaction);

      if (success) {
        // Send notification about processed transaction
        await _notificationService.sendRecurringTransactionProcessedNotification(newTransaction);
      }

      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Add method to get notification statistics
  Future<Map<String, dynamic>> getNotificationStats() async {
    try {
      final pendingNotifications = await _notificationService.getPendingNotifications();
      final recurringTransactions = await getRecurringTransactions();

      return {
        'pendingNotifications': pendingNotifications.length,
        'recurringTransactions': recurringTransactions.length,
        'scheduledReminders': pendingNotifications.where(
          (n) => n['payload']?.contains('recurring_reminder') ?? false
        ).length,
        'scheduledProcessing': pendingNotifications.where(
          (n) => n['payload']?.contains('recurring_processed') ?? false
        ).length,
      };
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return {};
    }
  }

  // Add method to check and process due recurring transactions
  Future<void> checkAndProcessDueTransactions() async {
    await _notificationService.checkAndProcessDueTransactions();
  }

  @override
  void dispose() {
    _disposed = true;
    // Cancel all recurring notifications when view model is disposed
    _notificationService.cancelAllRecurringNotifications();
    super.dispose();
  }
}

