import 'package:models/models.dart';

class Message {
  const Message({
    required this.owner,
    required this.text,
  });

  final MessageOwner owner;
  final StringBuffer text;

  bool get isMine => owner == MessageOwner.myself;

  bool get isOther => owner == MessageOwner.other;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          owner == other.owner &&
          text.toString() == other.text.toString();

  @override
  int get hashCode => owner.hashCode ^ text.hashCode ^ text.length.hashCode;

  Message copyWith({MessageOwner? owner, StringBuffer? text}) =>
      Message(owner: owner ?? this.owner, text: text ?? this.text);

  @override
  String toString() => 'Message{role: $owner, content: $text}';
}
