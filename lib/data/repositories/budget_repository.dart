import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/budget_model.dart';

class BudgetRepository {
  final FirebaseFirestore _firestore;
  final String _collection = 'budgets';

  BudgetRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<BudgetModel>> getBudgets(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs
          .map((doc) => BudgetModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createBudget(BudgetModel budget) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(budget.id)
          .set(budget.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateBudget(BudgetModel budget) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(budget.id)
          .update(budget.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteBudget(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
} 