part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {
  const ChatEvent();
}

final class LoadHomeEvent extends ChatEvent {
  const LoadHomeEvent();
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
    return 'UpdateAiMessageEvent{pieceOfMessage: $pieceOfMessage}';
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

final class ErrorEvent extends ChatEvent {
  const ErrorEvent(this.error);

  final String error;
}
