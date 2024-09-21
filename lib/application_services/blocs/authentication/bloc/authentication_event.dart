part of 'authentication_bloc.dart';

/// AuthenticationEvent instances will be the input to the AuthenticationBloc
/// and will be processed and used to emit new AuthenticationState instances.
sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class AuthenticationSubscriptionRequested extends AuthenticationEvent {
  const AuthenticationSubscriptionRequested();
}

final class AuthenticationSignOutPressed extends AuthenticationEvent {
  const AuthenticationSignOutPressed();
}

final class AuthenticationAccountDeletionRequested extends AuthenticationEvent {
  const AuthenticationAccountDeletionRequested();
}
