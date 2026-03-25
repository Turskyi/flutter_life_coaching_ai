import 'dart:developer' as developer;

import 'package:authentication_repository/authentication_repository.dart';
import 'package:models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

Future<void> main() async {
  final SharedPreferences preferences = await _createPreferences();
  final AuthenticationRepository repository = AuthenticationRepository(
    const _FakeRestClient(),
    preferences,
  );

  final Future<List<AuthenticationStatus>> statusesFuture = repository.status
      .take(3)
      .toList();

  await repository.signIn(email: ' user@example.com ', password: ' secret ');
  await repository.signOut();

  final List<AuthenticationStatus> statuses = await statusesFuture;

  for (final AuthenticationStatus status in statuses) {
    developer.log(
      _describeStatus(status),
      name: 'authentication_repository_example',
    );
  }

  repository.dispose();
}

Future<SharedPreferences> _createPreferences() {
  SharedPreferencesStorePlatform.instance =
      InMemorySharedPreferencesStore.empty();
  return SharedPreferences.getInstance();
}

String _describeStatus(AuthenticationStatus status) {
  return switch (status) {
    UnknownAuthenticationStatus() => 'unknown',
    AuthenticatedStatus() => 'authenticated',
    DeletingAuthenticatedUserStatus() => 'deleting account',
    UnauthenticatedStatus() => 'unauthenticated',
    CodeAuthenticationStatus(email: final String email) =>
      'verification code sent to $email',
    ResetPasswordAuthenticationStatus(email: final String email) =>
      'reset password flow started for $email',
  };
}

final class _FakeRestClient implements RestClient {
  const _FakeRestClient();

  @override
  Future<LoginResponse> signEmail(String identifier) async {
    return const _FakeLoginResponse(token: 'email-token', userId: 'user-123');
  }

  @override
  Future<LoginResponse> signIn(
    String identifier,
    String password,
    String strategy,
  ) async {
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
