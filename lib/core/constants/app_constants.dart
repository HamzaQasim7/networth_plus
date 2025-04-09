import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Finance Tracker';
  static const String appVersion = '1.0.0';

  // API URLs
  static const String baseUrl = 'https://api.example.com';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';

  // Error Messages
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError = 'Please check your internet connection.';
  static final List<Map<String, dynamic>> cards = [
    {
      'type': 'Bank Account',
      'name': 'Primary Savings',
      'number': '**** 1234',
      'balance': 50000.00,
      'color': Colors.blue,
      'icon': Icons.account_balance,
    },
    {
      'type': 'Credit Card',
      'name': 'Rewards Card',
      'number': '**** 5678',
      'balance': 25000.00,
      'color': Colors.purple,
      'icon': Icons.credit_card,
    },
  ];
}
