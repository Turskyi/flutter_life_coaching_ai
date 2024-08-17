// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      object: json['object'] as String?,
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      imageUrl: json['image_url'] as String?,
      hasImage: json['has_image'] as bool?,
      primaryEmailAddressId: json['primary_email_address_id'] as String?,
      primaryPhoneNumberId: json['primary_phone_number_id'],
      primaryWeb3WalletId: json['primary_web3_wallet_id'],
      passwordEnabled: json['password_enabled'] as bool?,
      twoFactorEnabled: json['two_factor_enabled'] as bool?,
      totpEnabled: json['totp_enabled'] as bool?,
      backupCodeEnabled: json['backup_code_enabled'] as bool?,
      emailAddresses: (json['email_addresses'] as List<dynamic>?)
          ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      phoneNumbers: json['phone_numbers'] as List<dynamic>?,
      web3Wallets: json['web3_wallets'] as List<dynamic>?,
      passkeys: json['passkeys'] as List<dynamic>?,
      externalAccounts: json['external_accounts'] as List<dynamic>?,
      samlAccounts: json['saml_accounts'] as List<dynamic>?,
      publicMetadata: json['public_metadata'] == null
          ? null
          : PublicMetadata.fromJson(
              json['public_metadata'] as Map<String, dynamic>),
      unsafeMetadata: json['unsafe_metadata'] == null
          ? null
          : UnsafeMetadata.fromJson(
              json['unsafe_metadata'] as Map<String, dynamic>),
      externalId: json['external_id'],
      lastSignInAt: (json['last_sign_in_at'] as num?)?.toInt(),
      banned: json['banned'] as bool?,
      locked: json['locked'] as bool?,
      lockoutExpiresInSeconds: json['lockout_expires_in_seconds'],
      verificationAttemptsRemaining:
          (json['verification_attempts_remaining'] as num?)?.toInt(),
      createdAt: (json['created_at'] as num?)?.toInt(),
      updatedAt: (json['updated_at'] as num?)?.toInt(),
      deleteSelfEnabled: json['delete_self_enabled'] as bool?,
      createOrganizationEnabled: json['create_organization_enabled'] as bool?,
      lastActiveAt: (json['last_active_at'] as num?)?.toInt(),
      mfaEnabledAt: json['mfa_enabled_at'],
      mfaDisabledAt: json['mfa_disabled_at'],
      profileImageUrl: json['profile_image_url'] as String?,
      organizationMemberships:
          json['organization_memberships'] as List<dynamic>?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'image_url': instance.imageUrl,
      'has_image': instance.hasImage,
      'primary_email_address_id': instance.primaryEmailAddressId,
      'primary_phone_number_id': instance.primaryPhoneNumberId,
      'primary_web3_wallet_id': instance.primaryWeb3WalletId,
      'password_enabled': instance.passwordEnabled,
      'two_factor_enabled': instance.twoFactorEnabled,
      'totp_enabled': instance.totpEnabled,
      'backup_code_enabled': instance.backupCodeEnabled,
      'email_addresses': instance.emailAddresses,
      'phone_numbers': instance.phoneNumbers,
      'web3_wallets': instance.web3Wallets,
      'passkeys': instance.passkeys,
      'external_accounts': instance.externalAccounts,
      'saml_accounts': instance.samlAccounts,
      'public_metadata': instance.publicMetadata,
      'unsafe_metadata': instance.unsafeMetadata,
      'external_id': instance.externalId,
      'last_sign_in_at': instance.lastSignInAt,
      'banned': instance.banned,
      'locked': instance.locked,
      'lockout_expires_in_seconds': instance.lockoutExpiresInSeconds,
      'verification_attempts_remaining': instance.verificationAttemptsRemaining,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'delete_self_enabled': instance.deleteSelfEnabled,
      'create_organization_enabled': instance.createOrganizationEnabled,
      'last_active_at': instance.lastActiveAt,
      'mfa_enabled_at': instance.mfaEnabledAt,
      'mfa_disabled_at': instance.mfaDisabledAt,
      'profile_image_url': instance.profileImageUrl,
      'organization_memberships': instance.organizationMemberships,
    };
