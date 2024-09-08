import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/blocs/chat/bloc/chat_bloc.dart';
import 'package:lifecoach/ui/chat/message_bubble.dart';
import 'package:models/models.dart';

class AnonymousAiChatPage extends StatefulWidget {
  const AnonymousAiChatPage({super.key});

  @override
  State<AnonymousAiChatPage> createState() => _AnonymousAiChatPageState();
}

class _AnonymousAiChatPageState extends State<AnonymousAiChatPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Anonymous AI Chat')),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (BuildContext context, ChatState state) {
          final int itemCount = state is ChatError || state is SentMessageState
              // Add extra space for the error message or thinking message.
              ? state.messages.length + 1
              : state.messages.length;
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
                        onSubmitted: (String value) => _sendMessage(),
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
}
