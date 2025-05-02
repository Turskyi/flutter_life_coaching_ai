part of 'chat_bloc.dart';

@immutable
sealed class ChatState {
  const ChatState({
    required this.user,
    this.messages = const <Message>[],
    this.language = Language.en,
  });

  final Language language;
  final List<Message> messages;
  final User user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatState &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          language == other.language &&
          messages == other.messages;

  @override
  int get hashCode => language.hashCode ^ messages.hashCode;

  @override
  String toString() => 'ChatState('
      'messages: $messages, '
      'language: $language,'
      'user: $user'
      ')';
}

final class ChatInitial extends ChatState {
  const ChatInitial({
    required super.language,
    required super.user,
    super.messages,
  });

  ChatInitial copyWith({
    List<Message>? messages,
    Language? language,
    User? user,
  }) =>
      ChatInitial(
        messages: messages ?? this.messages,
        language: language ?? this.language,
        user: user ?? this.user,
      );

  @override
  String toString() => 'ChatInitial('
      'messages: $messages, '
      'language: $language,'
      'user: $user'
      ')';
}

final class LoadingChatState extends ChatState {
  const LoadingChatState({required super.user, super.messages, super.language});

  LoadingChatState copyWith({
    List<Message>? messages,
    Language? language,
    User? user,
  }) =>
      LoadingChatState(
        messages: messages ?? this.messages,
        language: language ?? this.language,
        user: user ?? this.user,
      );

  @override
  String toString() => 'LoadingHomeState('
      'messages: $messages, '
      'language: $language,'
      'user: $user'
      ')';
}

final class ChatError extends ChatState {
  const ChatError({
    required super.user,
    required this.errorMessage,
    required super.language,
    super.messages,
  });

  final String errorMessage;

  ChatError copyWith({
    User? user,
    String? errorMessage,
    List<Message>? messages,
    Language? language,
  }) =>
      ChatError(
        user: user ?? this.user,
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
        other.user == user &&
        other.messages == messages;
  }

  @override
  int get hashCode =>
      errorMessage.hashCode ^
      language.hashCode ^
      messages.hashCode ^
      user.hashCode;

  @override
  String toString() => 'ChatError('
      'errorMessage: $errorMessage, '
      'messages: $messages, '
      'language: $language,'
      'user: $user'
      ')';
}

final class AiMessageUpdated extends ChatState {
  const AiMessageUpdated({
    required super.user,
    required super.messages,
    required super.language,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AiMessageUpdated &&
          runtimeType == other.runtimeType &&
          language == other.language &&
          user == other.user &&
          messages == other.messages;

  @override
  int get hashCode => Object.hash(language, messages);

  AiMessageUpdated copyWith({
    List<Message>? messages,
    Language? language,
    User? user,
  }) =>
      AiMessageUpdated(
        messages: messages ?? this.messages,
        language: language ?? this.language,
        user: user ?? this.user,
      );

  @override
  String toString() => 'AiMessageUpdated('
      'messages: $messages, '
      'language: $language,'
      'user: $user'
      ')';
}

final class SentMessageState extends ChatState {
  const SentMessageState({
    required super.user,
    required super.messages,
    required super.language,
  });

  SentMessageState copyWith({
    List<Message>? messages,
    Language? language,
    User? user,
  }) =>
      SentMessageState(
        messages: messages ?? this.messages,
        language: language ?? this.language,
        user: user ?? this.user,
      );

  @override
  String toString() => 'SentMessageState('
      'messages: $messages, '
      'language: $language,'
      'user: $user'
      ')';
}

final class FeedbackState extends ChatState {
  const FeedbackState({
    required super.messages,
    required super.language,
    required super.user,
  });

  FeedbackState copyWith({
    List<Message>? messages,
    Language? language,
    User? user,
  }) =>
      FeedbackState(
        messages: messages ?? this.messages,
        language: language ?? this.language,
        user: user ?? this.user,
      );

  @override
  String toString() => 'FeedbackState('
      'messages: $messages, '
      'language: $language,'
      'user: $user'
      ')';
}

final class FeedbackSent extends ChatState {
  const FeedbackSent({
    required super.messages,
    required super.language,
    required super.user,
  });

  FeedbackSent copyWith({
    List<Message>? messages,
    Language? language,
    User? user,
  }) =>
      FeedbackSent(
        messages: messages ?? this.messages,
        language: language ?? this.language,
        user: user ?? this.user,
      );

  @override
  String toString() => 'FeedbackSent('
      'messages: $messages, '
      'language: $language,'
      'user: $user'
      ')';
}

final class FeedbackError extends FeedbackState {
  const FeedbackError({
    required super.user,
    required this.errorMessage,
    required super.language,
    required super.messages,
  });

  final String errorMessage;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatError &&
        other.errorMessage == errorMessage &&
        other.language == language &&
        other.user == user &&
        other.messages == messages;
  }

  @override
  int get hashCode =>
      errorMessage.hashCode ^
      language.hashCode ^
      messages.hashCode ^
      user.hashCode;

  @override
  String toString() => 'FeedbackError('
      'errorMessage: $errorMessage, '
      'messages: $messages, '
      'language: $language,'
      'user: $user'
      ')';
}
