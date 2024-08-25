// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationsResponse _$VerificationsResponseFromJson(
        Map<String, dynamic> json) =>
    VerificationsResponse(
      emailAddress: json['email_address'],
      phoneNumber: json['phone_number'],
      web3Wallet: json['web3_wallet'],
      externalAccount: json['external_account'],
    );

Map<String, dynamic> _$VerificationsResponseToJson(
        VerificationsResponse instance) =>
    <String, dynamic>{
      'email_address': instance.emailAddress,
      'phone_number': instance.phoneNumber,
      'web3_wallet': instance.web3Wallet,
      'external_account': instance.externalAccount,
    };
