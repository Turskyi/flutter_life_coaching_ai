// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInSuccessResponse _$SignInSuccessResponseFromJson(
        Map<String, dynamic> json) =>
    SignInSuccessResponse(
      clientResponse: json['client'] == null
          ? null
          : ClientResponse.fromJson(json['client'] as Map<String, dynamic>),
      authenticationResponse: json['response'] == null
          ? null
          : AuthenticationResponse.fromJson(
              json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInSuccessResponseToJson(
        SignInSuccessResponse instance) =>
    <String, dynamic>{
      'response': instance.authenticationResponse,
      'client': instance.clientResponse,
    };
