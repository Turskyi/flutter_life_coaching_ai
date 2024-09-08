import 'package:models/models.dart';

abstract interface class SettingsRepository {
  const SettingsRepository();

  Language getLanguage();

  Future<bool> saveLanguageIsoCode(String languageIsoCode);
}
