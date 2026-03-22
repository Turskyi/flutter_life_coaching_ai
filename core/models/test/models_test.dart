import 'package:models/models.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('isAnonymous is true for empty id', () {
      expect(const User('').isAnonymous, isTrue);
    });

    test('isAnonymous is false for non-empty id', () {
      expect(const User('abc').isAnonymous, isFalse);
    });

    test('isNotAnonymous is true for non-empty id', () {
      expect(const User('abc').isNotAnonymous, isTrue);
    });

    test('anonymous singleton has empty id', () {
      expect(User.anonymous.id, isEmpty);
    });

    test('equality holds for same id', () {
      expect(const User('x'), equals(const User('x')));
    });
  });

  group('EmailAddress', () {
    test('pure state isPure', () {
      expect(const EmailAddress.pure().isPure, isTrue);
    });

    test('pure state displayError is null', () {
      expect(const EmailAddress.pure().displayError, isNull);
    });

    test('valid email has no error', () {
      expect(const EmailAddress.dirty('user@example.com').error, isNull);
    });

    test('invalid email returns EmptyEmailValidationError', () {
      expect(
        const EmailAddress.dirty('not-an-email').error,
        isA<EmptyEmailValidationError>(),
      );
    });

    test('empty string returns EmptyEmailValidationError', () {
      expect(
        const EmailAddress.dirty('').error,
        isA<EmptyEmailValidationError>(),
      );
    });
  });

  group('Password', () {
    test('pure state isPure', () {
      expect(const Password.pure().isPure, isTrue);
    });

    test('pure state displayError is null', () {
      expect(const Password.pure().displayError, isNull);
    });

    test('non-empty password has no error', () {
      expect(const Password.dirty('secret').error, isNull);
    });

    test('empty password returns EmptyPasswordValidationError', () {
      expect(
        const Password.dirty('').error,
        isA<EmptyPasswordValidationError>(),
      );
    });
  });

  group('Code', () {
    test('pure state isPure', () {
      expect(const Code.pure().isPure, isTrue);
    });

    test('pure state displayError is null', () {
      expect(const Code.pure().displayError, isNull);
    });

    test('non-empty code has no error', () {
      expect(const Code.dirty('123456').error, isNull);
    });

    test('empty code returns EmptyCodeValidationError', () {
      expect(const Code.dirty('').error, isA<EmptyCodeValidationError>());
    });
  });

  group('Goal', () {
    final Goal goal = Goal(
      title: 'Learn Flutter',
      content: 'Build a production app.',
      userId: 'user-1',
      createdAt: DateTime(2025, 1, 1),
    );

    test('toJson / fromJson round-trip', () {
      final Map<String, dynamic> json = goal.toJson();
      final Goal restored = Goal.fromJson(json);
      expect(restored, equals(goal));
    });

    test('copyWith updates title', () {
      final Goal updated = goal.copyWith(title: 'Master Flutter');
      expect(updated.title, 'Master Flutter');
      expect(updated.content, goal.content);
      expect(updated.userId, goal.userId);
    });

    test('equality holds for identical data', () {
      final Goal duplicate = Goal(
        title: goal.title,
        content: goal.content,
        userId: goal.userId,
        id: goal.id,
        createdAt: goal.createdAt,
      );
      expect(duplicate, equals(goal));
    });
  });

  group('Message', () {
    final Message userMsg = Message(
      owner: MessageOwner.myself,
      text: StringBuffer('Hello'),
    );
    final Message coachMsg = Message(
      owner: MessageOwner.other,
      text: StringBuffer('Hi there'),
    );

    test('isMine is true for myself owner', () {
      expect(userMsg.isMine, isTrue);
    });

    test('isOther is true for other owner', () {
      expect(coachMsg.isOther, isTrue);
    });

    test('copyWith replaces text', () {
      final Message updated = userMsg.copyWith(text: StringBuffer('Updated'));
      expect(updated.text.toString(), 'Updated');
      expect(updated.owner, MessageOwner.myself);
    });

    test('equality holds for same owner and text', () {
      final Message duplicate = Message(
        owner: MessageOwner.myself,
        text: StringBuffer('Hello'),
      );
      expect(duplicate, equals(userMsg));
    });
  });

  group('MessageOwner', () {
    test('myself has role user', () {
      expect(MessageOwner.myself.role, 'user');
    });

    test('other has role assistant', () {
      expect(MessageOwner.other.role, 'assistant');
    });

    test('isOther is false for myself', () {
      expect(MessageOwner.myself.isOther, isFalse);
    });

    test('isOther is true for other', () {
      expect(MessageOwner.other.isOther, isTrue);
    });
  });

  group('FeedbackDetails', () {
    const FeedbackDetails feedback = FeedbackDetails(
      feedbackType: FeedbackType.bugReport,
      feedbackText: 'App crashed.',
    );

    test('copyWith replaces rating', () {
      final FeedbackDetails updated = feedback.copyWith(
        rating: FeedbackRating.bad,
      );
      expect(updated.rating, FeedbackRating.bad);
      expect(updated.feedbackType, FeedbackType.bugReport);
    });

    test('toString contains feedback_type and feedback_text', () {
      final String str = feedback.toString();
      expect(str, contains('feedback_type'));
      expect(str, contains('feedback_text'));
    });
  });
}
