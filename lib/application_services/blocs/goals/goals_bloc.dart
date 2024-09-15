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
        emit(const UnauthenticatedGoalsAccessState(error: 'User ID not found'));
        return;
      }
      // Fetch goals using the user ID.
      try {
        final List<Goal> goals = await _goalsRepository.getGoals(
          userId: userId,
        );
        emit(GoalsLoaded(goals: goals));
      } catch (error) {
        emit(GoalsError(error: error.toString()));
      }
    });
    on<CreateGoalEvent>((
      CreateGoalEvent event,
      Emitter<GoalsState> emit,
    ) async {
      await _handleCreateOrUpdateGoal(emitter: emit, event: event);
    });
    on<UpdateGoalEvent>((
      UpdateGoalEvent event,
      Emitter<GoalsState> emit,
    ) async {
      await _handleCreateOrUpdateGoal(emitter: emit, event: event);
    });

    on<DeleteGoalEvent>((
      DeleteGoalEvent event,
      Emitter<GoalsState> emit,
    ) async {
      final Goal goal = event.goal;
      emit(GoalDeleting(goalId: goal.id, goals: state.goals));
      // Get the user ID from the authentication bloc.
      final String userId = _authenticationBloc.state.user.id;

      final MessageResponse response =
          await _goalsRepository.delete(goal.copyWith(userId: userId));
      // Remove the goal from the existing list of goals.
      final List<Goal> updatedGoals = List<Goal>.from(state.goals)
        ..remove(goal);
      // Emit the new state with the updated list of goals.
      emit(GoalDeleted(message: response.message, goals: updatedGoals));
    });
  }

  Future<void> _handleCreateOrUpdateGoal({
    required Emitter<GoalsState> emitter,
    required GoalsEvent event,
  }) async {
    final List<Goal> goals = List<Goal>.from(state.goals);
    if (event is CreateGoalEvent) {
      emitter(CreatingGoal(goals: state.goals));
      // Get the user ID from the authentication bloc.
      final String userId = _authenticationBloc.state.user.id;
      // Create the new goal using the repository.
      final Goal newGoal = await _goalsRepository.create(
        Goal(title: event.title, content: event.content, userId: userId),
      );

      // Add the new goal to the existing list of goals.
      goals.add(newGoal);
    } else if (event is UpdateGoalEvent) {
      final Goal goal = event.goal;
      emitter(UpdatingGoal(goalId: goal.id, goals: state.goals));
      final Goal updatedGoal = await _goalsRepository.update(goal);

      // Update the goal in the existing list of goals.
      final int index = goals
          .indexWhere((Goal existingGoal) => existingGoal.id == updatedGoal.id);
      if (index != -1) {
        goals[index] = updatedGoal;
      }
    }

    // Emit the new state with the updated list of goals.
    emitter(GoalSubmitted(goals: goals));
  }

  final GoalsRepository _goalsRepository;
  final AuthenticationBloc _authenticationBloc;
}
