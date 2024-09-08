import 'package:laozi_ai/entities/enums/language.dart';
import 'package:laozi_ai/entities/message.dart';

class Chat {
  const Chat({required this.messages, this.language = Language.en});

  final List<Message> messages;
  final Language language;

  bool get usesEnglishLanguage => language.isEnglish;
}
