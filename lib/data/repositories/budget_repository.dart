import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/budget_model.dart';
import '../../core/constants/console.dart';

class BudgetRepository {
  final FirebaseFirestore _firestore;
  final String _collection = 'budgets';

  BudgetRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<BudgetModel>> getBudgetsByUser(String userId) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .orderBy('startDate', descending: true)
        .snapshots()
        .handleError((error) {
          console('Budget fetch error: $error', type: DebugType.error);
          throw Exception('Failed to load budgets. Please try again.');
        })
        .map((snapshot) => snapshot.docs
            .map((doc) => BudgetModel.fromFirestore(doc))
            .toList());
  }

  Future<void> addBudget(BudgetModel budget) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(budget.id)
          .set(budget.toFirestore());
      console('Budget added: ${budget.id}', type: DebugType.info);
    } catch (e) {
      console('Error adding budget: $e', type: DebugType.error);
      throw Exception('Failed to create budget. Please try again.');
    }
  }

  Future<void> updateBudget(BudgetModel budget) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(budget.id)
          .update(budget.toFirestore());
      console('Budget updated: ${budget.id}', type: DebugType.info);
    } catch (e) {
      console('Error updating budget: $e', type: DebugType.error);
      throw Exception('Failed to update budget. Please try again.');
    }
  }

  Future<void> toggleBudgetStatus(String id, bool isActive) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(id)
          .update({'isActive': isActive});
    } catch (e) {
      console('Error toggling budget status: $e', type: DebugType.error);
      throw Exception('Failed to update budget status. Please try again.');
    }
  }

  Future<void> deleteBudget(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
      console('Budget deleted: $id', type: DebugType.info);
    } catch (e) {
      console('Error deleting budget: $e', type: DebugType.error);
      throw Exception('Failed to delete budget. Please try again.');
    }
  }

  Future<void> addSpending(String budgetId, double amount) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(budgetId)
          .update({'spent': FieldValue.increment(amount)});
    } catch (e) {
      console('Error updating budget spending: $e', type: DebugType.error);
      throw Exception('Failed to update budget. Please try again.');
    }
  }
} 