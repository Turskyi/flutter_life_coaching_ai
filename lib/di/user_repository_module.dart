import 'package:injectable/injectable.dart';
import 'package:lifecoach/infrastructure/ws/rest/retrofit_client/retrofit_client.dart';
import 'package:user_repository/user_repository.dart';

@module
abstract class UserRepositoryModule {
  @lazySingleton
  UserRepository getUserRepository(RetrofitClient httpClient) =>
      UserRepository();
}
