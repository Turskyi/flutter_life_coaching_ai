part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => <Object>[];
}

final class LoginUsernameChanged extends SignInEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => <Object>[username];
}

final class LoginPasswordChanged extends SignInEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => <Object>[password];
}

final class LoginSubmitted extends SignInEvent {
  const LoginSubmitted();
}
