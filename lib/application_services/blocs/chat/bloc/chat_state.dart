part of 'chat_bloc.dart';

@immutable
sealed class ChatState {
  const ChatState({
    this.messages = const <Message>[],
    this.language = Language.en,
  });

  final Language language;
  final List<Message> messages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatState &&
          runtimeType == other.runtimeType &&
          language == other.language &&
          messages == other.messages;

  @override
  int get hashCode => language.hashCode ^ messages.hashCode;

  @override
  String toString() => 'ChatState(messages: $messages, language: $language)';
}

final class ChatInitial extends ChatState {
  const ChatInitial({required super.language, super.messages});

  ChatInitial copyWith({
    List<Message>? messages,
    Language? language,
  }) =>
      ChatInitial(
        messages: messages ?? this.messages,
        language: language ?? this.language,
      );

  @override
  String toString() => 'ChatInitial(messages: $messages, language: $language)';
}

final class LoadingHomeState extends ChatState {
  const LoadingHomeState({super.messages, super.language});

  LoadingHomeState copyWith({
    List<Message>? messages,
    Language? language,
  }) =>
      LoadingHomeState(
        messages: messages ?? this.messages,
        language: language ?? this.language,
      );

  @override
  String toString() =>
      'LoadingHomeState(messages: $messages, language: $language)';
}

final class ChatError extends ChatState {
  const ChatError({
    required this.errorMessage,
    required super.language,
    super.messages,
  });

  final String errorMessage;

  ChatError copyWith({
    String? errorMessage,
    List<Message>? messages,
    Language? language,
  }) =>
      ChatError(
        errorMessage: errorMessage ?? this.errorMessage,
        messages: messages ?? this.messages,
        language: language ?? this.language,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatError &&
        other.errorMessage == errorMessage &&
        other.language == language &&
        other.messages == messages;
  }

  @override
  int get hashCode =>
      errorMessage.hashCode ^ language.hashCode ^ messages.hashCode;

  @override
  String toString() => 'ChatError(errorMessage: $errorMessage, '
      'messages: $messages, '
      'language: $language)';
}

final class AiMessageUpdated extends ChatState {
  const AiMessageUpdated({required super.messages, required super.language});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AiMessageUpdated &&
          runtimeType == other.runtimeType &&
          language == other.language &&
          messages == other.messages;

  @override
  int get hashCode => Object.hash(language, messages);

  AiMessageUpdated copyWith({
    List<Message>? messages,
    Language? language,
  }) =>
      AiMessageUpdated(
        messages: messages ?? this.messages,
        language: language ?? this.language,
      );

  @override
  String toString() =>
      'AiMessageUpdated(messages: $messages, language: $language)';
}

final class SentMessageState extends ChatState {
  const SentMessageState({required super.messages, required super.language});

  SentMessageState copyWith({
    List<Message>? messages,
    Language? language,
  }) =>
      SentMessageState(
        messages: messages ?? this.messages,
        language: language ?? this.language,
      );

  @override
  String toString() =>
      'SentMessageState(messages: $messages, language: $language)';
}

final class FeedbackState extends ChatState {
  const FeedbackState({
    required super.messages,
    required super.language,
  });

  FeedbackState copyWith({
    List<Message>? messages,
    Language? language,
  }) =>
      FeedbackState(
        messages: messages ?? this.messages,
        language: language ?? this.language,
      );

  @override
  String toString() =>
      'FeedbackState(messages: $messages, language: $language)';
}

final class FeedbackSent extends ChatState {
  const FeedbackSent({required super.messages, required super.language});

  FeedbackSent copyWith({
    List<Message>? messages,
    Language? language,
  }) =>
      FeedbackSent(
        messages: messages ?? this.messages,
        language: language ?? this.language,
      );

  @override
  String toString() => 'FeedbackSent(messages: $messages, language: $language)';
}
