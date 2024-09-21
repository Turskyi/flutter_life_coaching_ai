part of 'authentication_bloc.dart';

/// AuthenticationState instances will be the output of the AuthenticationBloc
/// and will be consumed by the ui component.
/// The AuthenticationState class has three named constructors:
/// • AuthenticationState.unknown(): the default state which indicates that
/// the bloc does not yet know whether the current user is authenticated or not.
///
/// • AuthenticationState.authenticated(): the state which indicates that the
/// user is current authenticated.
///
/// • AuthenticationState.unauthenticated(): the state which indicates that
/// the user is current not authenticated.
class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = const UnknownAuthenticationStatus(),
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: const AuthenticatedStatus(), user: user);

  const AuthenticationState.accountDeleting(User user)
      : this._(status: const DeletingAuthenticatedUserStatus(), user: user);

  AuthenticationState.accountDeleted(String message)
      : this._(status: UnauthenticatedStatus(message: message));

  const AuthenticationState.unauthenticated()
      : this._(status: const UnauthenticatedStatus());

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => <Object>[status, user];
}
