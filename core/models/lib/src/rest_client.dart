import 'package:models/models.dart';

abstract interface class RestClient {
  const RestClient();

  Future<LoginResponse> signEmail(String identifier);

  Future<LoginResponse> signIn(
    String identifier,
    String password,
    String strategy,
  );

  Future<LogoutResponse> signOut();

  //TODO: remove due to it is not used.
  @Deprecated('There is no replacement at this moment.')
  Future<RegisterResponse> signUp(
    String emailAddress,
    String password,
  );

  //TODO: remove due to it is not used.
  /// The [RegisterResponse.id] will be used to call https://clerk.turskyi.com/v1/client/sign_ups/[RegisterResponse.id]/prepare_verification?_clerk_js_version=5.15.0
  @Deprecated('There is no replacement at this moment.')
  Future<CodeResponse> prepare(
    String id,
    // This value is always `email_code`.
    String strategy,
  );

  //TODO: remove due to it is not used.
  /// This call will expect the code received on `emailAddress` from the
  /// [signUp] form.
  @Deprecated('There is no replacement at this moment.')
  Future<Verification> verify(
    String id,
    String code,
    // This value is always `email_code`.
    String strategy,
  );
}
