import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:lifecoach/domain_services/goals_repository.dart';
import 'package:meta/meta.dart';
import 'package:models/models.dart';

part 'goals_event.dart';
part 'goals_state.dart';

@injectable
class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  GoalsBloc(this._goalsRepository, this._authenticationBloc)
      : super(const GoalsInitial()) {
    on<LoadGoals>((_, Emitter<GoalsState> emit) async {
      // Access the user ID from the AuthenticationBloc's state.
      final String userId = _authenticationBloc.state.user.id;

      if (userId.isEmpty) {
        emit(const GoalsError('User ID not found'));
        return;
      }
      // Fetch goals using the user ID
      try {
        final List<Goal> goals = await _goalsRepository.getGoals(
          userId: userId,
        );
        emit(GoalsLoaded(goals: goals));
      } catch (error) {
        emit(GoalsError(error.toString()));
      }
    });
  }

  final GoalsRepository _goalsRepository;
  final AuthenticationBloc _authenticationBloc;
}
