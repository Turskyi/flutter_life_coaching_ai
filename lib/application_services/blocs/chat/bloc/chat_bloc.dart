import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/domain_services/chat_repository.dart';
import 'package:lifecoach/domain_services/settings_repository.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:models/models.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_repository/user_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(
    this._chatRepository,
    this._settingsRepository,
    this._userRepository,
  ) : super(const LoadingChatState(user: User(''))) {
    on<LoadingInitialChatStateEvent>(_onLoadingInitialChatState);

    on<SendMessageEvent>(_onSendMessage);

    on<UpdateAiMessageEvent>(_onUpdateAiMessage);

    on<ChangeLanguageEvent>(_onChangeLanguage);

    on<BugReportPressedEvent>(_onBugReportPressed);

    on<ClosingFeedbackEvent>(_onClosingFeedback);

    on<SubmitFeedbackEvent>(_onSubmitFeedback);

    on<RetrySendMessageEvent>(_onRetrySendMessage);

    on<ChatErrorEvent>(_onChatError);

    on<FeedbackErrorEvent>(_onFeedbackError);
  }

  final ChatRepository _chatRepository;
  final SettingsRepository _settingsRepository;
  final UserRepository _userRepository;

  Future<String> _writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }

  User _getUser() {
    final User user = _userRepository.getUser();
    return user;
  }

  FutureOr<void> _onLoadingInitialChatState(
    LoadingInitialChatStateEvent _,
    Emitter<ChatState> emit,
  ) {
    final Language savedLanguage = _settingsRepository.getLanguage();
    emit(
      ChatInitial(
        language: savedLanguage,
        messages: state.messages,
        user: _getUser(),
      ),
    );
  }

  FutureOr<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) {
    // Create a new list of messages by adding the new message to the
    // existing list.
    final List<Message> updatedMessages = List<Message>.from(state.messages)
      ..add(
        Message(
          owner: MessageOwner.myself,
          text: StringBuffer(event.message),
        ),
      );
    // Emit a new state with the updated list of messages.
    emit(
      SentMessageState(
        messages: updatedMessages,
        language: state.language,
        user: _getUser(),
      ),
    );
    try {
      final User user = _getUser();
      _chatRepository
          .sendChat(
        Chat(
          user: user,
          messages: updatedMessages,
          language: state.language,
        ),
      )
          .listen(
        (String line) => add(UpdateAiMessageEvent(line)),
        onError: (Object error, StackTrace stackTrace) {
          debugPrint(
            'Error in $runtimeType in `onError`: $error.\n'
            'Stacktrace: $stackTrace',
          );
          if (error is DioException) {
            if (kIsWeb && kDebugMode) {
              add(ChatErrorEvent(translate('error.cors')));
            } else {
              add(ChatErrorEvent(translate('error.pleaseCheckInternet')));
            }
          } else {
            add(ChatErrorEvent(translate('error.unexpectedError')));
          }
        },
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Error in $runtimeType in `catch`: $error.\nStacktrace: $stackTrace',
      );
      add(ChatErrorEvent(translate('error.oops')));
    }
  }

  FutureOr<void> _onUpdateAiMessage(
    UpdateAiMessageEvent event,
    Emitter<ChatState> emit,
  ) {
    if (state.messages.isNotEmpty && state.messages.last.isOther) {
      // Copy the last message and update its content.
      final List<Message> updatedMessages = List<Message>.from(state.messages);
      final Message lastMessage = updatedMessages.removeLast();
      final Message updatedLastMessage = lastMessage.copyWith(
        text: StringBuffer(
          lastMessage.text.toString() + event.pieceOfMessage,
        ),
      );
      updatedMessages.add(updatedLastMessage);

      emit(
        AiMessageUpdated(
          messages: updatedMessages,
          language: state.language,
          user: _getUser(),
        ),
      );
    } else {
      // Add a new AI message.
      final List<Message> updatedMessages = List<Message>.from(state.messages)
        ..add(
          Message(
            owner: MessageOwner.other,
            text: StringBuffer(event.pieceOfMessage),
          ),
        );

      emit(
        AiMessageUpdated(
          messages: updatedMessages,
          language: state.language,
          user: _getUser(),
        ),
      );
    }
  }

  FutureOr<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final Language language = event.language;
    if (language != state.language) {
      final bool isSaved = await _settingsRepository
          .saveLanguageIsoCode(language.isoLanguageCode);
      if (isSaved) {
        emit(
          switch (state) {
            ChatInitial() =>
              (state as ChatInitial).copyWith(language: language),
            ChatError() => (state as ChatError).copyWith(language: language),
            SentMessageState() =>
              (state as SentMessageState).copyWith(language: language),
            AiMessageUpdated() =>
              (state as AiMessageUpdated).copyWith(language: language),
            LoadingChatState() =>
              (state as LoadingChatState).copyWith(language: language),
            FeedbackState() =>
              (state as FeedbackState).copyWith(language: language),
            FeedbackSent() =>
              (state as FeedbackSent).copyWith(language: language),
          },
        );
      } else {
        add(const LoadingInitialChatStateEvent());
      }
    }
  }

  FutureOr<void> _onBugReportPressed(
    BugReportPressedEvent _,
    Emitter<ChatState> emit,
  ) {
    emit(
      FeedbackState(
        messages: state.messages,
        language: state.language,
        user: _getUser(),
      ),
    );
  }

  FutureOr<void> _onClosingFeedback(
    ClosingFeedbackEvent _,
    Emitter<ChatState> emit,
  ) {
    emit(
      AiMessageUpdated(
        messages: state.messages,
        language: state.language,
        user: _getUser(),
      ),
    );
  }

  FutureOr<void> _onSubmitFeedback(
    SubmitFeedbackEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(
      LoadingChatState(
        messages: state.messages,
        language: state.language,
        user: _getUser(),
      ),
    );
    final UserFeedback feedback = event.feedback;
    try {
      final String screenshotFilePath =
          await _writeImageToStorage(feedback.screenshot);

      final PackageInfo packageInfo = await PackageInfo.fromPlatform();

      final Map<String, dynamic>? extra = feedback.extra;
      final dynamic rating = extra?['rating'];
      final dynamic type = extra?['feedback_type'];

      // Construct the feedback text with details from `extra'.
      final StringBuffer feedbackBody = StringBuffer()
        ..writeln('${type is FeedbackType ? translate('feedback.type') : ''}:'
            ' ${type is FeedbackType ? type.value : ''}')
        ..writeln()
        ..writeln(feedback.text)
        ..writeln()
        ..writeln('${translate('appId')}: ${packageInfo.packageName}')
        ..writeln('${translate('appVersion')}: ${packageInfo.version}')
        ..writeln('${translate('buildNumber')}: ${packageInfo.buildNumber}')
        ..writeln()
        ..writeln(
            '${rating is FeedbackRating ? translate('feedback.rating') : ''}'
            '${rating is FeedbackRating ? ':' : ''}'
            ' ${rating is FeedbackRating ? rating.value : ''}');

      final Email email = Email(
        body: feedbackBody.toString(),
        subject: '${translate('feedback.appFeedback')}: '
            '${packageInfo.appName}',
        recipients: <String>[constants.supportEmail],
        attachmentPaths: <String>[screenshotFilePath],
      );
      try {
        await FlutterEmailSender.send(email);
      } catch (error, stackTrace) {
        if (error is PlatformException) {
          add(
            FeedbackErrorEvent(
              error.message ?? translate('error.unexpectedError'),
            ),
          );
        } else {
          debugPrint(
            'Error in $runtimeType in `onError`: $error.\n'
            'Stacktrace: $stackTrace',
          );
          add(FeedbackErrorEvent(translate('error.unexpectedError')));
        }
      }
    } catch (error, stackTrace) {
      debugPrint(
        'Error in $runtimeType in `onError`: $error.\n'
        'Stacktrace: $stackTrace',
      );
      add(FeedbackErrorEvent(translate('error.unexpectedError')));
    }
    emit(
      AiMessageUpdated(
        messages: state.messages,
        language: state.language,
        user: _getUser(),
      ),
    );
  }

  FutureOr<void> _onRetrySendMessage(
    RetrySendMessageEvent _,
    Emitter<ChatState> emit,
  ) async {
    final List<Message> currentMessages = List<Message>.from(state.messages);
    emit(
      SentMessageState(
        messages: currentMessages,
        language: state.language,
        user: _getUser(),
      ),
    );
    _chatRepository
        .sendChat(
      Chat(
        user: _getUser(),
        messages: currentMessages,
        language: state.language,
      ),
    )
        .listen(
      (String line) => add(UpdateAiMessageEvent(line)),
      onError: (Object error, StackTrace stackTrace) {
        if (error is DioException) {
          add(ChatErrorEvent(translate('error.pleaseCheckInternet')));
        } else {
          debugPrint(
            'Error in $runtimeType in `onError`: $error.\n'
            'Stacktrace: $stackTrace',
          );
          add(ChatErrorEvent(translate('error.unexpectedError')));
        }
      },
    );
  }

  FutureOr<void> _onChatError(ChatErrorEvent event, Emitter<ChatState> emit) {
    emit(
      ChatError(
        errorMessage: event.error,
        messages: state.messages,
        language: state.language,
        user: _getUser(),
      ),
    );
  }

  FutureOr<void> _onFeedbackError(
    FeedbackErrorEvent event,
    Emitter<ChatState> emit,
  ) {
    emit(
      FeedbackError(
        errorMessage: event.error,
        messages: state.messages,
        language: state.language,
        user: _getUser(),
      ),
    );
  }
}
