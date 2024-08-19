import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/models/password.dart';
import 'package:lifecoach/models/username.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// The [SignInBloc] is responsible for reacting to user interactions in the
/// [LoginForm] and handling the validation and submission of the form.
/// The [SignInBloc] has a dependency on the [AuthenticationRepository]
/// because when the form is submitted, it invokes `signIn`. The initial state
/// of the bloc is pure meaning neither the inputs nor the form has been
/// touched or interacted with.
/// Whenever either the username or password change, the bloc will create a
/// dirty variant of the [Username]/[Password] model and update the form
/// status via the [Formz.validate] API.
/// When the [LoginSubmitted] event is added, if the current status of the
/// form is valid, the bloc makes a call to `signIn` and updates the status
/// based on the outcome of the request.
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignInState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<SignInState> emit,
  ) {
    final Username username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        // The second generic type will be either `PasswordValidationError`
        // or `UsernameValidationError`
        isValid: Formz.validate(<FormzInput<String, dynamic>>[
          state.password,
          username,
        ]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    final Password password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        // The second generic type will be either `PasswordValidationError`
        // or `UsernameValidationError`
        isValid: Formz.validate(
          <FormzInput<String, dynamic>>[password, state.username],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signIn(
          username: state.username.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
