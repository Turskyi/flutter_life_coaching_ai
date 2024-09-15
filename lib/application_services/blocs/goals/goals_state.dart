part of 'goals_bloc.dart';

@immutable
sealed class GoalsState {
  const GoalsState({this.goals = const <Goal>[]});

  final List<Goal> goals;
}

final class GoalsInitial extends GoalsState {
  const GoalsInitial();
}

final class CreatingGoal extends GoalsState {
  const CreatingGoal({super.goals});
}

abstract class SubmittingGoal extends GoalsState {
  const SubmittingGoal({required this.goalId, required super.goals});

  final String goalId;
}

final class UpdatingGoal extends SubmittingGoal {
  const UpdatingGoal({required super.goalId, required super.goals});
}

final class GoalDeleting extends SubmittingGoal {
  const GoalDeleting({required super.goalId, required super.goals});
}

final class GoalSubmitted extends GoalsState {
  const GoalSubmitted({super.goals});
}

final class GoalDeleted extends GoalsState {
  const GoalDeleted({required this.message, super.goals});

  final String message;
}

final class GoalsError extends GoalsState {
  const GoalsError({required this.error, super.goals});

  final String error;
}

final class UnauthenticatedGoalsAccessState extends GoalsError {
  const UnauthenticatedGoalsAccessState({required super.error});
}

final class GoalsLoaded extends GoalsState {
  const GoalsLoaded({super.goals});
}
