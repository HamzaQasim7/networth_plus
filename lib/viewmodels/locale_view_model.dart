import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../core/services/localization_service.dart';
import '../core/services/preferences_service.dart';
import '../l10n/models/locale_model.dart';

class LocaleViewModel extends ChangeNotifier {
  final PreferencesService _preferencesService = PreferencesService();

  LocaleModel? _localeModel;
  bool _isLoading = true;

  // Getters
  LocaleModel? get localeModel => _localeModel;

  bool get isLoading => _isLoading;

  Locale? get locale => _localeModel?.locale;

  bool get isSystemDefault => _localeModel?.isSystemDefault ?? true;

  // Constructor loads saved locale
  LocaleViewModel() {
    loadSavedLocale();
  }

  // Load saved locale from preferences
  Future<void> loadSavedLocale() async {
    _isLoading = true;
    notifyListeners();

    final String? savedLanguageCode =
        await _preferencesService.getLanguageCode();

    if (savedLanguageCode == null) {
      // Use system locale if no preference is saved
      _localeModel = LocaleModel(
        locale: ui.window.locale,
        isSystemDefault: true,
      );
    } else {
      // Use saved locale
      _localeModel = LocaleModel(
        locale: LocalizationService.localeFromString(savedLanguageCode)!,
        isSystemDefault: false,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  // Set a new locale
  Future<void> setLocale(Locale newLocale) async {
    // Save to preferences
    await _preferencesService.setLanguageCode(newLocale.languageCode);

    // Update model
    _localeModel = LocaleModel(
      locale: newLocale,
      isSystemDefault: false,
    );

    notifyListeners();
  }

  // Use system default locale
  Future<void> useSystemLocale() async {
    // Clear saved preference
    await _preferencesService.clearLanguageCode();

    // Update model
    _localeModel = LocaleModel(
      locale: ui.window.locale,
      isSystemDefault: true,
    );

    notifyListeners();
  }
}
