import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockRestClient extends Mock implements RestClient {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late AuthenticationRepository authenticationRepository;
  late MockRestClient mockRestClient;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockRestClient = MockRestClient();
    mockSharedPreferences = MockSharedPreferences();
    authenticationRepository = AuthenticationRepository(
      mockRestClient,
      mockSharedPreferences,
    );
  });

  group('AuthenticationRepository', () {
    test('initial status is unauthenticated if no token is saved', () {
      when(mockSharedPreferences.getString(StorageKeys.authToken.key))
          .thenReturn('');

      expectLater(
        authenticationRepository.status,
        emitsInOrder(
          <AuthenticationStatus>[AuthenticationStatus.unauthenticated],
        ),
      );
    });

    test('initial status is authenticated if a token is saved', () {
      when(mockSharedPreferences.getString(StorageKeys.authToken.key))
          .thenReturn('token');

      expectLater(
        authenticationRepository.status,
        emitsInOrder(
          <AuthenticationStatus>[AuthenticationStatus.authenticated],
        ),
      );
    });
  });
}
