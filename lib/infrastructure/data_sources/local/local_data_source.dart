import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  const LocalDataSource(this._preferences);

  final SharedPreferences _preferences;

  Future<bool> saveLanguageIsoCode(String languageIsoCode) {
    final bool isSupported = Language.values.any(
      (Language lang) => lang.isoLanguageCode == languageIsoCode,
    );

    final String safeLanguageCode = isSupported
        ? languageIsoCode
        : Language.en.isoLanguageCode;

    return _preferences.setString(
      Settings.languageIsoCode.key,
      safeLanguageCode,
    );
  }

  String getLanguageIsoCode() {
    final String? savedLanguageIsoCode = _preferences.getString(
      Settings.languageIsoCode.key,
    );

    final bool isSavedLanguageSupported =
        savedLanguageIsoCode != null &&
        Language.values.any((Language lang) {
          return lang.isoLanguageCode == savedLanguageIsoCode;
        });

    final String systemLanguageCode =
        PlatformDispatcher.instance.locale.languageCode;

    String defaultLanguageCode =
        Language.values.any(
          (Language lang) => lang.isoLanguageCode == systemLanguageCode,
        )
        ? systemLanguageCode
        : Language.en.isoLanguageCode;

    final String host = Uri.base.host;

    for (final Language language in Language.values) {
      final String currentLanguageCode = language.isoLanguageCode;
      if (host.startsWith('$currentLanguageCode.')) {
        try {
          Intl.defaultLocale = currentLanguageCode;
        } catch (e, stackTrace) {
          debugPrint(
            'Failed to set Intl.defaultLocale to "$currentLanguageCode".\n'
            'Error: $e\n'
            'StackTrace: $stackTrace\n'
            'Proceeding with previously set default locale or system default.',
          );
        }
        defaultLanguageCode = currentLanguageCode;
        // Exit the loop once a match is found and processed.
        break;
      }
    }

    return isSavedLanguageSupported
        ? savedLanguageIsoCode
        : defaultLanguageCode;
  }

  Language getSavedLanguage() {
    final String savedLanguageIsoCode = getLanguageIsoCode();
    final Language savedLanguage = Language.fromIsoLanguageCode(
      savedLanguageIsoCode,
    );
    return savedLanguage;
  }
}
