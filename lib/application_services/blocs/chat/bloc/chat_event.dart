part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {
  const ChatEvent();
}

final class LoadingInitialChatStateEvent extends ChatEvent {
  const LoadingInitialChatStateEvent();
}

final class SendMessageEvent extends ChatEvent {
  const SendMessageEvent(this.message);

  final String message;
}

final class RetrySendMessageEvent extends ChatEvent {
  const RetrySendMessageEvent();
}

final class UpdateAiMessageEvent extends ChatEvent {
  const UpdateAiMessageEvent(this.pieceOfMessage);

  final String pieceOfMessage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateAiMessageEvent &&
          runtimeType == other.runtimeType &&
          pieceOfMessage == other.pieceOfMessage;

  @override
  int get hashCode => pieceOfMessage.hashCode;

  @override
  String toString() {
    if (kDebugMode) {
      return 'UpdateAiMessageEvent{pieceOfMessage: $pieceOfMessage}';
    } else {
      return super.toString();
    }
  }
}

final class ChangeLanguageEvent extends ChatEvent {
  const ChangeLanguageEvent(this.language);

  final Language language;
}

final class BugReportPressedEvent extends ChatEvent {
  const BugReportPressedEvent();
}

final class ClosingFeedbackEvent extends ChatEvent {
  const ClosingFeedbackEvent();
}

final class SubmitFeedbackEvent extends ChatEvent {
  const SubmitFeedbackEvent(this.feedback);

  final UserFeedback feedback;
}

final class ChatErrorEvent extends ChatEvent {
  const ChatErrorEvent(this.error);

  final String error;
}

final class FeedbackErrorEvent extends ChatEvent {
  const FeedbackErrorEvent(this.error);

  final String error;
}
