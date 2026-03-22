import 'package:models/models.dart';

void main() {
  // User
  const User user = User('user-123');
  print('User id: ${user.id}');
  print('Is anonymous: ${user.isAnonymous}');

  // EmailAddress validation
  const EmailAddress validEmail = EmailAddress.dirty('user@example.com');
  const EmailAddress invalidEmail = EmailAddress.dirty('not-an-email');
  print('Valid email error: ${validEmail.error}');
  print('Invalid email error: ${invalidEmail.error}');

  // Password validation
  const Password validPassword = Password.dirty('secret');
  const Password emptyPassword = Password.dirty('');
  print('Valid password error: ${validPassword.error}');
  print('Empty password error: ${emptyPassword.error}');

  // Goal
  final Goal goal = Goal(
    title: 'Learn Flutter',
    content: 'Complete the Flutter course and build a production app.',
    userId: user.id,
    createdAt: DateTime(2025, 1, 1),
  );
  print('Goal: ${goal.title} — ${goal.content}');
  print('Goal JSON: ${goal.toJson()}');

  final Goal updatedGoal = goal.copyWith(title: 'Master Flutter');
  print('Updated goal title: ${updatedGoal.title}');

  // Message
  final Message userMessage = Message(
    owner: MessageOwner.myself,
    text: StringBuffer('How do I set a goal?'),
  );
  final Message coachReply = Message(
    owner: MessageOwner.other,
    text: StringBuffer('Start with a clear, measurable objective.'),
  );
  print('User message: $userMessage');
  print('Coach reply: $coachReply');
  print('Is mine: ${userMessage.isMine}');
  print('Is other: ${coachReply.isOther}');

  // FeedbackDetails
  final FeedbackDetails feedback = FeedbackDetails(
    feedbackType: FeedbackType.bugReport,
    feedbackText: 'The app crashed on startup.',
  );
  print('Feedback: $feedback');

  final FeedbackDetails ratedFeedback = feedback.copyWith(
    rating: FeedbackRating.bad,
  );
  print('Rated feedback: $ratedFeedback');
}
