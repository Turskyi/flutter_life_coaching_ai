import 'package:models/models.dart';

abstract interface class ChatRepository {
  const ChatRepository();

  Stream<String> sendChat(Chat chat);
}
