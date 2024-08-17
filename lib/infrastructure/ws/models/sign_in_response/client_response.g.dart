// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientResponse _$ClientResponseFromJson(Map<String, dynamic> json) =>
    ClientResponse(
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SessionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      object: json['object'] as String?,
      id: json['id'] as String?,
      signIn: json['sign_in'],
      signUp: json['sign_up'],
      lastActiveSessionId: json['last_active_session_id'] as String?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      updatedAt: (json['updated_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClientResponseToJson(ClientResponse instance) =>
    <String, dynamic>{
      'object': instance.object,
      'id': instance.id,
      'sessions': instance.sessions,
      'sign_in': instance.signIn,
      'sign_up': instance.signUp,
      'last_active_session_id': instance.lastActiveSessionId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
