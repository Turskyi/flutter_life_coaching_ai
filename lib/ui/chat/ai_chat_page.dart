import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/application_services/blocs/chat/bloc/chat_bloc.dart';
import 'package:lifecoach/domain_services/ai_consent_repository.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/ui/chat/message_bubble.dart';
import 'package:lifecoach/ui/dialogs/ai_consent_dialog.dart';
import 'package:models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  FeedbackController? _feedbackController;

  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: BlocBuilder<ChatBloc, ChatState>(
          builder: (BuildContext _, ChatState state) {
            return Text(
              '${state.user.isAnonymous ? '${translate('chat.anonymous')} ' : ''
                        ''}${translate('chat.title')}',
            );
          },
        ),
        actions: <Widget>[
          BlocConsumer<ChatBloc, ChatState>(
            listener: (_, ChatState state) {
              if (state is FeedbackState) {
                _showFeedbackUi();
              } else if (state is FeedbackSent) {
                _notifyFeedbackSent();
              }
            },
            builder: (BuildContext context, ChatState state) {
              if (state.messages.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.feedback),
                  onPressed: _showFeedbackDialog,
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (BuildContext context, ChatState state) {
          final int itemCount = state is ChatError || state is SentMessageState
              // Add extra space for the error message or thinking message.
              ? state.messages.length + 1
              : state.messages.length;
          if (state is ChatError) {
            _error = state.errorMessage;
          } else {
            _error = '';
          }

          Widget errorDisplayWidget;
          const String officialWebsiteUrl = constants.website;

          if (kIsWeb) {
            errorDisplayWidget = SelectableText.rich(
              textAlign: TextAlign.center,
              TextSpan(
                style: DefaultTextStyle.of(
                  context,
                ).style.copyWith(color: Theme.of(context).colorScheme.error),
                children: <TextSpan>[
                  TextSpan(text: translate('chat.something_went_wrong')),
                  TextSpan(text: translate('chat.please_use_official_website')),
                  TextSpan(
                    text: officialWebsiteUrl,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final Uri url = Uri.parse(officialWebsiteUrl);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, webOnlyWindowName: '_blank');
                        } else {
                          debugPrint('Could not launch $officialWebsiteUrl');
                        }
                      },
                  ),
                ],
              ),
            );
          } else {
            errorDisplayWidget = SelectableText(
              '${translate('chat.something_went_wrong')}'
              '${translate('chat.please_try_again')}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
              textAlign: TextAlign.center,
            );
          }

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: <Widget>[
                if (state.messages.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: itemCount,
                      itemBuilder: (_, int index) {
                        // Check if the current item is the last one and the
                        // state is `ChatError`.
                        if (index == state.messages.length &&
                            state is ChatError) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 15.0,
                            ),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              title: SelectableText(
                                state.errorMessage,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onErrorContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.refresh,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onErrorContainer,
                                ),
                                onPressed: () => context.read<ChatBloc>().add(
                                  const RetrySendMessageEvent(),
                                ),
                              ),
                            ),
                          );
                        }
                        // Handle the extra message for `SentMessageState`.
                        if (index == state.messages.length &&
                            state is SentMessageState) {
                          return MessageBubble(
                            message: Message(
                              owner: MessageOwner.other,
                              text: StringBuffer(translate('chat.thinking')),
                            ),
                          );
                        }

                        final Message message = state.messages[index];
                        return MessageBubble(message: message);
                      },
                    ),
                  ),
                if (state is SentMessageState)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                if (_error.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: errorDisplayWidget,
                  ),
                if (state.messages.isEmpty && _error.isEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.chat_bubble_outline),
                          const SizedBox(width: 8.0),
                          Flexible(
                            child: Text(
                              _randomEmptyStateMessage,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => setState(state.messages.clear),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: _randomPlaceholder,
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _textEditingController,
                        child: const Icon(Icons.send),
                        builder:
                            (_, TextEditingValue value, Widget? iconWidget) {
                              return IconButton(
                                icon: iconWidget ?? const SizedBox(),
                                onPressed: value.text.isNotEmpty
                                    ? _sendMessage
                                    : null,
                              );
                            },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    // Remove the listener FIRST.
    _feedbackController?.removeListener(_onFeedbackChanged);
    _feedbackController?.dispose();
    _feedbackController = null;
    super.dispose();
  }

  String get _randomPlaceholder {
    final List<String> placeholders = _placeholders;
    return placeholders[(_placeholdersCount *
            (0.5 + 0.5 * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000))
        .toInt()];
  }

  String get _randomEmptyStateMessage {
    final List<String> messages = _emptyStateMessages;
    return messages[(_emptyStateMessagesCount *
            (0.5 + 0.5 * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000))
        .toInt()];
  }

  int get _placeholdersCount => _placeholders.length;

  int get _emptyStateMessagesCount => _emptyStateMessages.length;

  List<String> get _placeholders => <String>[
    translate('chat.placeholders.0'),
    translate('chat.placeholders.1'),
    translate('chat.placeholders.2'),
    translate('chat.placeholders.3'),
    translate('chat.placeholders.4'),
    translate('chat.placeholders.5'),
    translate('chat.placeholders.6'),
    translate('chat.placeholders.7'),
    translate('chat.placeholders.8'),
    translate('chat.placeholders.9'),
    translate('chat.placeholders.10'),
    translate('chat.placeholders.11'),
    translate('chat.placeholders.12'),
  ];

  List<String> get _emptyStateMessages => <String>[
    translate('chat.empty_state_messages.0'),
    translate('chat.empty_state_messages.1'),
    translate('chat.empty_state_messages.2'),
    translate('chat.empty_state_messages.3'),
    translate('chat.empty_state_messages.4'),
    translate('chat.empty_state_messages.5'),
    translate('chat.empty_state_messages.6'),
    translate('chat.empty_state_messages.7'),
    translate('chat.empty_state_messages.8'),
    translate('chat.empty_state_messages.9'),
  ];

  void _sendMessage() {
    if (_textEditingController.text.isEmpty) return;
    _checkConsentAndSend();
  }

  Future<void> _checkConsentAndSend() async {
    final AiConsentRepository consentRepository =
        GetIt.instance<AiConsentRepository>();

    final bool hasConsent = await consentRepository.hasAiConsent();

    if (!hasConsent) {
      // Show consent dialog and wait for user response
      if (!mounted) return;

      final bool? userConsented = await AiConsentDialog.show(context);

      if (userConsented == true) {
        // User agreed to AI processing
        await consentRepository.setAiConsent(true);

        // Send the message
        if (mounted) {
          _sendChatMessage();
        }
      }
      // If userConsented is false or null, don't send the message
    } else {
      // Consent already given, send the message
      _sendChatMessage();
    }
  }

  void _sendChatMessage() {
    if (_textEditingController.text.isEmpty) return;
    context.read<ChatBloc>().add(SendMessageEvent(_textEditingController.text));

    _scrollToBottom();

    _textEditingController.clear();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showFeedbackUi() {
    _feedbackController ??= BetterFeedback.of(context);

    _feedbackController?.show(
      (UserFeedback feedback) =>
          context.read<ChatBloc>().add(SubmitFeedbackEvent(feedback)),
    );
    _feedbackController?.addListener(_onFeedbackChanged);
  }

  void _onFeedbackChanged() {
    _feedbackController ??= BetterFeedback.of(context);

    final bool? isVisible = _feedbackController?.isVisible;
    if (isVisible == false) {
      _feedbackController?.removeListener(_onFeedbackChanged);
      context.read<ChatBloc>().add(const ClosingFeedbackEvent());
    }
  }

  void _notifyFeedbackSent() {
    BetterFeedback.of(context).hide();
    // Let user know that his feedback is sent.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(translate('feedback.feedbackSent')),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showFeedbackDialog() {
    context.read<ChatBloc>().add(const BugReportPressedEvent());
  }
}
