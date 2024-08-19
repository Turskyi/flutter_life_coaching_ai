part of 'sign_in_bloc.dart';

/// The Username and Password models are used as part of the [SignInState] and
/// the status is also part of `package:formz`.
final class SignInState extends Equatable {
  const SignInState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final bool isValid;

  SignInState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    bool? isValid,
  }) =>
      SignInState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
      );

  @override
  List<Object> get props => <Object>[status, username, password];
}
