sealed class AuthenticationStatus {
  const AuthenticationStatus();

  factory AuthenticationStatus.unknown() = UnknownAuthenticationStatus;

  factory AuthenticationStatus.authenticated() = AuthenticatedStatus;

  factory AuthenticationStatus.unauthenticated() = UnauthenticatedStatus;
}

class UnknownAuthenticationStatus extends AuthenticationStatus {
  const UnknownAuthenticationStatus();
}

class AuthenticatedStatus extends AuthenticationStatus {
  const AuthenticatedStatus();
}

class UnauthenticatedStatus extends AuthenticationStatus {
  const UnauthenticatedStatus();
}
