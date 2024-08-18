import 'dart:ui' as ui;

import 'package:flutter/material.dart';

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
}

@immutable
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    required this.child,
    super.key,
  });

  final Message message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Alignment messageAlignment =
        message.isMine ? Alignment.topLeft : Alignment.topRight;

    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.8,
      child: Align(
        alignment: messageAlignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: BubbleBackground(
              colors: <Color>[
                if (message.isMine) ...const <Color>[
                  Color(0xFF6C7689),
                  Color(0xFF3A364B),
                ] else ...const <Color>[
                  Color(0xFF19B7FF),
                  Color(0xFF491CCB),
                ],
              ],
              child: DefaultTextStyle.merge(
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class BubbleBackground extends StatelessWidget {
  const BubbleBackground({
    required this.colors,
    super.key,
    this.child,
  });

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
        scrollable: Scrollable.of(context),
        bubbleContext: context,
        colors: colors,
      ),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter({
    required ScrollableState scrollable,
    required BuildContext bubbleContext,
    required List<Color> colors,
  })  : _scrollable = scrollable,
        _bubbleContext = bubbleContext,
        _colors = colors,
        super(repaint: scrollable.position);

  final ScrollableState _scrollable;
  final BuildContext _bubbleContext;
  final List<Color> _colors;

  @override
  void paint(Canvas canvas, Size size) {
    final RenderBox scrollableBox =
        _scrollable.context.findRenderObject() as RenderBox;
    final Rect scrollableRect = Offset.zero & scrollableBox.size;
    final RenderBox bubbleBox = _bubbleContext.findRenderObject() as RenderBox;

    final Offset origin =
        bubbleBox.localToGlobal(Offset.zero, ancestor: scrollableBox);
    final Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        scrollableRect.topCenter,
        scrollableRect.bottomCenter,
        _colors,
        <double>[0.0, 1.0],
        TileMode.clamp,
        Matrix4.translationValues(-origin.dx, -origin.dy, 0.0).storage,
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return oldDelegate._scrollable != _scrollable ||
        oldDelegate._bubbleContext != _bubbleContext ||
        oldDelegate._colors != _colors;
  }
}

enum MessageOwner { myself, other }

@immutable
class Message {
  const Message({
    required this.owner,
    required this.text,
  });

  final MessageOwner owner;
  final String text;

  bool get isMine => owner == MessageOwner.myself;
}
