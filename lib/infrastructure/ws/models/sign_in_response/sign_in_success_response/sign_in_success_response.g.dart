// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      client: ClientResponse.fromJson(json['client'] as Map<String, dynamic>),
      authenticationResponse: json['response'] == null
          ? null
          : AuthenticationResponse.fromJson(
              json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'response': instance.authenticationResponse,
      'client': instance.client,
    };
