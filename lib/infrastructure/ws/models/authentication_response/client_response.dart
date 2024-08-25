import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'session_response.dart';

part 'client_response.g.dart';

@JsonSerializable()
class ClientResponse {
  const ClientResponse({
    required this.sessions,
    this.object,
    this.id,
    this.signIn,
    this.signUp,
    this.lastActiveSessionId,
    this.createdAt,
    this.updatedAt,
  });

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    return _$ClientResponseFromJson(json);
  }

  final String? object;
  final String? id;
  final List<SessionResponse> sessions;
  @JsonKey(name: 'sign_in')
  final dynamic signIn;
  @JsonKey(name: 'sign_up')
  final dynamic signUp;
  @JsonKey(name: 'last_active_session_id')
  final String? lastActiveSessionId;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @JsonKey(name: 'updated_at')
  final int? updatedAt;

  @override
  String toString() {
    if (kDebugMode) {
      return 'ClientResponse('
          'object: $object, '
          'id: $id, '
          'sessions: $sessions, '
          'signIn: $signIn, '
          'signUp: $signUp, '
          'lastActiveSessionId: $lastActiveSessionId, '
          'createdAt: $createdAt, '
          'updatedAt: $updatedAt)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$ClientResponseToJson(this);

  ClientResponse copyWith({
    String? object,
    String? id,
    List<SessionResponse>? sessions,
    dynamic signIn,
    dynamic signUp,
    String? lastActiveSessionId,
    int? createdAt,
    int? updatedAt,
  }) {
    return ClientResponse(
      object: object ?? this.object,
      id: id ?? this.id,
      sessions: sessions ?? this.sessions,
      signIn: signIn ?? this.signIn,
      signUp: signUp ?? this.signUp,
      lastActiveSessionId: lastActiveSessionId ?? this.lastActiveSessionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ClientResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      object.hashCode ^
      id.hashCode ^
      sessions.hashCode ^
      signIn.hashCode ^
      signUp.hashCode ^
      lastActiveSessionId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
