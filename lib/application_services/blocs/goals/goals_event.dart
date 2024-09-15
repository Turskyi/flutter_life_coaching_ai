part of 'goals_bloc.dart';

@immutable
sealed class GoalsEvent {
  const GoalsEvent();
}

final class LoadGoals extends GoalsEvent {
  const LoadGoals();
}

final class UpdateGoalEvent extends GoalsEvent {
  const UpdateGoalEvent(this.goal);

  final Goal goal;
}

final class CreateGoalEvent extends GoalsEvent {
  const CreateGoalEvent({required this.title, required this.content});

  final String title;
  final String content;
}

final class DeleteGoalEvent extends GoalsEvent {
  const DeleteGoalEvent(this.goal);

  final Goal goal;
}
