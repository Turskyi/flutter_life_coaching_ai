part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => <Object>[];
}

final class SignInEmailChanged extends SignInEvent {
  const SignInEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => <Object>[email];
}

final class SignInPasswordChanged extends SignInEvent {
  const SignInPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => <Object>[password];
}

final class SignInStaySignedInChanged extends SignInEvent {
  const SignInStaySignedInChanged(this.staySignedIn);

  final bool staySignedIn;

  @override
  List<Object> get props => <Object>[staySignedIn];
}

final class SignInSubmitted extends SignInEvent {
  const SignInSubmitted();
}

final class ForgotPasswordRequested extends SignInEvent {
  const ForgotPasswordRequested();
}

final class ResetPasswordSubmitted extends SignInEvent {
  const ResetPasswordSubmitted({required this.code, required this.newPassword});

  final String code;
  final String newPassword;

  @override
  List<Object> get props => <Object>[code, newPassword];
}
