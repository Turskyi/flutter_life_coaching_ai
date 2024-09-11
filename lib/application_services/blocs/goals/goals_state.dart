part of 'goals_bloc.dart';

@immutable
sealed class GoalsState {
  const GoalsState({this.goals = const <Goal>[]});

  final List<Goal> goals;
}

final class GoalsInitial extends GoalsState {
  const GoalsInitial();
}

final class GoalsError extends GoalsState {
  const GoalsError(this.error);

  final String error;
}

final class GoalsLoaded extends GoalsState {
  const GoalsLoaded({super.goals});
}
