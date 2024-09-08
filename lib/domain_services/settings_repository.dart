import 'package:laozi_ai/entities/enums/language.dart';

abstract interface class SettingsRepository {
  const SettingsRepository();

  Language getLanguage();

  Future<bool> saveLanguageIsoCode(String languageIsoCode);
}
