import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:models/models.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// The [SignInBloc] is responsible for reacting to user interactions in the
/// [LoginForm] and handling the validation and submission of the form.
/// The [SignInBloc] has a dependency on the [AuthenticationRepository]
/// because when the form is submitted, it invokes `signIn`. The initial state
/// of the bloc is pure meaning neither the inputs nor the form has been
/// touched or interacted with.
/// Whenever either the email or password change, the bloc will create a
/// dirty variant of the [EmailAddress]/[Password] model and update the form
/// status via the [Formz.validate] API.
/// When the [SignInSubmitted] event is added, if the current status of the
/// form is valid, the bloc makes a call to `signIn` and updates the status
/// based on the outcome of the request.
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(
    SignInEmailChanged event,
    Emitter<SignInState> emit,
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
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
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

  Future<void> _onSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signIn(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        if (e is DioException) {
          final dynamic data = e.response?.data;
          const String errorsKey = 'errors';
          const String messageKey = 'message';
          final String errorMessage = (data != null &&
                  data.containsKey(errorsKey) &&
                  data[errorsKey].isNotEmpty &&
                  data[errorsKey].first.containsKey(messageKey))
              ? data[errorsKey][0][messageKey]
              : 'Unknown error';
          emit(
            SignInErrorState(
              status: FormzSubmissionStatus.failure,
              email: state.email,
              password: state.password,
              isValid: state.isValid,
              errorMessage: errorMessage,
            ),
          );
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
      }
    }
  }
}
