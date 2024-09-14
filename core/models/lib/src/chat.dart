import 'package:models/models.dart';

class Chat {
  const Chat({
    required this.messages,
    required this.user,
    this.language = Language.en,
  });

  final List<Message> messages;
  final Language language;
  final User user;

  bool get usesEnglishLanguage => language.isEnglish;
}
