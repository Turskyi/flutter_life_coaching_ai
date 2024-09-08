// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_factor_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirstFactorVerificationResponse _$FirstFactorVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    FirstFactorVerificationResponse(
      status: json['status'] as String?,
      strategy: json['strategy'] as String?,
      attempts: (json['attempts'] as num?)?.toInt(),
      expireAt: json['expire_at'],
    );

Map<String, dynamic> _$FirstFactorVerificationResponseToJson(
        FirstFactorVerificationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'strategy': instance.strategy,
      'attempts': instance.attempts,
      'expire_at': instance.expireAt,
    };
