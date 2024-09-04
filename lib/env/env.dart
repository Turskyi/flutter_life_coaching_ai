import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'CLERK_COOKIE')
  static const String clerkCookie = _Env.clerkCookie;
}
