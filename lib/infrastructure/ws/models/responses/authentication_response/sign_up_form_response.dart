import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/verifications_response.dart';

part 'sign_up_form_response.g.dart';

@JsonSerializable()
class SignUpFormResponse {
  const SignUpFormResponse({
    this.object,
    this.id,
    this.status,
    this.requiredFields,
    this.optionalFields,
    this.missingFields,
    this.unverifiedFields,
    this.verifications,
    this.username,
    this.emailAddress,
    this.phoneNumber,
    this.web3Wallet,
    this.passwordEnabled,
    this.firstName,
    this.lastName,
    this.customAction,
    this.externalId,
    this.createdSessionId,
    this.createdUserId,
    this.abandonAt,
  });

  factory SignUpFormResponse.fromJson(Map<String, dynamic> json) {
    return _$SignUpFormResponseFromJson(json);
  }

  final String? object;
  final String? id;
  final String? status;
  @JsonKey(name: 'required_fields')
  final List<String>? requiredFields;
  @JsonKey(name: 'optional_fields')
  final List<dynamic>? optionalFields;
  @JsonKey(name: 'missing_fields')
  final List<dynamic>? missingFields;
  @JsonKey(name: 'unverified_fields')
  final List<String>? unverifiedFields;
  @JsonKey(name: 'verifications')
  final VerificationsResponse? verifications;
  final dynamic username;
  @JsonKey(name: 'email_address')
  final String? emailAddress;
  @JsonKey(name: 'phone_number')
  final dynamic phoneNumber;
  @JsonKey(name: 'web3_wallet')
  final dynamic web3Wallet;
  @JsonKey(name: 'password_enabled')
  final bool? passwordEnabled;
  @JsonKey(name: 'first_name')
  final dynamic firstName;
  @JsonKey(name: 'last_name')
  final dynamic lastName;
  @JsonKey(name: 'custom_action')
  final bool? customAction;
  @JsonKey(name: 'external_id')
  final dynamic externalId;
  @JsonKey(name: 'created_session_id')
  final String? createdSessionId;
  @JsonKey(name: 'created_user_id')
  final String? createdUserId;
  @JsonKey(name: 'abandon_at')
  final int? abandonAt;

  @override
  String toString() {
    if (kDebugMode) {
      return 'SignUpFormResponse('
          'object: $object, '
          'id: $id, '
          'status: $status, '
          'requiredFields: $requiredFields, '
          'optionalFields: $optionalFields, '
          'missingFields: $missingFields, '
          'unverifiedFields: $unverifiedFields, '
          'verifications: $verifications, '
          'username: $username, '
          'emailAddress: $emailAddress, '
          'phoneNumber: $phoneNumber, '
          'web3Wallet: $web3Wallet, '
          'passwordEnabled: $passwordEnabled, '
          'firstName: $firstName, '
          'lastName: $lastName, '
          'customAction: $customAction, '
          'externalId: $externalId, '
          'createdSessionId: $createdSessionId, '
          'createdUserId: $createdUserId, '
          'abandonAt: $abandonAt)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$SignUpFormResponseToJson(this);

  SignUpFormResponse copyWith({
    String? object,
    String? id,
    String? status,
    List<String>? requiredFields,
    List<dynamic>? optionalFields,
    List<dynamic>? missingFields,
    List<String>? unverifiedFields,
    VerificationsResponse? verifications,
    dynamic username,
    String? emailAddress,
    dynamic phoneNumber,
    dynamic web3Wallet,
    bool? passwordEnabled,
    dynamic firstName,
    dynamic lastName,
    bool? customAction,
    dynamic externalId,
    dynamic createdSessionId,
    dynamic createdUserId,
    int? abandonAt,
  }) {
    return SignUpFormResponse(
      object: object ?? this.object,
      id: id ?? this.id,
      status: status ?? this.status,
      requiredFields: requiredFields ?? this.requiredFields,
      optionalFields: optionalFields ?? this.optionalFields,
      missingFields: missingFields ?? this.missingFields,
      unverifiedFields: unverifiedFields ?? this.unverifiedFields,
      verifications: verifications ?? this.verifications,
      username: username ?? this.username,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      web3Wallet: web3Wallet ?? this.web3Wallet,
      passwordEnabled: passwordEnabled ?? this.passwordEnabled,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      customAction: customAction ?? this.customAction,
      externalId: externalId ?? this.externalId,
      createdSessionId: createdSessionId ?? this.createdSessionId,
      createdUserId: createdUserId ?? this.createdUserId,
      abandonAt: abandonAt ?? this.abandonAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SignUpFormResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      object.hashCode ^
      id.hashCode ^
      status.hashCode ^
      requiredFields.hashCode ^
      optionalFields.hashCode ^
      missingFields.hashCode ^
      unverifiedFields.hashCode ^
      verifications.hashCode ^
      username.hashCode ^
      emailAddress.hashCode ^
      phoneNumber.hashCode ^
      web3Wallet.hashCode ^
      passwordEnabled.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      customAction.hashCode ^
      externalId.hashCode ^
      createdSessionId.hashCode ^
      createdUserId.hashCode ^
      abandonAt.hashCode;
}
