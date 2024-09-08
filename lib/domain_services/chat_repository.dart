import 'package:laozi_ai/entities/chat.dart';

abstract interface class ChatRepository {
  const ChatRepository();

  Stream<String> sendChat(Chat chat);
}
