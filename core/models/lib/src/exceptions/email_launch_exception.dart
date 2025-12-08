import 'package:flutter_translate/flutter_translate.dart';

class EmailLaunchException implements Exception {
  const EmailLaunchException(
    this.messageKey, {
    this.args = const <String, Object?>{},
  });

  /// Translation key.
  final String messageKey;

  /// Optional arguments for translation.
  final Map<String, Object?> args;

  String get localizedMessage {
    return translate(messageKey, args: args);
  }

  @override
  String toString() {
    return 'EmailLaunchException: Key "$messageKey"';
  }
}
