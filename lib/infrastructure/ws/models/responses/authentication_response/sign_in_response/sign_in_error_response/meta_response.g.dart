// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaResponse _$MetaResponseFromJson(Map<String, dynamic> json) => MetaResponse(
      clientResponse: json['client'] == null
          ? null
          : ClientResponse.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaResponseToJson(MetaResponse instance) =>
    <String, dynamic>{
      'client': instance.clientResponse,
    };
