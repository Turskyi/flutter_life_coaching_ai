import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'delete_account_response.g.dart';

@JsonSerializable()
class DeleteAccountResponse implements MessageResponse {
  const DeleteAccountResponse({required this.message});

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) {
    return _$DeleteAccountResponseFromJson(json);
  }

  @override
  @JsonKey(name: 'message')
  final String message;

  @override
  String toString() {
    if (kDebugMode) {
      return 'DeleteAccountResponse(message: $message)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$DeleteAccountResponseToJson(this);

  DeleteAccountResponse copyWith({
    String? message,
  }) =>
      DeleteAccountResponse(
        message: message ?? this.message,
      );

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DeleteAccountResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => message.hashCode;
}
