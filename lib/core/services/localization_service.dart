import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../generated/l10n.dart';

class LocalizationService {
  // Supported locales
  static final List<Locale> supportedLocales = [
    const Locale('en', ''), // English
    const Locale('es', ''), // Spanish
    const Locale('fr', ''), // French
  ];

  // Localization delegates used by the app
  static final List<LocalizationsDelegate> localizationDelegates = [
    AppLocalizations.delegate, // Generated delegate from intl
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // Helper method to get locale from language code
  static Locale? localeFromString(String? languageCode) {
    if (languageCode == null || languageCode.isEmpty) return null;

    // Return the locale if it's supported
    return supportedLocales.firstWhere(
      (locale) => locale.languageCode == languageCode,
      orElse: () => supportedLocales.first,
    );
  }

  // Get language name from locale
  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      default:
        return 'Unknown';
    }
  }
}
