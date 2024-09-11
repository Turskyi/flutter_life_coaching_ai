part of 'goals_bloc.dart';

@immutable
sealed class GoalsEvent {
  const GoalsEvent();
}

final class LoadGoals extends GoalsEvent {
  const LoadGoals();
}
