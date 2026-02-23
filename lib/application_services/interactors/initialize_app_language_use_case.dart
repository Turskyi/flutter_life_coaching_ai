import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:lifecoach/infrastructure/data_sources/local/local_data_source.dart';
import 'package:models/models.dart';

class InitializeAppLanguageUseCase {
  const InitializeAppLanguageUseCase(
    this._localDataSource,
    this._localizationDelegate,
  );

  final LocalDataSource _localDataSource;
  final LocalizationDelegate _localizationDelegate;

  /// Resolves the initial language to use for the app.
  ///
  /// - `fallback` is used when no saved or host-based language is found.
  /// The method will update `Intl.defaultLocale`, persist the detected
  /// language via the local data source, and notify the localization
  /// delegate about the change.
  Future<Language> call({required Language fallback}) async {
    Language initialLanguage = fallback;

    // Detect language from saved preferences or system/host.
    final String saved = _localDataSource.getLanguageIsoCode();
    final bool isSavedSupported = Language.values.any(
      (Language l) => l.isoLanguageCode == saved,
    );

    if (isSavedSupported) {
      initialLanguage = Language.fromIsoLanguageCode(saved);
    } else {
      // Try to detect from host when running on web.
      if (kIsWeb) {
        final String host = Uri.base.host;
        final String fragment = Uri.base.fragment;
        for (final Language language in Language.values) {
          final String code = language.isoLanguageCode;
          if (host.startsWith('$code.') ||
              fragment.contains('${Uri.base.path}$code') ||
              fragment.contains('/$code')) {
            initialLanguage = language;
            break;
          }
        }
      } else {
        // Use system locale when not web.
        final String systemCode =
            PlatformDispatcher.instance.locale.languageCode;
        if (Language.values.any(
          (Language l) => l.isoLanguageCode == systemCode,
        )) {
          initialLanguage = Language.fromIsoLanguageCode(systemCode);
        }
      }
    }

    // Apply locale to intl and localization delegate.
    try {
      Intl.defaultLocale = initialLanguage.isoLanguageCode;
    } catch (e, st) {
      debugPrint('Failed to set Intl.defaultLocale: $e\n$st');
    }

    // Persist chosen language so the rest of app uses it.
    await _localDataSource.saveLanguageIsoCode(initialLanguage.isoLanguageCode);

    final Locale locale = Locale(initialLanguage.isoLanguageCode);
    _localizationDelegate.changeLocale(locale);
    _localizationDelegate.onLocaleChanged?.call(locale);

    return initialLanguage;
  }
}
