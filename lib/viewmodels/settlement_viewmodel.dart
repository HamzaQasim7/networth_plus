import 'dart:async';

import 'package:flutter/foundation.dart';
import '../data/repositories/settlement_repository.dart';
import '../data/models/settlement_model.dart';
import '../core/constants/console.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class SettlementViewModel extends ChangeNotifier {
  final SettlementRepository _repository;
  final AuthViewModel _authViewModel;
  List<SettlementModel> _settlements = [];
  bool _isLoading = false;
  String? _error;
  StreamSubscription<List<SettlementModel>>? _settlementsSubscription;
  bool _disposed = false;

  SettlementViewModel({
    SettlementRepository? repository,
    required AuthViewModel authViewModel,
  })  : _repository = repository ?? SettlementRepository(),
        _authViewModel = authViewModel;

  List<SettlementModel> get settlements => _settlements;
  bool get isLoading => _isLoading;
  String? get error => _error;

  @override
  void dispose() {
    _settlementsSubscription?.cancel();
    _disposed = true;
    super.dispose();
  }

  Future<void> _loadSettlements() async {
    final userId = _authViewModel.currentUser?.id;
    if (userId == null || _disposed) return;

    try {
      _isLoading = true;
      if (!_disposed) notifyListeners();

      _settlementsSubscription?.cancel();

      _settlementsSubscription =
          _repository.getSettlements(userId).listen((settlements) {
        if (_disposed) return;
        _settlements = settlements;
        _isLoading = false;
        notifyListeners();
      }, onError: (error) {
        if (_disposed) return;
        console('Error in settlements stream: $error', type: DebugType.error);
        _error = error.toString();
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      if (_disposed) return;
      console('Error loading settlements: $e', type: DebugType.error);
      _error = 'Failed to load settlements. Please try again.';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addSettlement({
    required String title,
    required double amount,
    required bool isOwed,
    required List<String> participants,
  }) async {
    if (_disposed) return false;
    final userId = _authViewModel.currentUser?.id;
    if (userId == null) {
      _error = 'User not authenticated';
      notifyListeners();
      return false;
    }

    try {
      _isLoading = true;
      notifyListeners();

      final newSettlement = SettlementModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        title: title,
        amount: amount,
        isOwed: isOwed,
        relatedTransactions: [],
        participants: participants,
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _repository.addSettlement(newSettlement);
      console('Successfully added settlement: ${newSettlement.id}',
          type: DebugType.info);
      return true;
    } catch (e) {
      console('Error adding settlement: $e', type: DebugType.error);
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteSettlement(String id) async {
    try {
      await _repository.deleteSettlement(id);
      _settlements.removeWhere((s) => s.id == id);
      console('Deleted settlement: $id', type: DebugType.info);
      notifyListeners();
    } catch (e) {
      console('Error deleting settlement: $e', type: DebugType.error);
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> markAsPaid(String id) async {
    try {
      await _repository.markAsPaid(id);
      final index = _settlements.indexWhere((s) => s.id == id);
      if (index != -1) {
        _settlements[index] = _settlements[index].copyWith(isOwed: false);
        console('Marked settlement as paid: $id', type: DebugType.info);
        notifyListeners();
      }
    } catch (e) {
      console('Error marking settlement as paid: $e', type: DebugType.error);
      _error = e.toString();
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> reLoadSettlement() async {
    if (!_isLoading && !_disposed) {
      await _loadSettlements();
    }
  }
}
