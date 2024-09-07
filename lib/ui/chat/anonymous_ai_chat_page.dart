import 'package:flutter/material.dart';
import 'package:lifecoach/ui/chat/message_bubble.dart';
import 'package:models/models.dart';

class AnonymousAiChatPage extends StatefulWidget {
  const AnonymousAiChatPage({super.key});

  @override
  State<AnonymousAiChatPage> createState() => _AnonymousAiChatPageState();
}

class _AnonymousAiChatPageState extends State<AnonymousAiChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = <Message>[];
  bool _isLoading = false;
  final String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anonymous AI Chat')),
      body: Column(
        children: <Widget>[
          if (_messages.isNotEmpty)
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final Message message = _messages[index];
                  return MessageBubble(
                    message: message,
                    child: Text(message.text),
                  );
                },
              ),
            ),
          if (_isLoading)
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
          if (_messages.isEmpty && _error.isEmpty)
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
                  onPressed: () {
                    setState(() {
                      _messages.clear();
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: _randomPlaceholder,
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                    onSubmitted: (String value) => _sendMessage(),
                  ),
                ),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  child: const Icon(Icons.send),
                  builder: (
                    _,
                    TextEditingValue value,
                    Widget? iconWidget,
                  ) {
                    return IconButton(
                      icon: iconWidget ?? const SizedBox(),
                      onPressed: value.text.isNotEmpty ? _sendMessage : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
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
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages
          .add(Message(owner: MessageOwner.myself, text: _controller.text));
      _isLoading = true;
    });

    // Simulate a network call
    Future<void>.delayed(const Duration(seconds: 2), () {
      setState(() {
        _messages.add(
          const Message(owner: MessageOwner.other, text: '🤔 Thinking...'),
        );
        _isLoading = false;
      });
      _scrollToBottom();
    });
    _controller.clear();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
