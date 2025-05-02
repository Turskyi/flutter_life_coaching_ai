import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:clerk_auth/clerk_auth.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/api_exception.dart';
import 'package:models/models.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

/// The [SignUpBloc] is responsible for reacting to user interactions in the
/// [LoginForm] and handling the validation and submission of the form.
/// The [SignUpBloc] has a dependency on the [AuthenticationRepository]
/// because when the form is submitted, it invokes `signIn`. The initial state
/// of the bloc is pure meaning neither the inputs nor the form has been
/// touched or interacted with.
/// Whenever either the email or password change, the bloc will create a
/// dirty variant of the [EmailAddress]/[Password] model and update the form
/// status via the [Formz.validate] API.
/// When the [SignUpSubmitted] event is added, if the current status of the
/// form is valid, the bloc makes a call to `signIn` and updates the status
/// based on the outcome of the request.
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpSubmitted>(_onSubmitted);
    on<CodeChanged>(_onCodeChanged);
    on<CodeSubmitted>(_onCodeSubmitted);
    on<ResendCode>(_onResendCode);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(
    SignUpEmailChanged event,
    Emitter<SignUpState> emit,
  ) {
    final EmailAddress email = EmailAddress.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(<FormzInput<String, ValidationError>>[
          state.password,
          email,
        ]),
      ),
    );
  }

  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final Password password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
          <FormzInput<String, ValidationError>>[password, state.email],
        ),
      ),
    );
  }

  void _onCodeChanged(
    CodeChanged event,
    Emitter<SignUpState> emit,
  ) {
    final Code code = Code.dirty(event.code);
    emit(
      state.copyWith(
        code: code,
        isValid: Formz.validate(
          <FormzInput<String, ValidationError>>[code],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (state.isValid) {
      emit(
        SignUpProgressState(
          email: state.email,
          password: state.password,
          isValid: state.isValid,
          code: state.code,
        ),
      );
      try {
        await _authenticationRepository.signUp(
          email: state.email.value,
          password: state.password.value,
        );

        emit(
          state.copyWith(status: FormzSubmissionStatus.success),
        );
      } on ApiException catch (e) {
        _handleError(error: e, emitter: emit);
      } catch (e) {
        _handleError(error: e, emitter: emit);
      }
    }
  }

  void _handleError({
    required Object error,
    required Emitter<SignUpState> emitter,
  }) {
    if (error is DioException) {
      final Object? responseBody = error.response?.data;

      const String errorsKey = 'errors';
      const String messageKey = 'long_message';
      String errorMessage = 'Unknown error';

      if (responseBody is Map<String, Object?>) {
        final bool isDataContainsErrorKey = responseBody.containsKey(errorsKey);

        if (isDataContainsErrorKey) {
          final Object? errors = responseBody[errorsKey];

          if (errors is List<Object?> && errors.isNotEmpty) {
            final Object? errorEntry = errors.first;

            if (errorEntry is Map<String, Object?> &&
                errorEntry.containsKey(messageKey)) {
              final Object? message = errorEntry[messageKey];

              if (message is String && message.isNotEmpty) {
                errorMessage = message;
              }
            }
          }
        }
      }

      emitter(
        SignUpErrorState(
          status: FormzSubmissionStatus.failure,
          email: state.email,
          password: state.password,
          isValid: state.isValid,
          errorMessage: errorMessage,
          code: state.code,
        ),
      );
    } else if (error is AuthError) {
      emitter(
        SignUpErrorState(
          status: FormzSubmissionStatus.failure,
          email: state.email,
          password: state.password,
          isValid: state.isValid,
          errorMessage: error.message,
        ),
      );
    } else {
      emitter(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _onCodeSubmitted(
    CodeSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (state.isValid) {
      emit(
        SignUpProgressState(
          email: state.email,
          password: state.password,
          isValid: state.isValid,
          code: state.code,
        ),
      );
      try {
        final String code = state.code.value;

        if (code.isNotEmpty) {
          await _authenticationRepository.verify(code);
        }

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        _handleError(error: e, emitter: emit);
      }
    }
  }

  Future<void> _onResendCode(
    ResendCode event,
    Emitter<SignUpState> emit,
  ) async {
    if (_authenticationRepository.canSendCode()) {
      emit(
        SignUpProgressState(
          email: state.email,
          password: state.password,
          isValid: state.isValid,
          code: state.code,
        ),
      );

      try {
        await _authenticationRepository.sendCodeToUser();

        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
            code: const Code.pure(),
          ),
        );
      } catch (e) {
        _handleError(error: e, emitter: emit);
      }
    }
  }
}
