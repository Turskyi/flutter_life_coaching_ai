// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionResponse _$SessionResponseFromJson(Map<String, dynamic> json) =>
    SessionResponse(
      userResponse: UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      object: json['object'] as String?,
      id: json['id'] as String?,
      status: json['status'] as String?,
      expireAt: (json['expire_at'] as num?)?.toInt(),
      abandonAt: (json['abandon_at'] as num?)?.toInt(),
      lastActiveAt: (json['last_active_at'] as num?)?.toInt(),
      lastActiveOrganizationId: json['last_active_organization_id'],
      actor: json['actor'],
      publicUserData: json['public_user_data'] == null
          ? null
          : PublicUserResponse.fromJson(
              json['public_user_data'] as Map<String, dynamic>),
      createdAt: (json['created_at'] as num?)?.toInt(),
      updatedAt: (json['updated_at'] as num?)?.toInt(),
      lastActiveToken: json['last_active_token'] == null
          ? null
          : LastActiveTokenResponse.fromJson(
              json['last_active_token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionResponseToJson(SessionResponse instance) =>
    <String, dynamic>{
      'object': instance.object,
      'id': instance.id,
      'status': instance.status,
      'expire_at': instance.expireAt,
      'abandon_at': instance.abandonAt,
      'last_active_at': instance.lastActiveAt,
      'last_active_organization_id': instance.lastActiveOrganizationId,
      'actor': instance.actor,
      'user': instance.userResponse,
      'public_user_data': instance.publicUserData,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'last_active_token': instance.lastActiveToken,
    };
