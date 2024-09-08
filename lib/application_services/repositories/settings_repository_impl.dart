import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:laozi_ai/domain_services/settings_repository.dart';
import 'package:laozi_ai/entities/enums/language.dart';
import 'package:laozi_ai/res/enums/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._preferences);

  final SharedPreferences _preferences;

  @override
  Language getLanguage() {
    final String? savedLanguageIsoCode = _preferences.getString(
      Settings.languageIsoCode.key,
    );
    if (savedLanguageIsoCode != null) {
      return Language.fromIsoLanguageCode(savedLanguageIsoCode);
    } else {
      return Language.fromIsoLanguageCode(
        PlatformDispatcher.instance.locale.languageCode,
      );
    }
  }

  @override
  Future<bool> saveLanguageIsoCode(String languageIsoCode) =>
      _preferences.setString(Settings.languageIsoCode.key, languageIsoCode);
}
