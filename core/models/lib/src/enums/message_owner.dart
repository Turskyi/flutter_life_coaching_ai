enum MessageOwner {
  myself(role: 'user'),
  other(role: 'assistant');

  const MessageOwner({required this.role});

  final String role;

  bool get isOther => this == MessageOwner.other;
}
