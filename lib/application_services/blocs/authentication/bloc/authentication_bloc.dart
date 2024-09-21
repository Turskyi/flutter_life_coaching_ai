import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:models/models.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// The AuthenticationBloc is responsible for reacting to changes in the
/// authentication state (exposed by the AuthenticationRepository) and will
/// emit states we can react to in the ui component.
/// The AuthenticationBloc will be reacting to two different events:
/// • AuthenticationSubscriptionRequested: initial event that notifies the bloc
/// to subscribe to the AuthenticationStatus stream
/// • AuthenticationLogoutPressed: notifies the bloc of a user logout action.
/// The AuthenticationBloc manages the authentication state of the application
/// which is used to determine things like whether or not to start the user at
/// a goals page or a home page.
/// The AuthenticationBloc has a dependency on both the
/// AuthenticationRepository and UserRepository and defines the initial state
/// as AuthenticationState.unknown().
/// In the constructor body, AuthenticationEvent subclasses are mapped to
/// their corresponding event handlers.
/// In the _onSubscriptionRequested event handler, the AuthenticationBloc uses
/// emit.onEach to subscribe to the status stream of the
/// AuthenticationRepository and emit a state in response to each
/// AuthenticationStatus.
@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationSignOutPressed>(_onLogoutPressed);
    on<AuthenticationAccountDeletionRequested>(_onAccountDeletionRequested);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  /// emit.onEach creates a stream subscription internally and takes care of
  /// canceling it when either AuthenticationBloc or the status stream is
  /// closed.
  /// If the status stream emits an error, addError forwards the error and
  /// stackTrace to any BlocObserver listening.
  /// If onError is omitted, any errors on the status stream are considered
  /// unhandled, and will be thrown by onEach. As a result, the subscription
  /// to the status stream will be canceled.
  /// When the status stream emits AuthenticationStatus.unknown or
  /// unauthenticated, the corresponding AuthenticationState is emitted.
  /// When AuthenticationStatus.authenticated is emitted, the
  /// AuthenticationBloc queries the user via the UserRepository.
  Future<void> _onSubscriptionRequested(
    AuthenticationSubscriptionRequested event,
    Emitter<AuthenticationState> emit,
  ) =>
      emit.onEach(
        _authenticationRepository.status,
        onData: (AuthenticationStatus status) async {
          switch (status) {
            case UnauthenticatedStatus():
              return emit(const AuthenticationState.unauthenticated());
            case AuthenticatedStatus():
              final User user = _getUser();

              return emit(
                user.isNotEmpty
                    ? AuthenticationState.authenticated(user)
                    : const AuthenticationState.unauthenticated(),
              );
            case UnknownAuthenticationStatus():
              return emit(const AuthenticationState.unknown());
            case DeletingAuthenticatedUserStatus():
              emit(AuthenticationState.accountDeleting(state.user));
          }
        },
        onError: addError,
      );

  void _onLogoutPressed(
    AuthenticationSignOutPressed event,
    Emitter<AuthenticationState> emit,
  ) =>
      _authenticationRepository.signOut();

  Future<void> _onAccountDeletionRequested(
    AuthenticationAccountDeletionRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    final MessageResponse response =
        await _authenticationRepository.deleteAccount(
      state.user.id,
    );
    emit(AuthenticationState.accountDeleted(response.message));
  }

  User _getUser() {
    final User user = _userRepository.getUser();
    return user;
  }
}
