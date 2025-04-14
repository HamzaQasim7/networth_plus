import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/repositories/transaction_repository.dart';
import '../data/models/transaction_model.dart';

class TransactionViewModel extends ChangeNotifier {
  final TransactionRepository _repository;
  final FirebaseAuth _auth;
  
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _error;
  
  // Total tracking variables
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  double _availableBalance = 0.0;

  // Getters for totals
  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;
  double get availableBalance => _availableBalance;
  
  // Filters
  DateTime? _startDate;
  DateTime? _endDate;
  TransactionType? _filterType;

  // Add new filter
  String? _filterPaymentMethod;

  TransactionViewModel({
    TransactionRepository? repository,
    FirebaseAuth? auth,
  })  : _repository = repository ?? TransactionRepository(),
        _auth = auth ?? FirebaseAuth.instance {
    // Initialize totals when viewmodel is created
    _loadTotals();
  }

  // Getters
  List<TransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentUserId => _auth.currentUser?.uid;

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

  // Add new transaction with total updates
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

  // Update existing transaction with total recalculation
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

  // Delete transaction with total recalculation
  Future<bool> deleteTransaction(String id) async {
    try {
      _setLoading(true);
      _error = null;

      await _repository.deleteTransaction(id);
      
      // Find the transaction before removing it
      final deletedTransaction = _transactions.firstWhere((t) => t.id == id);
      
      // Update totals based on deleted transaction
      if (deletedTransaction.type == TransactionType.income) {
        _totalIncome -= deletedTransaction.amount;
      } else if (deletedTransaction.type == TransactionType.expense) {
        _totalExpense -= deletedTransaction.amount;
      }
      _availableBalance = _totalIncome - _totalExpense;
      
      _transactions.removeWhere((t) => t.id == id);
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
}

