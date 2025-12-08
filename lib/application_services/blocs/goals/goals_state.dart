part of 'goals_bloc.dart';

@immutable
sealed class GoalsState {
  const GoalsState({this.goals = const <Goal>[], this.language = Language.en});

  final List<Goal> goals;
  final Language language;
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
  const GoalsError({required this.errorText, super.goals, super.language});

  final String errorText;
}

final class UnauthenticatedGoalsAccessState extends GoalsError {
  const UnauthenticatedGoalsAccessState({required super.errorText});
}

final class GoalsLoaded extends GoalsState {
  const GoalsLoaded({super.goals, super.language});
}

final class FeedbackState extends GoalsState {
  const FeedbackState({required super.goals, required super.language});

  FeedbackState copyWith({List<Goal>? goals, Language? language}) =>
      FeedbackState(
        goals: goals ?? this.goals,
        language: language ?? this.language,
      );

  @override
  String toString() {
    if (kDebugMode) {
      return 'FeedbackState('
          'goals: $goals, '
          'language: $language,'
          ')';
    } else {
      return super.toString();
    }
  }
}

final class FeedbackSent extends GoalsState {
  const FeedbackSent({required super.goals, required super.language});

  FeedbackSent copyWith({List<Goal>? goals, Language? language}) {
    return FeedbackSent(
      goals: goals ?? this.goals,
      language: language ?? this.language,
    );
  }

  @override
  String toString() {
    if (kDebugMode) {
      return 'FeedbackSent('
          'goals: $goals, '
          'language: $language,'
          ')';
    } else {
      return super.toString();
    }
  }
}
