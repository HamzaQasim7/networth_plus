import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AccountCardModel {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String type;
  final double balance;
  final Color color;
  final IconData icon;
  final DateTime createdAt;
  final DateTime updatedAt;

  AccountCardModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.number,
    required this.type,
    required this.balance,
    required this.color,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a new account card
  factory AccountCardModel.create({
    required String userId,
    required String name,
    required String number,
    required String type,
    required double balance,
    required Color color,
    required IconData icon,
  }) {
    final now = DateTime.now();
    return AccountCardModel(
      id: const Uuid().v4(),
      userId: userId,
      name: name,
      number: number,
      type: type,
      balance: balance,
      color: color,
      icon: icon,
      createdAt: now,
      updatedAt: now,
    );
  }

  // Create from Firestore document
  factory AccountCardModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AccountCardModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      number: data['number'] ?? '',
      type: data['type'] ?? '',
      balance: (data['balance'] ?? 0.0).toDouble(),
      color: Color(data['color'] ?? 0xFF000000),
      icon: IconData(data['icon'] ?? 0, fontFamily: 'MaterialIcons'),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'name': name,
      'number': number,
      'type': type,
      'balance': balance,
      'color': color.value,
      'icon': icon.codePoint,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create a copy with updated fields
  AccountCardModel copyWith({
    String? name,
    String? number,
    String? type,
    double? balance,
    Color? color,
    IconData? icon,
  }) {
    return AccountCardModel(
      id: id,
      userId: userId,
      name: name ?? this.name,
      number: number ?? this.number,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  // Convert to Map for UI
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'type': type,
      'balance': balance,
      'color': color,
      'icon': icon,
    };
  }
}
