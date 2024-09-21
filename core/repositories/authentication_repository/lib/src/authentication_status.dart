sealed class AuthenticationStatus {
  const AuthenticationStatus();

  factory AuthenticationStatus.unknown() = UnknownAuthenticationStatus;

  factory AuthenticationStatus.deleting() = DeletingAuthenticatedUserStatus;

  factory AuthenticationStatus.authenticated() = AuthenticatedStatus;

  factory AuthenticationStatus.unauthenticated() = UnauthenticatedStatus;
}

class UnknownAuthenticationStatus extends AuthenticationStatus {
  const UnknownAuthenticationStatus();
}

class AuthenticatedStatus extends AuthenticationStatus {
  const AuthenticatedStatus();
}

class DeletingAuthenticatedUserStatus extends AuthenticationStatus {
  const DeletingAuthenticatedUserStatus();
}

class UnauthenticatedStatus extends AuthenticationStatus {
  const UnauthenticatedStatus({this.message = ''});

  final String message;
}
