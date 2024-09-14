import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
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
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signUp(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
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
      final dynamic data = error.response?.data;

      const String errorsKey = 'errors';
      const String messageKey = 'long_message';
      final String errorMessage = (data != null &&
              data.containsKey(errorsKey) &&
              data[errorsKey].isNotEmpty &&
              data[errorsKey].first.containsKey(messageKey))
          ? data[errorsKey][0][messageKey]
          : 'Unknown error';

      emitter(
        SignUpErrorState(
          status: FormzSubmissionStatus.failure,
          email: state.email,
          password: state.password,
          isValid: state.isValid,
          errorMessage: errorMessage,
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
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.verify(state.code.value);

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        _handleError(error: e, emitter: emit);
      }
    }
  }
}
