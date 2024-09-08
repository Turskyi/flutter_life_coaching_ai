import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/domain_services/chat_repository.dart';
import 'package:lifecoach/infrastructure/ws/models/chat_request/chat_request.dart';
import 'package:lifecoach/infrastructure/ws/models/chat_request/message_request.dart';
import 'package:lifecoach/infrastructure/ws/rest/retrofit_client/retrofit_client.dart';
import 'package:models/models.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._restClient);

  final RetrofitClient _restClient;

  @override
  Stream<String> sendChat(Chat chat) {
    final ChatRequest request = ChatRequest(
      messages: chat.messages
          .map(
            (Message message) => MessageRequest(
              role: message.owner.role,
              content: '${message.text}',
            ),
          )
          .toList(),
    );

    if (kIsWeb) {
      return chat.usesEnglishLanguage
          ? _processResponse(_restClient.sendEnglishWebChatMessage(request))
          : _processResponse(_restClient.sendUkrainianWebChatMessage(request));
    } else if (Platform.isAndroid) {
      return chat.usesEnglishLanguage
          ? _processResponse(_restClient.sendEnglishAndroidChatMessage(request))
          : _processResponse(
              _restClient.sendUkrainianAndroidChatMessage(request),
            );
    } else if (Platform.isIOS) {
      return chat.usesEnglishLanguage
          ? _processResponse(_restClient.sendEnglishIosChatMessage(request))
          : _processResponse(
              _restClient.sendUkrainianIosChatMessage(request),
            );
    } else {
      return _processResponse(
        _restClient.sendChatMessageOnUnknownPlatform(request),
      );
    }
  }

  Stream<String> _processResponse(Stream<String> response) {
    return response.transform(const LineSplitter()).map((String line) {
      // Use a regular expression to match lines that start with an index
      // and extract the actual content.
      final RegExp regex = RegExp(r'^\d+:"(.+)"$');
      final RegExpMatch? match = regex.firstMatch(line);
      return match?.group(1) ?? '';
    });
  }
}
