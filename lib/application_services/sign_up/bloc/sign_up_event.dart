part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => <Object>[];
}

final class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => <Object>[email];
}

final class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => <Object>[password];
}

final class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}

final class CodeSubmitted extends SignUpEvent {
  const CodeSubmitted();
}

final class CodeChanged extends SignUpEvent {
  const CodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => <Object>[code];
}
