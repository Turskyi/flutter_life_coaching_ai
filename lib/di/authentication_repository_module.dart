import 'package:authentication_repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/infrastructure/ws/rest/retrofit_client/retrofit_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AuthenticationRepositoryModule {
  @lazySingleton
  AuthenticationRepository getAuthenticationRepository(
    RetrofitClient httpClient,
    SharedPreferences preferences,
  ) =>
      AuthenticationRepository(httpClient, preferences);
}
