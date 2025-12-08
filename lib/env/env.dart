import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  /// The variable from `.env` file.
  @EnviedField(varName: 'RESEND_API_KEY')
  static const String resendApiKey = _Env.resendApiKey;
}
