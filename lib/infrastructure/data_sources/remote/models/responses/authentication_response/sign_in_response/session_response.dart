import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'last_active_token_response.dart';
import 'public_user_response.dart';
import 'sign_in_success_response/user_response.dart';

part 'session_response.g.dart';

@JsonSerializable()
class SessionResponse {
  const SessionResponse({
    required this.userResponse,
    this.object,
    this.id,
    this.status,
    this.expireAt,
    this.abandonAt,
    this.lastActiveAt,
    this.lastActiveOrganizationId,
    this.actor,
    this.publicUserData,
    this.createdAt,
    this.updatedAt,
    this.lastActiveToken,
  });

  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    return _$SessionResponseFromJson(json);
  }

  final String? object;
  final String? id;
  final String? status;
  @JsonKey(name: 'expire_at')
  final int? expireAt;
  @JsonKey(name: 'abandon_at')
  final int? abandonAt;
  @JsonKey(name: 'last_active_at')
  final int? lastActiveAt;
  @JsonKey(name: 'last_active_organization_id')
  final dynamic lastActiveOrganizationId;
  final dynamic actor;
  @JsonKey(name: 'user')
  final UserResponse userResponse;
  @JsonKey(name: 'public_user_data')
  final PublicUserResponse? publicUserData;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @JsonKey(name: 'updated_at')
  final int? updatedAt;
  @JsonKey(name: 'last_active_token')
  final LastActiveTokenResponse? lastActiveToken;

  @override
  String toString() {
    if (kDebugMode) {
      return 'SessionResponse('
          'object: $object, '
          'id: $id, '
          'status: $status, '
          'expireAt: $expireAt, '
          'abandonAt: $abandonAt, '
          'lastActiveAt: $lastActiveAt, '
          'lastActiveOrganizationId: $lastActiveOrganizationId, '
          'actor: $actor, '
          'user: $userResponse, '
          'publicUserData: $publicUserData, '
          'createdAt: $createdAt, '
          'updatedAt: $updatedAt, '
          'lastActiveToken: $lastActiveToken)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$SessionResponseToJson(this);

  SessionResponse copyWith({
    String? object,
    String? id,
    String? status,
    int? expireAt,
    int? abandonAt,
    int? lastActiveAt,
    dynamic lastActiveOrganizationId,
    dynamic actor,
    UserResponse? userResponse,
    PublicUserResponse? publicUserData,
    int? createdAt,
    int? updatedAt,
    LastActiveTokenResponse? lastActiveToken,
  }) {
    return SessionResponse(
      object: object ?? this.object,
      id: id ?? this.id,
      status: status ?? this.status,
      expireAt: expireAt ?? this.expireAt,
      abandonAt: abandonAt ?? this.abandonAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      lastActiveOrganizationId:
          lastActiveOrganizationId ?? this.lastActiveOrganizationId,
      actor: actor ?? this.actor,
      userResponse: userResponse ?? this.userResponse,
      publicUserData: publicUserData ?? this.publicUserData,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastActiveToken: lastActiveToken ?? this.lastActiveToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SessionResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      object.hashCode ^
      id.hashCode ^
      status.hashCode ^
      expireAt.hashCode ^
      abandonAt.hashCode ^
      lastActiveAt.hashCode ^
      lastActiveOrganizationId.hashCode ^
      actor.hashCode ^
      userResponse.hashCode ^
      publicUserData.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      lastActiveToken.hashCode;
}
