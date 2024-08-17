import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'session.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  final String? object;
  final String? id;
  final List<Session>? sessions;
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

  const Client({
    this.object,
    this.id,
    this.sessions,
    this.signIn,
    this.signUp,
    this.lastActiveSessionId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Client(object: $object, id: $id, sessions: $sessions, signIn: $signIn, signUp: $signUp, lastActiveSessionId: $lastActiveSessionId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return _$ClientFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ClientToJson(this);

  Client copyWith({
    String? object,
    String? id,
    List<Session>? sessions,
    dynamic signIn,
    dynamic signUp,
    String? lastActiveSessionId,
    int? createdAt,
    int? updatedAt,
  }) {
    return Client(
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
    if (other is! Client) return false;
    final mapEquals = const DeepCollectionEquality().equals;
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
