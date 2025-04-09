import 'package:flutter/foundation.dart';
import '../data/repositories/settlement_repository.dart';
import '../data/models/settlement_model.dart';
import '../core/constants/console.dart';

class SettlementViewModel extends ChangeNotifier {
  final SettlementRepository _repository;
  List<SettlementModel> _settlements = [];
  bool _isLoading = false;
  String? _error;
  String? _currentUserId;

  SettlementViewModel({SettlementRepository? repository})
      : _repository = repository ?? SettlementRepository();

  List<SettlementModel> get settlements => _settlements;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setUserId(String userId) {
    _currentUserId = userId;
    _loadSettlements();
  }

  Future<void> _loadSettlements() async {
    if (_currentUserId == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      _repository.getSettlements(_currentUserId!).listen(
        (settlements) {
          _settlements = settlements;
          _isLoading = false;
          notifyListeners();
        },
        onError: (error) {
          console('Error in settlements stream: $error', 
                 type: DebugType.error);
          _error = error.toString();
          _isLoading = false;
          notifyListeners();
        }
      );
    } catch (e) {
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
    if (_currentUserId == null) return false;

    try {
      _isLoading = true;
      notifyListeners();

      final newSettlement = SettlementModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: _currentUserId!,
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
} 