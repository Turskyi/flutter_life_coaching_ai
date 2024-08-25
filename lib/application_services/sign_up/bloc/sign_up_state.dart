part of 'sign_up_bloc.dart';

/// The [EmailAddress] and [Password] models are used as part of the
/// [SignUpState] and the status is also part of `package:formz`.
final class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const EmailAddress.pure(),
    this.password = const Password.pure(),
    this.code = const Code.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final EmailAddress email;
  final Password password;
  final Code code;
  final bool isValid;

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    EmailAddress? email,
    Password? password,
    Code? code,
    bool? isValid,
  }) =>
      SignUpState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        code: code ?? this.code,
        isValid: isValid ?? this.isValid,
      );

  @override
  List<Object> get props => <Object>[status, email, password, code];
}
