// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationResponse _$VerificationResponseFromJson(
        Map<String, dynamic> json) =>
    VerificationResponse(
      status: json['status'] as String?,
      strategy: json['strategy'] as String?,
      attempts: (json['attempts'] as num?)?.toInt(),
      expireAt: (json['expire_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VerificationResponseToJson(
        VerificationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'strategy': instance.strategy,
      'attempts': instance.attempts,
      'expire_at': instance.expireAt,
    };
