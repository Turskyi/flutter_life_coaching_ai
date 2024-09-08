import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/domain_services/settings_repository.dart';
import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._preferences);

  final SharedPreferences _preferences;

  @override
  Language getLanguage() {
    final String? savedLanguageIsoCode = _preferences.getString(
      StorageKeys.languageIsoCode.key,
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
      _preferences.setString(StorageKeys.languageIsoCode.key, languageIsoCode);
}
