import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/application_services/blocs/chat/bloc/chat_bloc.dart';
import 'package:lifecoach/ui/chat/message_bubble.dart';
import 'package:models/models.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  FeedbackController? _feedbackController;

  @override
  void didChangeDependencies() {
    _feedbackController = BetterFeedback.of(context);
    super.didChangeDependencies();
  }

  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Life-Coach AI Chat'),
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
          return Column(
            children: <Widget>[
              if (state.messages.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: itemCount,
                    itemBuilder: (_, int index) {
                      // Check if the current item is the last one and the state
                      // is `ChatError`.
                      if (index == state.messages.length &&
                          state is ChatError) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.redAccent, // Improved contrast
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Text(
                              state.errorMessage,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              onPressed: () => context
                                  .read<ChatBloc>()
                                  .add(const RetrySendMessageEvent()),
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
                            text: StringBuffer('🤔 Thinking...'),
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '😨 Something went wrong. Please try again.',
                    style: TextStyle(color: Colors.red),
                  ),
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
                        Text(
                          _randomEmptyStateMessage,
                          style: const TextStyle(fontSize: 18),
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
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _textEditingController,
                      child: const Icon(Icons.send),
                      builder: (
                        _,
                        TextEditingValue value,
                        Widget? iconWidget,
                      ) {
                        return IconButton(
                          icon: iconWidget ?? const SizedBox(),
                          onPressed:
                              value.text.isNotEmpty ? _sendMessage : null,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _feedbackController?.dispose();
    super.dispose();
  }

  String get _randomPlaceholder => _placeholders[(_placeholders.length *
          (0.5 + 0.5 * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000))
      .toInt()];

  String get _randomEmptyStateMessage => emptyStateMessages[(emptyStateMessages
              .length *
          (0.5 + 0.5 * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000))
      .toInt()];

  void _sendMessage() {
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
    _feedbackController?.show(
      (UserFeedback feedback) =>
          context.read<ChatBloc>().add(SubmitFeedbackEvent(feedback)),
    );
    _feedbackController?.addListener(_onFeedbackChanged);
  }

  void _onFeedbackChanged() {
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

  static const List<String> _placeholders = <String>[
    'Share your thoughts...',
    "What's on your mind?",
    'How can I assist you today?',
    'What are you thinking about?',
    'Need some guidance?',
    "Let's explore your goals...",
    "What's your next big idea?",
    'How can I help you today?',
    "What's your current challenge?",
    'Tell me your thoughts...',
    "What's on your agenda?",
    'What would you like to discuss?',
    'Ready to unlock your potential?',
  ];

  static const List<String> emptyStateMessages = <String>[
    'What would you like to achieve today?',
    'Share your goals with the Life-Coach AI.',
    "Let's start your journey. Ask me anything!",
    'How can I help you reach your potential?',
    'Tell me about your aspirations.',
    "Ready to set some goals? Let's chat!",
    "What's your next big step?",
    "Need some guidance? I'm here to help.",
    "What's on your mind today?",
    "Let's explore your dreams together.",
  ];

  void _showFeedbackDialog() =>
      context.read<ChatBloc>().add(const BugReportPressedEvent());
}
