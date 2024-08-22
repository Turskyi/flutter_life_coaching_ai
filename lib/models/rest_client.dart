import 'package:lifecoach/models/abstract/login_response.dart';
import 'package:lifecoach/models/abstract/logout_response.dart';

abstract interface class RestClient {
  const RestClient();

  Future<LoginResponse> signIn(
    String identifier,
    String password,
    String strategy,
  );

  Future<LogoutResponse> signOut();
}
