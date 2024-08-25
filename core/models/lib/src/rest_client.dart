import 'package:models/models.dart';

abstract interface class RestClient {
  const RestClient();

  Future<LoginResponse> signIn(
    String identifier,
    String password,
    String strategy,
  );

  Future<LogoutResponse> signOut();

  Future<RegisterResponse> signUp(
    String emailAddress,
    String password,
    String captchaToken,
    // This value is always `invisible`.
    String captchaWidgetType,
  );

  /// The [RegisterResponse.id] will be used to call https://clerk.turskyi.com/v1/client/sign_ups/[RegisterResponse.id]/prepare_verification?_clerk_js_version=5.15.0
  Future<CodeResponse> prepare(
    String id,
    // This value is always `email_code`.
    String strategy,
  );

  /// This call will expect the code received on `emailAddress` from the
  /// [signUp] form.
  Future<Verification> verify(
    String id,
    String code,
    // This value is always `email_code`.
    String strategy,
  );
}
