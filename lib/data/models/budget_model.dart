class BudgetModel {
  final String id;
  final String userId;
  final String category;
  final double amount;
  final double spent;
  final DateTime startDate;
  final DateTime endDate;

  BudgetModel({
    required this.id,
    required this.userId,
    required this.category,
    required this.amount,
    required this.spent,
    required this.startDate,
    required this.endDate,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      category: json['category'] as String,
      amount: json['amount'] as double,
      spent: json['spent'] as double,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'category': category,
      'amount': amount,
      'spent': spent,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  double get remainingAmount => amount - spent;
  double get percentageUsed => (spent / amount) * 100;
} 