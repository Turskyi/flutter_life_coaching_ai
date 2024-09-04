part of 'sign_in_bloc.dart';

/// The [EmailAddress] and [Password] models are used as part of the
/// [SignInState] and the status is also part of `package:formz`.
final class SignInState extends Equatable {
  const SignInState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const EmailAddress.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final EmailAddress email;
  final Password password;
  final bool isValid;

  SignInState copyWith({
    FormzSubmissionStatus? status,
    EmailAddress? email,
    Password? password,
    bool? isValid,
  }) =>
      SignInState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
      );

  @override
  List<Object> get props => <Object>[status, email, password];
}

final class SignInErrorState extends SignInState {
  const SignInErrorState({
    super.status,
    super.email,
    super.password,
    super.isValid,
    this.errorMessage = 'Authentication Failure',
  });

  final String errorMessage;

  @override
  SignInErrorState copyWith({
    FormzSubmissionStatus? status,
    EmailAddress? email,
    Password? password,
    bool? isValid,
    String? errorMessage,
  }) =>
      SignInErrorState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => <Object>[
        status,
        email,
        password,
        isValid,
        errorMessage,
      ];
}
