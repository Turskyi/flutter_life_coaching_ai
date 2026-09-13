import 'package:models/models.dart';

class Message {
  const Message({
    required this.owner,
    required this.text,
    this.modelName,
  });

  final MessageOwner owner;
  final StringBuffer text;
  final String? modelName;

  bool get isMine => owner == MessageOwner.myself;

  bool get isOther => owner == MessageOwner.other;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          owner == other.owner &&
          text.toString() == other.text.toString() &&
          modelName == other.modelName;

  @override
  int get hashCode =>
      owner.hashCode ^ text.hashCode ^ text.length.hashCode ^ modelName.hashCode;

  Message copyWith({
    MessageOwner? owner,
    StringBuffer? text,
    String? modelName,
  }) =>
      Message(
        owner: owner ?? this.owner,
        text: text ?? this.text,
        modelName: modelName ?? this.modelName,
      );

  @override
  String toString() =>
      'Message{role: $owner, content: $text, model: $modelName}';
}
