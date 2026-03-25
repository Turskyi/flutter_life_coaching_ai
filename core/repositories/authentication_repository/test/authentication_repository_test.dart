import 'package:authentication_repository/authentication_repository.dart';
import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';
import 'package:test/test.dart';

void main() {
  group('AuthenticationRepository', () {
    late SharedPreferences preferences;

    setUp(() async {
      SharedPreferencesStorePlatform.instance =
          InMemorySharedPreferencesStore.empty();
      preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    });

    test('starts unauthenticated when no email is cached', () async {
      final AuthenticationRepository repository = AuthenticationRepository(
        _FakeRestClient(),
        preferences,
      );

      final AuthenticationStatus status = await repository.status.first;

      expect(status, isA<UnauthenticatedStatus>());
      repository.dispose();
    });

    test('starts authenticated when email is cached', () async {
      await preferences.setString(StorageKeys.email.key, 'user@example.com');

      final AuthenticationRepository repository = AuthenticationRepository(
        _FakeRestClient(),
        preferences,
      );

      final AuthenticationStatus status = await repository.status.first;

      expect(status, isA<AuthenticatedStatus>());
      repository.dispose();
    });

    test(
      'sign in then sign out emits expected statuses and updates storage',
      () async {
        final _FakeRestClient restClient = _FakeRestClient();
        final AuthenticationRepository repository = AuthenticationRepository(
          restClient,
          preferences,
        );

        final Future<List<AuthenticationStatus>> statusesFuture = repository
            .status
            .take(3)
            .toList();

        await repository.signIn(
          email: ' user@example.com ',
          password: ' secret ',
        );

        expect(restClient.signEmailIdentifier, 'user@example.com');
        expect(restClient.signInIdentifier, 'user@example.com');
        expect(restClient.signInPassword, 'secret');
        expect(restClient.signInStrategy, 'password');
        expect(preferences.getString(StorageKeys.authToken.key), 'auth-token');
        expect(preferences.getString(StorageKeys.userId.key), 'user-123');

        await repository.signOut();

        expect(preferences.getString(StorageKeys.authToken.key), isNull);
        expect(preferences.getString(StorageKeys.userId.key), isNull);
        expect(preferences.getString(StorageKeys.email.key), isNull);

        final List<AuthenticationStatus> statuses = await statusesFuture;

        expect(statuses, hasLength(3));
        expect(statuses[0], isA<UnauthenticatedStatus>());
        expect(statuses[1], isA<AuthenticatedStatus>());
        expect(statuses[2], isA<UnauthenticatedStatus>());

        repository.dispose();
      },
    );
  });
}

final class _FakeRestClient implements RestClient {
  String? signEmailIdentifier;
  String? signInIdentifier;
  String? signInPassword;
  String? signInStrategy;

  @override
  Future<LoginResponse> signEmail(String identifier) async {
    signEmailIdentifier = identifier;
    return const _FakeLoginResponse(token: 'email-token', userId: 'user-123');
  }

  @override
  Future<LoginResponse> signIn(
    String identifier,
    String password,
    String strategy,
  ) async {
    signInIdentifier = identifier;
    signInPassword = password;
    signInStrategy = strategy;

    return const _FakeLoginResponse(token: 'auth-token', userId: 'user-123');
  }

  @override
  Future<GoalResult> createGoal(Goal goal) {
    throw UnimplementedError();
  }

  @override
  Future<GoalResult> updateGoal(Goal goal) {
    throw UnimplementedError();
  }

  @override
  Future<MessageResponse> deleteGoal(Goal goal) {
    throw UnimplementedError();
  }

  @override
  Future<Goals> getGoals(String userId, int? page) {
    throw UnimplementedError();
  }

  @override
  Future<MessageResponse> deleteAccount(String userId) async {
    return const _FakeMessageResponse('Account deleted');
  }
}

final class _FakeLoginResponse extends LoginResponse {
  const _FakeLoginResponse({required super.token, required super.userId});
}

final class _FakeMessageResponse implements MessageResponse {
  const _FakeMessageResponse(this.message);

  @override
  final String message;
}
