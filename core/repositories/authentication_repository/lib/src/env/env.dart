import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  /// The variable from `.env` file.
  @EnviedField(varName: 'PUBLIC_CLERK_PUBLISHABLE_KEY')
  static const String clerkPublishableKey = _Env.clerkPublishableKey;
}
