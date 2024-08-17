import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'email_address_response.dart';
import 'unsafe_metadata_response.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  const UserResponse({
    this.id,
    this.object,
    this.username,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.hasImage,
    this.primaryEmailAddressId,
    this.primaryPhoneNumberId,
    this.primaryWeb3WalletId,
    this.passwordEnabled,
    this.twoFactorEnabled,
    this.totpEnabled,
    this.backupCodeEnabled,
    this.emailAddresses,
    this.phoneNumbers,
    this.web3Wallets,
    this.passkeys,
    this.externalAccounts,
    this.samlAccounts,
    this.externalId,
    this.lastSignInAt,
    this.banned,
    this.locked,
    this.lockoutExpiresInSeconds,
    this.verificationAttemptsRemaining,
    this.createdAt,
    this.updatedAt,
    this.deleteSelfEnabled,
    this.createOrganizationEnabled,
    this.lastActiveAt,
    this.mfaEnabledAt,
    this.mfaDisabledAt,
    this.profileImageUrl,
    this.organizationMemberships,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  final String? id;
  final String? object;
  final dynamic username;
  @JsonKey(name: 'first_name')
  final dynamic firstName;
  @JsonKey(name: 'last_name')
  final dynamic lastName;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'has_image')
  final bool? hasImage;
  @JsonKey(name: 'primary_email_address_id')
  final String? primaryEmailAddressId;
  @JsonKey(name: 'primary_phone_number_id')
  final dynamic primaryPhoneNumberId;
  @JsonKey(name: 'primary_web3_wallet_id')
  final dynamic primaryWeb3WalletId;
  @JsonKey(name: 'password_enabled')
  final bool? passwordEnabled;
  @JsonKey(name: 'two_factor_enabled')
  final bool? twoFactorEnabled;
  @JsonKey(name: 'totp_enabled')
  final bool? totpEnabled;
  @JsonKey(name: 'backup_code_enabled')
  final bool? backupCodeEnabled;
  @JsonKey(name: 'email_addresses')
  final List<EmailAddressResponse>? emailAddresses;
  @JsonKey(name: 'phone_numbers')
  final List<dynamic>? phoneNumbers;
  @JsonKey(name: 'web3_wallets')
  final List<dynamic>? web3Wallets;
  final List<dynamic>? passkeys;
  @JsonKey(name: 'external_accounts')
  final List<dynamic>? externalAccounts;
  @JsonKey(name: 'saml_accounts')
  final List<dynamic>? samlAccounts;
  @JsonKey(name: 'external_id')
  final dynamic externalId;
  @JsonKey(name: 'last_sign_in_at')
  final int? lastSignInAt;
  final bool? banned;
  final bool? locked;
  @JsonKey(name: 'lockout_expires_in_seconds')
  final dynamic lockoutExpiresInSeconds;
  @JsonKey(name: 'verification_attempts_remaining')
  final int? verificationAttemptsRemaining;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @JsonKey(name: 'updated_at')
  final int? updatedAt;
  @JsonKey(name: 'delete_self_enabled')
  final bool? deleteSelfEnabled;
  @JsonKey(name: 'create_organization_enabled')
  final bool? createOrganizationEnabled;
  @JsonKey(name: 'last_active_at')
  final int? lastActiveAt;
  @JsonKey(name: 'mfa_enabled_at')
  final dynamic mfaEnabledAt;
  @JsonKey(name: 'mfa_disabled_at')
  final dynamic mfaDisabledAt;
  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;
  @JsonKey(name: 'organization_memberships')
  final List<dynamic>? organizationMemberships;

  @override
  String toString() {
    if (kDebugMode) {
      return 'UserResponse('
          'id: $id, '
          'object: $object, '
          'username: $username, '
          'firstName: $firstName, '
          'lastName: $lastName, '
          'imageUrl: $imageUrl, '
          'hasImage: $hasImage, '
          'primaryEmailAddressId: $primaryEmailAddressId, '
          'primaryPhoneNumberId: $primaryPhoneNumberId, '
          'primaryWeb3WalletId: $primaryWeb3WalletId, '
          'passwordEnabled: $passwordEnabled, '
          'twoFactorEnabled: $twoFactorEnabled, '
          'totpEnabled: $totpEnabled, '
          'backupCodeEnabled: $backupCodeEnabled, '
          'emailAddresses: $emailAddresses, '
          'phoneNumbers: $phoneNumbers, '
          'web3Wallets: $web3Wallets, '
          'passkeys: $passkeys, '
          'externalAccounts: $externalAccounts, '
          'samlAccounts: $samlAccounts, '
          'externalId: $externalId, '
          'lastSignInAt: $lastSignInAt, '
          'banned: $banned, '
          'locked: $locked, '
          'lockoutExpiresInSeconds: $lockoutExpiresInSeconds, '
          'verificationAttemptsRemaining: $verificationAttemptsRemaining, '
          'createdAt: $createdAt, '
          'updatedAt: $updatedAt, '
          'deleteSelfEnabled: $deleteSelfEnabled, '
          'createOrganizationEnabled: $createOrganizationEnabled, '
          'lastActiveAt: $lastActiveAt, '
          'mfaEnabledAt: $mfaEnabledAt, '
          'mfaDisabledAt: $mfaDisabledAt, '
          'profileImageUrl: $profileImageUrl, '
          'organizationMemberships: $organizationMemberships)';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserResponse copyWith({
    String? id,
    String? object,
    dynamic username,
    dynamic firstName,
    dynamic lastName,
    String? imageUrl,
    bool? hasImage,
    String? primaryEmailAddressId,
    dynamic primaryPhoneNumberId,
    dynamic primaryWeb3WalletId,
    bool? passwordEnabled,
    bool? twoFactorEnabled,
    bool? totpEnabled,
    bool? backupCodeEnabled,
    List<EmailAddressResponse>? emailAddresses,
    List<dynamic>? phoneNumbers,
    List<dynamic>? web3Wallets,
    List<dynamic>? passkeys,
    List<dynamic>? externalAccounts,
    List<dynamic>? samlAccounts,
    UnsafeMetadataResponse? unsafeMetadata,
    dynamic externalId,
    int? lastSignInAt,
    bool? banned,
    bool? locked,
    dynamic lockoutExpiresInSeconds,
    int? verificationAttemptsRemaining,
    int? createdAt,
    int? updatedAt,
    bool? deleteSelfEnabled,
    bool? createOrganizationEnabled,
    int? lastActiveAt,
    dynamic mfaEnabledAt,
    dynamic mfaDisabledAt,
    String? profileImageUrl,
    List<dynamic>? organizationMemberships,
  }) {
    return UserResponse(
      id: id ?? this.id,
      object: object ?? this.object,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
      hasImage: hasImage ?? this.hasImage,
      primaryEmailAddressId:
          primaryEmailAddressId ?? this.primaryEmailAddressId,
      primaryPhoneNumberId: primaryPhoneNumberId ?? this.primaryPhoneNumberId,
      primaryWeb3WalletId: primaryWeb3WalletId ?? this.primaryWeb3WalletId,
      passwordEnabled: passwordEnabled ?? this.passwordEnabled,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      totpEnabled: totpEnabled ?? this.totpEnabled,
      backupCodeEnabled: backupCodeEnabled ?? this.backupCodeEnabled,
      emailAddresses: emailAddresses ?? this.emailAddresses,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      web3Wallets: web3Wallets ?? this.web3Wallets,
      passkeys: passkeys ?? this.passkeys,
      externalAccounts: externalAccounts ?? this.externalAccounts,
      samlAccounts: samlAccounts ?? this.samlAccounts,
      externalId: externalId ?? this.externalId,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      banned: banned ?? this.banned,
      locked: locked ?? this.locked,
      lockoutExpiresInSeconds:
          lockoutExpiresInSeconds ?? this.lockoutExpiresInSeconds,
      verificationAttemptsRemaining:
          verificationAttemptsRemaining ?? this.verificationAttemptsRemaining,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteSelfEnabled: deleteSelfEnabled ?? this.deleteSelfEnabled,
      createOrganizationEnabled:
          createOrganizationEnabled ?? this.createOrganizationEnabled,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      mfaEnabledAt: mfaEnabledAt ?? this.mfaEnabledAt,
      mfaDisabledAt: mfaDisabledAt ?? this.mfaDisabledAt,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      organizationMemberships:
          organizationMemberships ?? this.organizationMemberships,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      object.hashCode ^
      username.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      imageUrl.hashCode ^
      hasImage.hashCode ^
      primaryEmailAddressId.hashCode ^
      primaryPhoneNumberId.hashCode ^
      primaryWeb3WalletId.hashCode ^
      passwordEnabled.hashCode ^
      twoFactorEnabled.hashCode ^
      totpEnabled.hashCode ^
      backupCodeEnabled.hashCode ^
      emailAddresses.hashCode ^
      phoneNumbers.hashCode ^
      web3Wallets.hashCode ^
      passkeys.hashCode ^
      externalAccounts.hashCode ^
      samlAccounts.hashCode ^
      externalId.hashCode ^
      lastSignInAt.hashCode ^
      banned.hashCode ^
      locked.hashCode ^
      lockoutExpiresInSeconds.hashCode ^
      verificationAttemptsRemaining.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deleteSelfEnabled.hashCode ^
      createOrganizationEnabled.hashCode ^
      lastActiveAt.hashCode ^
      mfaEnabledAt.hashCode ^
      mfaDisabledAt.hashCode ^
      profileImageUrl.hashCode ^
      organizationMemberships.hashCode;
}
