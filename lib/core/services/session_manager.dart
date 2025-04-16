import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager extends ChangeNotifier {
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';
  static const String _selectedCurrencyKey = 'selected_currency';

  final SharedPreferences _prefs;
  final FirebaseAuth _auth;

  SessionManager({
    required SharedPreferences prefs,
    FirebaseAuth? auth,
  })  : _prefs = prefs,
        _auth = auth ?? FirebaseAuth.instance {
    // Listen to auth state changes
    _auth.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  bool get isAuthenticated => _auth.currentUser != null;

  bool get hasSeenOnboarding => _prefs.getBool(_hasSeenOnboardingKey) ?? false;

  String? get selectedCurrency => _prefs.getString(_selectedCurrencyKey);

  Future<void> setHasSeenOnboarding(bool value) async {
    await _prefs.setBool(_hasSeenOnboardingKey, value);
  }

  Future<void> setSelectedCurrency(String currency) async {
    await _prefs.setString(_selectedCurrencyKey, currency);
    notifyListeners();
  }

  Future<void> clearSession() async {
    await _auth.signOut();
    // Don't clear onboarding flag as we don't want to show it again
    await _prefs.remove(_selectedCurrencyKey);
  }

  // Add method to handle authentication success
  Future<void> onAuthenticationSuccess() async {
    // If user hasn't selected currency, we don't want to skip onboarding
    if (selectedCurrency == null) {
      await setHasSeenOnboarding(true);
    }
    notifyListeners();
  }

  // Add method to handle sign out
  Future<void> signOut() async {
    await clearSession();
    notifyListeners();
  }
}
