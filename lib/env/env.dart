import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY')
  static const String apiKey = _Env.apiKey;
  @EnviedField(varName: 'OPEN_FOOD_USER_ID')
  static const String openFoodUserId = _Env.openFoodUserId;
  @EnviedField(varName: 'OPEN_FOOD_PASSWORD')
  static const String openFoodPassword = _Env.openFoodPassword;
  @EnviedField(varName: 'SUPPORT_EMAIL')
  static const String supportEmail = _Env.supportEmail;
}
