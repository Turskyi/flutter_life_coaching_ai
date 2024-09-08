import 'package:models/models.dart';

class Chat {
  const Chat({required this.messages, this.language = Language.en});

  final List<Message> messages;
  final Language language;

  bool get usesEnglishLanguage => language.isEnglish;
}
