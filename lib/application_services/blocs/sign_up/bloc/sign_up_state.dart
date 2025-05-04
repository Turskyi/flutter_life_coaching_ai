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

final class SignUpErrorState extends SignUpState {
  const SignUpErrorState({
    super.status,
    super.email,
    super.password,
    super.code,
    super.isValid,
    this.errorMessage = 'Authentication Failure',
  });

  final String errorMessage;

  @override
  SignUpErrorState copyWith({
    FormzSubmissionStatus? status,
    EmailAddress? email,
    Password? password,
    Code? code,
    bool? isValid,
    String? errorMessage,
  }) =>
      SignUpErrorState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        code: code ?? this.code,
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
        code,
      ];
}

final class SignUpProgressState extends SignUpState {
  const SignUpProgressState({
    super.status = FormzSubmissionStatus.inProgress,
    super.email,
    super.password,
    super.code,
    super.isValid,
  });

  @override
  SignUpProgressState copyWith({
    FormzSubmissionStatus? status,
    EmailAddress? email,
    Password? password,
    Code? code,
    bool? isValid,
  }) =>
      SignUpProgressState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        code: code ?? this.code,
        isValid: isValid ?? this.isValid,
      );
}
