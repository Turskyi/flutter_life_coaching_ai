import 'package:injectable/injectable.dart';
import 'package:lifecoach/domain_services/ai_consent_repository.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: AiConsentRepository)
class AiConsentRepositoryImpl implements AiConsentRepository {
  const AiConsentRepositoryImpl(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<bool> hasAiConsent() async {
    return _preferences.getBool(constants.aiConsentKey) ?? false;
  }

  @override
  Future<void> setAiConsent(bool consent) async {
    await _preferences.setBool(constants.aiConsentKey, consent);
  }
}
