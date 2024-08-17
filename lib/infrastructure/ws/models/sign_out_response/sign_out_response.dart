import 'dart:convert';

/// auth_config : {"object":"auth_config",
/// "id":"aac_something","first_name":"off",
/// "last_name":"off","email_address":"on","phone_number":"off",
/// "username":"off","password":"required",
/// "identification_requirements":
/// [["email_address"],[]],"identification_strategies":["email_address"],
/// "first_factors":["password","reset_password_email_code","ticket"],
/// "second_factors":[],"email_address_verification_strategies":["email_code"],
/// "single_session_mode":true,"enhanced_email_deliverability":false,
/// "test_mode":false,"cookieless_dev":false,"url_based_session_syncing":false,
/// "demo":false}
/// display_config : {"object":"display_config",
/// "id":"display_config_something",
/// "instance_environment_type":"production",
/// "application_name":"life-coaching-ai",
/// "theme":{"buttons": {"font_color":"#ffffff",
/// "font_family":"\"Source Sans Pro\",
/// sans-serif","font_weight":"600"},"general":{"color":"#0F172A",
/// "padding":"1em","box_shadow":"0 2px 8px rgba(0, 0, 0, 0.2)",
/// "font_color":"#151515","font_family":"\"Source Sans Pro\", sans-serif",
/// "border_radius":"0.5em","background_color":"#ffffff",
/// "label_font_weight":"600"},"accounts":{"background_color":"#ffffff"}},
/// "preferred_sign_in_strategy":"password",
/// "logo_image_url":"https://img.clerk.com/something",
/// "favicon_image_url":"https://img.clerk.com/something",
/// "home_url":"https://lifecoach.turskyi.com",
/// "sign_in_url":"https://lifecoach.turskyi.com/sign-in",
/// "sign_up_url":"https://lifecoach.turskyi.com/sign-up",
/// "user_profile_url":"https://accounts.turskyi.com/user",
/// "after_sign_in_url":"https://lifecoach.turskyi.com/goals",
/// "after_sign_up_url":"https://lifecoach.turskyi.com/goals",
/// "after_sign_out_one_url":"https://accounts.turskyi.com/sign-in/choose",
/// "after_sign_out_all_url":"https://lifecoach.turskyi.com/",
/// "after_switch_session_url":"https://lifecoach.turskyi.com",
/// "organization_profile_url":"https://accounts.turskyi.com/organization",
/// "create_organization_url":"https://accounts.turskyi.com/create-organization",
/// "after_leave_organization_url":"https://lifecoach.turskyi.com",
/// "after_create_organization_url":"https://lifecoach.turskyi.com",
/// "logo_link_url":"https://lifecoach.turskyi.com",
/// "support_email":"support@turskyi.com","branded":true,
/// "experimental_force_oauth_first":false,"clerk_js_version":"5",
/// "show_devmode_warning":false,"google_one_tap_client_id":null,
/// "help_url":null,"privacy_policy_url":null,"terms_url":null,
/// "logo_url":"https://images.clerk.dev/uploaded/img_something",
/// "favicon_url":"https://images.clerk.dev/uploaded/img_something",
/// "logo_image":{"object":"image","id":"img_something",
/// "public_url":"https://images.clerk.dev/uploaded/img_something"},
/// "favicon_image":{"object":"image","id":"img_something",
/// "public_url":"https://images.clerk.dev/uploaded/img_something"},
/// "captcha_public_key":"0xsomething","captcha_widget_type":"invisible",
/// "captcha_public_key_invisible":"0xsomething","captcha_provider":"turnstile"}
/// user_settings : {"attributes":{"email_address":{"enabled":true,
/// "required":true,"used_for_first_factor":true,"first_factors":[],
/// "used_for_second_factor":false,"second_factors":[],
/// "verifications":["email_code"],"verify_at_sign_up":true},
/// "phone_number":{"enabled":false,"required":false,
/// "used_for_first_factor":false,"first_factors":[],
/// "used_for_second_factor":false,"second_factors":[],"verifications":[],
/// "verify_at_sign_up":false},"username":{"enabled":false,"required":false,
/// "used_for_first_factor":false,"first_factors":[],
/// "used_for_second_factor":false,"second_factors":[],"verifications":[],
/// "verify_at_sign_up":false},"web3_wallet":{"enabled":false,
/// "required":false,"used_for_first_factor":false,"first_factors":[],
/// "used_for_second_factor":false,"second_factors":[],"verifications":[],
/// "verify_at_sign_up":false},"first_name":{"enabled":false,"required":false,
/// "used_for_first_factor":false,"first_factors":[],
/// "used_for_second_factor":false,"second_factors":[],"verifications":[],
/// "verify_at_sign_up":false},"last_name":{"enabled":false,"required":false,
/// "used_for_first_factor":false,"first_factors":[],
/// "used_for_second_factor":false,"second_factors":[],
/// "verifications":[],"verify_at_sign_up":false},
/// "password":{"enabled":true,"required":true,"used_for_first_factor":false,
/// "first_factors":[],"used_for_second_factor":false,"second_factors":[],
/// "verifications":[],"verify_at_sign_up":false},
/// "authenticator_app":{"enabled":false,"required":false,
/// "used_for_first_factor":false,"first_factors":[],
/// "used_for_second_factor":false,"second_factors":[],"verifications":[],
/// "verify_at_sign_up":false},"ticket":{"enabled":true,"required":false,
/// "used_for_first_factor":false,"first_factors":[],
/// "used_for_second_factor":false,"second_factors":[],"verifications":[],
/// "verify_at_sign_up":false},"backup_code":{"enabled":false,"required":false,
/// "used_for_first_factor":false,"first_factors":[],
/// "used_for_second_factor":false,"second_factors":[],"verifications":[],
/// "verify_at_sign_up":false},"passkey":{"enabled":false,"required":false,
/// "used_for_first_factor":false,"first_factors":[],
/// "used_for_second_factor":false,"second_factors":[],"verifications":[],
/// "verify_at_sign_up":false}},"sign_in":{"second_factor":{"required":false}},
/// "sign_up":{"captcha_enabled":true,"captcha_widget_type":"invisible",
/// "custom_action_required":false,"progressive":true,
/// "invite_only_enabled":false},"restrictions":{"allowlist":{"enabled":false},
/// "blocklist":{"enabled":false},"block_email_subaddresses":{"enabled":false},
/// "block_disposable_email_domains":{"enabled":false},
/// "ignore_dots_for_gmail_addresses":{"enabled":false}},
/// "username_settings":{"min_length":4,"max_length":64},
/// "actions":{"delete_self":true,"create_organization":true,
/// "create_organizations_limit":null},
/// "attack_protection":{"user_lockout":{"enabled":true,"max_attempts":100,
/// "duration_in_minutes":60},"pii":{"enabled":true},
/// "email_link":{"require_same_client":true}},
/// "passkey_settings":{"allow_autofill":true,"show_sign_in_button":true},
/// "social":{"oauth_google":{"enabled":false,"required":false,
/// "authenticatable":false,"block_email_subaddresses":false,
/// "strategy":"oauth_google","not_selectable":false,"deprecated":false}},
/// "password_settings":{"disable_hibp":false,"min_length":0,"max_length":0,
/// "require_special_char":false,"require_numbers":false,
/// "require_uppercase":false,"require_lowercase":false,"show_zxcvbn":false,
/// "min_zxcvbn_strength":0,"enforce_hibp_on_sign_in":false,
/// "allowed_special_characters":"!\"#$%&'()*+,-./:;<=>?@[]^_`{|}~"},
/// "saml":{"enabled":false}}
/// organization_settings : {"enabled":false,"max_allowed_memberships":5,
/// "actions":{"admin_delete":true},"domains":{"enabled":false,
/// "enrollment_modes":[],"default_role":""},"creator_role":"org:admin"}
/// maintenance_mode : false

SignOutResponse signOutResponseFromJson(String str) =>
    SignOutResponse.fromJson(json.decode(str));

String signOutResponseToJson(SignOutResponse data) =>
    json.encode(data.toJson());

class SignOutResponse {
  SignOutResponse({
    DisplayConfig? displayConfig,
    UserSettings? userSettings,
    OrganizationSettings? organizationSettings,
    bool? maintenanceMode,
  }) {
    _displayConfig = displayConfig;
    _userSettings = userSettings;
    _organizationSettings = organizationSettings;
    _maintenanceMode = maintenanceMode;
  }

  SignOutResponse.fromJson(dynamic json) {
    _displayConfig = json['display_config'] != null
        ? DisplayConfig.fromJson(json['display_config'])
        : null;
    _userSettings = json['user_settings'] != null
        ? UserSettings.fromJson(json['user_settings'])
        : null;
    _organizationSettings = json['organization_settings'] != null
        ? OrganizationSettings.fromJson(json['organization_settings'])
        : null;
    _maintenanceMode = json['maintenance_mode'];
  }

  DisplayConfig? _displayConfig;
  UserSettings? _userSettings;
  OrganizationSettings? _organizationSettings;
  bool? _maintenanceMode;

  SignOutResponse copyWith({
    DisplayConfig? displayConfig,
    UserSettings? userSettings,
    OrganizationSettings? organizationSettings,
    bool? maintenanceMode,
  }) =>
      SignOutResponse(
        displayConfig: displayConfig ?? _displayConfig,
        userSettings: userSettings ?? _userSettings,
        organizationSettings: organizationSettings ?? _organizationSettings,
        maintenanceMode: maintenanceMode ?? _maintenanceMode,
      );

  DisplayConfig? get displayConfig => _displayConfig;

  UserSettings? get userSettings => _userSettings;

  OrganizationSettings? get organizationSettings => _organizationSettings;

  bool? get maintenanceMode => _maintenanceMode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (_displayConfig != null) {
      map['display_config'] = _displayConfig?.toJson();
    }
    if (_userSettings != null) {
      map['user_settings'] = _userSettings?.toJson();
    }
    if (_organizationSettings != null) {
      map['organization_settings'] = _organizationSettings?.toJson();
    }
    map['maintenance_mode'] = _maintenanceMode;
    return map;
  }
}

/// enabled : false
/// max_allowed_memberships : 5
/// actions : {"admin_delete":true}
/// domains : {"enabled":false,"enrollment_modes":[],"default_role":""}
/// creator_role : "org:admin"

OrganizationSettings organizationSettingsFromJson(String str) =>
    OrganizationSettings.fromJson(json.decode(str));

String organizationSettingsToJson(OrganizationSettings data) =>
    json.encode(data.toJson());

class OrganizationSettings {
  OrganizationSettings({
    bool? enabled,
    int? maxAllowedMemberships,
    Actions? actions,
    String? creatorRole,
  }) {
    _enabled = enabled;
    _maxAllowedMemberships = maxAllowedMemberships;
    _actions = actions;
    _creatorRole = creatorRole;
  }

  OrganizationSettings.fromJson(dynamic json) {
    _enabled = json['enabled'];
    _maxAllowedMemberships = json['max_allowed_memberships'];
    _actions =
        json['actions'] != null ? Actions.fromJson(json['actions']) : null;
    _creatorRole = json['creator_role'];
  }

  bool? _enabled;
  int? _maxAllowedMemberships;
  Actions? _actions;
  String? _creatorRole;

  OrganizationSettings copyWith({
    bool? enabled,
    int? maxAllowedMemberships,
    Actions? actions,
    String? creatorRole,
  }) =>
      OrganizationSettings(
        enabled: enabled ?? _enabled,
        maxAllowedMemberships: maxAllowedMemberships ?? _maxAllowedMemberships,
        actions: actions ?? _actions,
        creatorRole: creatorRole ?? _creatorRole,
      );

  bool? get enabled => _enabled;

  int? get maxAllowedMemberships => _maxAllowedMemberships;

  Actions? get actions => _actions;

  String? get creatorRole => _creatorRole;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['enabled'] = _enabled;
    map['max_allowed_memberships'] = _maxAllowedMemberships;
    if (_actions != null) {
      map['actions'] = _actions?.toJson();
    }
    map['creator_role'] = _creatorRole;
    return map;
  }
}

/// admin_delete : true

Actions actionsFromJson(String str) => Actions.fromJson(json.decode(str));

String actionsToJson(Actions data) => json.encode(data.toJson());

class Actions {
  Actions({
    bool? adminDelete,
  }) {
    _adminDelete = adminDelete;
  }

  Actions.fromJson(dynamic json) {
    _adminDelete = json['admin_delete'];
  }

  bool? _adminDelete;

  Actions copyWith({
    bool? adminDelete,
  }) =>
      Actions(
        adminDelete: adminDelete ?? _adminDelete,
      );

  bool? get adminDelete => _adminDelete;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['admin_delete'] = _adminDelete;
    return map;
  }
}

UserSettings userSettingsFromJson(String str) =>
    UserSettings.fromJson(json.decode(str));

String userSettingsToJson(UserSettings data) => json.encode(data.toJson());

class UserSettings {
  UserSettings({
    Attributes? attributes,
    SignIn? signIn,
    SignUp? signUp,
    Restrictions? restrictions,
    UsernameSettings? usernameSettings,
    Actions? actions,
    AttackProtection? attackProtection,
    PasskeySettings? passkeySettings,
    Social? social,
    PasswordSettings? passwordSettings,
    Saml? saml,
  }) {
    _attributes = attributes;
    _signIn = signIn;
    _signUp = signUp;
    _restrictions = restrictions;
    _usernameSettings = usernameSettings;
    _actions = actions;
    _attackProtection = attackProtection;
    _passkeySettings = passkeySettings;
    _social = social;
    _passwordSettings = passwordSettings;
    _saml = saml;
  }

  UserSettings.fromJson(dynamic json) {
    _attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
    _signIn = json['sign_in'] != null ? SignIn.fromJson(json['sign_in']) : null;
    _signUp = json['sign_up'] != null ? SignUp.fromJson(json['sign_up']) : null;
    _restrictions = json['restrictions'] != null
        ? Restrictions.fromJson(json['restrictions'])
        : null;
    _usernameSettings = json['username_settings'] != null
        ? UsernameSettings.fromJson(json['username_settings'])
        : null;
    _actions =
        json['actions'] != null ? Actions.fromJson(json['actions']) : null;
    _attackProtection = json['attack_protection'] != null
        ? AttackProtection.fromJson(json['attack_protection'])
        : null;
    _passkeySettings = json['passkey_settings'] != null
        ? PasskeySettings.fromJson(json['passkey_settings'])
        : null;
    _social = json['social'] != null ? Social.fromJson(json['social']) : null;
    _passwordSettings = json['password_settings'] != null
        ? PasswordSettings.fromJson(json['password_settings'])
        : null;
    _saml = json['saml'] != null ? Saml.fromJson(json['saml']) : null;
  }

  Attributes? _attributes;
  SignIn? _signIn;
  SignUp? _signUp;
  Restrictions? _restrictions;
  UsernameSettings? _usernameSettings;
  Actions? _actions;
  AttackProtection? _attackProtection;
  PasskeySettings? _passkeySettings;
  Social? _social;
  PasswordSettings? _passwordSettings;
  Saml? _saml;

  UserSettings copyWith({
    Attributes? attributes,
    SignIn? signIn,
    SignUp? signUp,
    Restrictions? restrictions,
    UsernameSettings? usernameSettings,
    Actions? actions,
    AttackProtection? attackProtection,
    PasskeySettings? passkeySettings,
    Social? social,
    PasswordSettings? passwordSettings,
    Saml? saml,
  }) =>
      UserSettings(
        attributes: attributes ?? _attributes,
        signIn: signIn ?? _signIn,
        signUp: signUp ?? _signUp,
        restrictions: restrictions ?? _restrictions,
        usernameSettings: usernameSettings ?? _usernameSettings,
        actions: actions ?? _actions,
        attackProtection: attackProtection ?? _attackProtection,
        passkeySettings: passkeySettings ?? _passkeySettings,
        social: social ?? _social,
        passwordSettings: passwordSettings ?? _passwordSettings,
        saml: saml ?? _saml,
      );

  Attributes? get attributes => _attributes;

  SignIn? get signIn => _signIn;

  SignUp? get signUp => _signUp;

  Restrictions? get restrictions => _restrictions;

  UsernameSettings? get usernameSettings => _usernameSettings;

  Actions? get actions => _actions;

  AttackProtection? get attackProtection => _attackProtection;

  PasskeySettings? get passkeySettings => _passkeySettings;

  Social? get social => _social;

  PasswordSettings? get passwordSettings => _passwordSettings;

  Saml? get saml => _saml;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (_attributes != null) {
      map['attributes'] = _attributes?.toJson();
    }
    if (_signIn != null) {
      map['sign_in'] = _signIn?.toJson();
    }
    if (_signUp != null) {
      map['sign_up'] = _signUp?.toJson();
    }
    if (_restrictions != null) {
      map['restrictions'] = _restrictions?.toJson();
    }
    if (_usernameSettings != null) {
      map['username_settings'] = _usernameSettings?.toJson();
    }
    if (_actions != null) {
      map['actions'] = _actions?.toJson();
    }
    if (_attackProtection != null) {
      map['attack_protection'] = _attackProtection?.toJson();
    }
    if (_passkeySettings != null) {
      map['passkey_settings'] = _passkeySettings?.toJson();
    }
    if (_social != null) {
      map['social'] = _social?.toJson();
    }
    if (_passwordSettings != null) {
      map['password_settings'] = _passwordSettings?.toJson();
    }
    if (_saml != null) {
      map['saml'] = _saml?.toJson();
    }
    return map;
  }
}

/// enabled : false

Saml samlFromJson(String str) => Saml.fromJson(json.decode(str));

String samlToJson(Saml data) => json.encode(data.toJson());

class Saml {
  Saml({
    bool? enabled,
  }) {
    _enabled = enabled;
  }

  Saml.fromJson(dynamic json) {
    _enabled = json['enabled'];
  }

  bool? _enabled;

  Saml copyWith({
    bool? enabled,
  }) =>
      Saml(
        enabled: enabled ?? _enabled,
      );

  bool? get enabled => _enabled;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['enabled'] = _enabled;
    return map;
  }
}

/// disable_hibp : false
/// min_length : 0
/// max_length : 0
/// require_special_char : false
/// require_numbers : false
/// require_uppercase : false
/// require_lowercase : false
/// show_zxcvbn : false
/// min_zxcvbn_strength : 0
/// enforce_hibp_on_sign_in : false
/// allowed_special_characters : "!\"#$%&'()*+,-./:;<=>?@[]^_`{|}~"

PasswordSettings passwordSettingsFromJson(String str) =>
    PasswordSettings.fromJson(json.decode(str));

String passwordSettingsToJson(PasswordSettings data) =>
    json.encode(data.toJson());

class PasswordSettings {
  PasswordSettings({
    bool? disableHibp,
    int? minLength,
    int? maxLength,
    bool? requireSpecialChar,
    bool? requireNumbers,
    bool? requireUppercase,
    bool? requireLowercase,
    bool? showZxcvbn,
    int? minZxcvbnStrength,
    bool? enforceHibpOnSignIn,
    String? allowedSpecialCharacters,
  }) {
    _disableHibp = disableHibp;
    _minLength = minLength;
    _maxLength = maxLength;
    _requireSpecialChar = requireSpecialChar;
    _requireNumbers = requireNumbers;
    _requireUppercase = requireUppercase;
    _requireLowercase = requireLowercase;
    _showZxcvbn = showZxcvbn;
    _minZxcvbnStrength = minZxcvbnStrength;
    _enforceHibpOnSignIn = enforceHibpOnSignIn;
    _allowedSpecialCharacters = allowedSpecialCharacters;
  }

  PasswordSettings.fromJson(dynamic json) {
    _disableHibp = json['disable_hibp'];
    _minLength = json['min_length'];
    _maxLength = json['max_length'];
    _requireSpecialChar = json['require_special_char'];
    _requireNumbers = json['require_numbers'];
    _requireUppercase = json['require_uppercase'];
    _requireLowercase = json['require_lowercase'];
    _showZxcvbn = json['show_zxcvbn'];
    _minZxcvbnStrength = json['min_zxcvbn_strength'];
    _enforceHibpOnSignIn = json['enforce_hibp_on_sign_in'];
    _allowedSpecialCharacters = json['allowed_special_characters'];
  }

  bool? _disableHibp;
  int? _minLength;
  int? _maxLength;
  bool? _requireSpecialChar;
  bool? _requireNumbers;
  bool? _requireUppercase;
  bool? _requireLowercase;
  bool? _showZxcvbn;
  int? _minZxcvbnStrength;
  bool? _enforceHibpOnSignIn;
  String? _allowedSpecialCharacters;

  PasswordSettings copyWith({
    bool? disableHibp,
    int? minLength,
    int? maxLength,
    bool? requireSpecialChar,
    bool? requireNumbers,
    bool? requireUppercase,
    bool? requireLowercase,
    bool? showZxcvbn,
    int? minZxcvbnStrength,
    bool? enforceHibpOnSignIn,
    String? allowedSpecialCharacters,
  }) =>
      PasswordSettings(
        disableHibp: disableHibp ?? _disableHibp,
        minLength: minLength ?? _minLength,
        maxLength: maxLength ?? _maxLength,
        requireSpecialChar: requireSpecialChar ?? _requireSpecialChar,
        requireNumbers: requireNumbers ?? _requireNumbers,
        requireUppercase: requireUppercase ?? _requireUppercase,
        requireLowercase: requireLowercase ?? _requireLowercase,
        showZxcvbn: showZxcvbn ?? _showZxcvbn,
        minZxcvbnStrength: minZxcvbnStrength ?? _minZxcvbnStrength,
        enforceHibpOnSignIn: enforceHibpOnSignIn ?? _enforceHibpOnSignIn,
        allowedSpecialCharacters:
            allowedSpecialCharacters ?? _allowedSpecialCharacters,
      );

  bool? get disableHibp => _disableHibp;

  int? get minLength => _minLength;

  int? get maxLength => _maxLength;

  bool? get requireSpecialChar => _requireSpecialChar;

  bool? get requireNumbers => _requireNumbers;

  bool? get requireUppercase => _requireUppercase;

  bool? get requireLowercase => _requireLowercase;

  bool? get showZxcvbn => _showZxcvbn;

  int? get minZxcvbnStrength => _minZxcvbnStrength;

  bool? get enforceHibpOnSignIn => _enforceHibpOnSignIn;

  String? get allowedSpecialCharacters => _allowedSpecialCharacters;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['disable_hibp'] = _disableHibp;
    map['min_length'] = _minLength;
    map['max_length'] = _maxLength;
    map['require_special_char'] = _requireSpecialChar;
    map['require_numbers'] = _requireNumbers;
    map['require_uppercase'] = _requireUppercase;
    map['require_lowercase'] = _requireLowercase;
    map['show_zxcvbn'] = _showZxcvbn;
    map['min_zxcvbn_strength'] = _minZxcvbnStrength;
    map['enforce_hibp_on_sign_in'] = _enforceHibpOnSignIn;
    map['allowed_special_characters'] = _allowedSpecialCharacters;
    return map;
  }
}

/// oauth_google : {"enabled":false,"required":false,"authenticatable":false,
/// "block_email_subaddresses":false,"strategy":"oauth_google",
/// "not_selectable":false,"deprecated":false}

Social socialFromJson(String str) => Social.fromJson(json.decode(str));

String socialToJson(Social data) => json.encode(data.toJson());

class Social {
  Social({
    OauthGoogle? oauthGoogle,
  }) {
    _oauthGoogle = oauthGoogle;
  }

  Social.fromJson(dynamic json) {
    _oauthGoogle = json['oauth_google'] != null
        ? OauthGoogle.fromJson(json['oauth_google'])
        : null;
  }

  OauthGoogle? _oauthGoogle;

  Social copyWith({
    OauthGoogle? oauthGoogle,
  }) =>
      Social(
        oauthGoogle: oauthGoogle ?? _oauthGoogle,
      );

  OauthGoogle? get oauthGoogle => _oauthGoogle;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (_oauthGoogle != null) {
      map['oauth_google'] = _oauthGoogle?.toJson();
    }
    return map;
  }
}

/// enabled : false
/// required : false
/// authenticatable : false
/// block_email_subaddresses : false
/// strategy : "oauth_google"
/// not_selectable : false
/// deprecated : false

OauthGoogle oauthGoogleFromJson(String str) =>
    OauthGoogle.fromJson(json.decode(str));

String oauthGoogleToJson(OauthGoogle data) => json.encode(data.toJson());

class OauthGoogle {
  OauthGoogle({
    bool? enabled,
    bool? required,
    bool? authenticatable,
    bool? blockEmailSubaddresses,
    String? strategy,
    bool? notSelectable,
    bool? deprecated,
  }) {
    _enabled = enabled;
    _required = required;
    _authenticatable = authenticatable;
    _blockEmailSubaddresses = blockEmailSubaddresses;
    _strategy = strategy;
    _notSelectable = notSelectable;
    _deprecated = deprecated;
  }

  OauthGoogle.fromJson(dynamic json) {
    _enabled = json['enabled'];
    _required = json['required'];
    _authenticatable = json['authenticatable'];
    _blockEmailSubaddresses = json['block_email_subaddresses'];
    _strategy = json['strategy'];
    _notSelectable = json['not_selectable'];
    _deprecated = json['deprecated'];
  }

  bool? _enabled;
  bool? _required;
  bool? _authenticatable;
  bool? _blockEmailSubaddresses;
  String? _strategy;
  bool? _notSelectable;
  bool? _deprecated;

  OauthGoogle copyWith({
    bool? enabled,
    bool? required,
    bool? authenticatable,
    bool? blockEmailSubaddresses,
    String? strategy,
    bool? notSelectable,
    bool? deprecated,
  }) =>
      OauthGoogle(
        enabled: enabled ?? _enabled,
        required: required ?? _required,
        authenticatable: authenticatable ?? _authenticatable,
        blockEmailSubaddresses:
            blockEmailSubaddresses ?? _blockEmailSubaddresses,
        strategy: strategy ?? _strategy,
        notSelectable: notSelectable ?? _notSelectable,
        deprecated: deprecated ?? _deprecated,
      );

  bool? get enabled => _enabled;

  bool? get required => _required;

  bool? get authenticatable => _authenticatable;

  bool? get blockEmailSubaddresses => _blockEmailSubaddresses;

  String? get strategy => _strategy;

  bool? get notSelectable => _notSelectable;

  bool? get deprecated => _deprecated;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['enabled'] = _enabled;
    map['required'] = _required;
    map['authenticatable'] = _authenticatable;
    map['block_email_subaddresses'] = _blockEmailSubaddresses;
    map['strategy'] = _strategy;
    map['not_selectable'] = _notSelectable;
    map['deprecated'] = _deprecated;
    return map;
  }
}

/// allow_autofill : true
/// show_sign_in_button : true

PasskeySettings passkeySettingsFromJson(String str) =>
    PasskeySettings.fromJson(json.decode(str));

String passkeySettingsToJson(PasskeySettings data) =>
    json.encode(data.toJson());

class PasskeySettings {
  PasskeySettings({
    bool? allowAutofill,
    bool? showSignInButton,
  }) {
    _allowAutofill = allowAutofill;
    _showSignInButton = showSignInButton;
  }

  PasskeySettings.fromJson(dynamic json) {
    _allowAutofill = json['allow_autofill'];
    _showSignInButton = json['show_sign_in_button'];
  }

  bool? _allowAutofill;
  bool? _showSignInButton;

  PasskeySettings copyWith({
    bool? allowAutofill,
    bool? showSignInButton,
  }) =>
      PasskeySettings(
        allowAutofill: allowAutofill ?? _allowAutofill,
        showSignInButton: showSignInButton ?? _showSignInButton,
      );

  bool? get allowAutofill => _allowAutofill;

  bool? get showSignInButton => _showSignInButton;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['allow_autofill'] = _allowAutofill;
    map['show_sign_in_button'] = _showSignInButton;
    return map;
  }
}

/// user_lockout : {"enabled":true,"max_attempts":100,"duration_in_minutes":60}
/// pii : {"enabled":true}
/// email_link : {"require_same_client":true}

AttackProtection attackProtectionFromJson(String str) =>
    AttackProtection.fromJson(json.decode(str));

String attackProtectionToJson(AttackProtection data) =>
    json.encode(data.toJson());

class AttackProtection {
  AttackProtection({
    UserLockout? userLockout,
    Pii? pii,
    EmailLink? emailLink,
  }) {
    _userLockout = userLockout;
    _pii = pii;
    _emailLink = emailLink;
  }

  AttackProtection.fromJson(dynamic json) {
    _userLockout = json['user_lockout'] != null
        ? UserLockout.fromJson(json['user_lockout'])
        : null;
    _pii = json['pii'] != null ? Pii.fromJson(json['pii']) : null;
    _emailLink = json['email_link'] != null
        ? EmailLink.fromJson(json['email_link'])
        : null;
  }

  UserLockout? _userLockout;
  Pii? _pii;
  EmailLink? _emailLink;

  AttackProtection copyWith({
    UserLockout? userLockout,
    Pii? pii,
    EmailLink? emailLink,
  }) =>
      AttackProtection(
        userLockout: userLockout ?? _userLockout,
        pii: pii ?? _pii,
        emailLink: emailLink ?? _emailLink,
      );

  UserLockout? get userLockout => _userLockout;

  Pii? get pii => _pii;

  EmailLink? get emailLink => _emailLink;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (_userLockout != null) {
      map['user_lockout'] = _userLockout?.toJson();
    }
    if (_pii != null) {
      map['pii'] = _pii?.toJson();
    }
    if (_emailLink != null) {
      map['email_link'] = _emailLink?.toJson();
    }
    return map;
  }
}

/// require_same_client : true

EmailLink emailLinkFromJson(String str) => EmailLink.fromJson(json.decode(str));

String emailLinkToJson(EmailLink data) => json.encode(data.toJson());

class EmailLink {
  EmailLink({
    bool? requireSameClient,
  }) {
    _requireSameClient = requireSameClient;
  }

  EmailLink.fromJson(dynamic json) {
    _requireSameClient = json['require_same_client'];
  }

  bool? _requireSameClient;

  EmailLink copyWith({
    bool? requireSameClient,
  }) =>
      EmailLink(
        requireSameClient: requireSameClient ?? _requireSameClient,
      );

  bool? get requireSameClient => _requireSameClient;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['require_same_client'] = _requireSameClient;
    return map;
  }
}

/// enabled : true

Pii piiFromJson(String str) => Pii.fromJson(json.decode(str));

String piiToJson(Pii data) => json.encode(data.toJson());

class Pii {
  Pii({
    bool? enabled,
  }) {
    _enabled = enabled;
  }

  Pii.fromJson(dynamic json) {
    _enabled = json['enabled'];
  }

  bool? _enabled;

  Pii copyWith({
    bool? enabled,
  }) =>
      Pii(
        enabled: enabled ?? _enabled,
      );

  bool? get enabled => _enabled;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['enabled'] = _enabled;
    return map;
  }
}

/// enabled : true
/// max_attempts : 100
/// duration_in_minutes : 60

UserLockout userLockoutFromJson(String str) =>
    UserLockout.fromJson(json.decode(str));

String userLockoutToJson(UserLockout data) => json.encode(data.toJson());

class UserLockout {
  UserLockout({
    bool? enabled,
    int? maxAttempts,
    int? durationInMinutes,
  }) {
    _enabled = enabled;
    _maxAttempts = maxAttempts;
    _durationInMinutes = durationInMinutes;
  }

  UserLockout.fromJson(dynamic json) {
    _enabled = json['enabled'];
    _maxAttempts = json['max_attempts'];
    _durationInMinutes = json['duration_in_minutes'];
  }

  bool? _enabled;
  int? _maxAttempts;
  int? _durationInMinutes;

  UserLockout copyWith({
    bool? enabled,
    int? maxAttempts,
    int? durationInMinutes,
  }) =>
      UserLockout(
        enabled: enabled ?? _enabled,
        maxAttempts: maxAttempts ?? _maxAttempts,
        durationInMinutes: durationInMinutes ?? _durationInMinutes,
      );

  bool? get enabled => _enabled;

  int? get maxAttempts => _maxAttempts;

  int? get durationInMinutes => _durationInMinutes;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['enabled'] = _enabled;
    map['max_attempts'] = _maxAttempts;
    map['duration_in_minutes'] = _durationInMinutes;
    return map;
  }
}

/// min_length : 4
/// max_length : 64

UsernameSettings usernameSettingsFromJson(String str) =>
    UsernameSettings.fromJson(json.decode(str));

String usernameSettingsToJson(UsernameSettings data) =>
    json.encode(data.toJson());

class UsernameSettings {
  UsernameSettings({
    int? minLength,
    int? maxLength,
  }) {
    _minLength = minLength;
    _maxLength = maxLength;
  }

  UsernameSettings.fromJson(dynamic json) {
    _minLength = json['min_length'];
    _maxLength = json['max_length'];
  }

  int? _minLength;
  int? _maxLength;

  UsernameSettings copyWith({
    int? minLength,
    int? maxLength,
  }) =>
      UsernameSettings(
        minLength: minLength ?? _minLength,
        maxLength: maxLength ?? _maxLength,
      );

  int? get minLength => _minLength;

  int? get maxLength => _maxLength;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['min_length'] = _minLength;
    map['max_length'] = _maxLength;
    return map;
  }
}

/// allowlist : {"enabled":false}
/// blocklist : {"enabled":false}
/// block_email_subaddresses : {"enabled":false}
/// block_disposable_email_domains : {"enabled":false}
/// ignore_dots_for_gmail_addresses : {"enabled":false}

Restrictions restrictionsFromJson(String str) =>
    Restrictions.fromJson(json.decode(str));

String restrictionsToJson(Restrictions data) => json.encode(data.toJson());

class Restrictions {
  Restrictions({
    Allowlist? allowlist,
    Blocklist? blocklist,
    BlockEmailSubaddresses? blockEmailSubaddresses,
    BlockDisposableEmailDomains? blockDisposableEmailDomains,
    IgnoreDotsForGmailAddresses? ignoreDotsForGmailAddresses,
  }) {
    _allowlist = allowlist;
    _blocklist = blocklist;
    _blockEmailSubaddresses = blockEmailSubaddresses;
    _blockDisposableEmailDomains = blockDisposableEmailDomains;
    _ignoreDotsForGmailAddresses = ignoreDotsForGmailAddresses;
  }

  Restrictions.fromJson(dynamic json) {
    _allowlist = json['allowlist'];
    _blocklist = json['blocklist'];
    _blockEmailSubaddresses = json['block_email_subaddresses'] != null
        ? BlockEmailSubaddresses.fromJson(json['block_email_subaddresses'])
        : null;
    _blockDisposableEmailDomains =
        json['block_disposable_email_domains'] != null
            ? BlockDisposableEmailDomains.fromJson(
                json['block_disposable_email_domains'],
              )
            : null;
    _ignoreDotsForGmailAddresses =
        json['ignore_dots_for_gmail_addresses'] != null
            ? IgnoreDotsForGmailAddresses.fromJson(
                json['ignore_dots_for_gmail_addresses'],
              )
            : null;
  }

  Allowlist? _allowlist;
  Blocklist? _blocklist;
  BlockEmailSubaddresses? _blockEmailSubaddresses;
  BlockDisposableEmailDomains? _blockDisposableEmailDomains;
  IgnoreDotsForGmailAddresses? _ignoreDotsForGmailAddresses;

  Restrictions copyWith({
    Allowlist? allowlist,
    Blocklist? blocklist,
    BlockEmailSubaddresses? blockEmailSubaddresses,
    BlockDisposableEmailDomains? blockDisposableEmailDomains,
    IgnoreDotsForGmailAddresses? ignoreDotsForGmailAddresses,
  }) =>
      Restrictions(
        allowlist: allowlist ?? _allowlist,
        blocklist: blocklist ?? _blocklist,
        blockEmailSubaddresses:
            blockEmailSubaddresses ?? _blockEmailSubaddresses,
        blockDisposableEmailDomains:
            blockDisposableEmailDomains ?? _blockDisposableEmailDomains,
        ignoreDotsForGmailAddresses:
            ignoreDotsForGmailAddresses ?? _ignoreDotsForGmailAddresses,
      );

  Allowlist? get allowlist => _allowlist;

  Blocklist? get blocklist => _blocklist;

  BlockEmailSubaddresses? get blockEmailSubaddresses => _blockEmailSubaddresses;

  BlockDisposableEmailDomains? get blockDisposableEmailDomains =>
      _blockDisposableEmailDomains;

  IgnoreDotsForGmailAddresses? get ignoreDotsForGmailAddresses =>
      _ignoreDotsForGmailAddresses;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['allowlist'] = _allowlist;
    map['blocklist'] = _blocklist;
    if (_blockEmailSubaddresses != null) {
      map['block_email_subaddresses'] = _blockEmailSubaddresses?.toJson();
    }
    if (_blockDisposableEmailDomains != null) {
      map['block_disposable_email_domains'] =
          _blockDisposableEmailDomains?.toJson();
    }
    if (_ignoreDotsForGmailAddresses != null) {
      map['ignore_dots_for_gmail_addresses'] =
          _ignoreDotsForGmailAddresses?.toJson();
    }
    return map;
  }
}

/// enabled : false

IgnoreDotsForGmailAddresses ignoreDotsForGmailAddressesFromJson(String str) =>
    IgnoreDotsForGmailAddresses.fromJson(json.decode(str));

String ignoreDotsForGmailAddressesToJson(IgnoreDotsForGmailAddresses data) =>
    json.encode(data.toJson());

class IgnoreDotsForGmailAddresses {
  IgnoreDotsForGmailAddresses({
    bool? enabled,
  }) {
    _enabled = enabled;
  }

  IgnoreDotsForGmailAddresses.fromJson(dynamic json) {
    _enabled = json['enabled'];
  }

  bool? _enabled;

  IgnoreDotsForGmailAddresses copyWith({
    bool? enabled,
  }) =>
      IgnoreDotsForGmailAddresses(
        enabled: enabled ?? _enabled,
      );

  bool? get enabled => _enabled;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['enabled'] = _enabled;
    return map;
  }
}

/// enabled : false

BlockDisposableEmailDomains blockDisposableEmailDomainsFromJson(String str) =>
    BlockDisposableEmailDomains.fromJson(json.decode(str));

String blockDisposableEmailDomainsToJson(BlockDisposableEmailDomains data) =>
    json.encode(data.toJson());

class BlockDisposableEmailDomains {
  BlockDisposableEmailDomains({
    bool? enabled,
  }) {
    _enabled = enabled;
  }

  BlockDisposableEmailDomains.fromJson(dynamic json) {
    _enabled = json['enabled'];
  }

  bool? _enabled;

  BlockDisposableEmailDomains copyWith({
    bool? enabled,
  }) =>
      BlockDisposableEmailDomains(
        enabled: enabled ?? _enabled,
      );

  bool? get enabled => _enabled;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['enabled'] = _enabled;
    return map;
  }
}

/// enabled : false

BlockEmailSubaddresses blockEmailSubaddressesFromJson(String str) =>
    BlockEmailSubaddresses.fromJson(json.decode(str));

String blockEmailSubaddressesToJson(BlockEmailSubaddresses data) =>
    json.encode(data.toJson());

class BlockEmailSubaddresses {
  BlockEmailSubaddresses({
    bool? enabled,
  }) {
    _enabled = enabled;
  }

  BlockEmailSubaddresses.fromJson(dynamic json) {
    _enabled = json['enabled'];
  }

  bool? _enabled;

  BlockEmailSubaddresses copyWith({
    bool? enabled,
  }) =>
      BlockEmailSubaddresses(
        enabled: enabled ?? _enabled,
      );

  bool? get enabled => _enabled;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['enabled'] = _enabled;
    return map;
  }
}

/// enabled : false

Blocklist blocklistFromJson(String str) => Blocklist.fromJson(json.decode(str));

String blocklistToJson(Blocklist data) => json.encode(data.toJson());

class Blocklist {
  Blocklist({
    bool? enabled,
  }) {
    _enabled = enabled;
  }

  Blocklist.fromJson(dynamic json) {
    _enabled = json['enabled'];
  }

  bool? _enabled;

  Blocklist copyWith({
    bool? enabled,
  }) =>
      Blocklist(
        enabled: enabled ?? _enabled,
      );

  bool? get enabled => _enabled;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['enabled'] = _enabled;
    return map;
  }
}

/// enabled : false

Allowlist allowlistFromJson(String str) => Allowlist.fromJson(json.decode(str));

String allowlistToJson(Allowlist data) => json.encode(data.toJson());

class Allowlist {
  Allowlist({
    bool? enabled,
  }) {
    _enabled = enabled;
  }

  Allowlist.fromJson(dynamic json) {
    _enabled = json['enabled'];
  }

  bool? _enabled;

  Allowlist copyWith({
    bool? enabled,
  }) =>
      Allowlist(
        enabled: enabled ?? _enabled,
      );

  bool? get enabled => _enabled;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['enabled'] = _enabled;
    return map;
  }
}

/// captcha_enabled : true
/// captcha_widget_type : "invisible"
/// custom_action_required : false
/// progressive : true
/// invite_only_enabled : false

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));

String signUpToJson(SignUp data) => json.encode(data.toJson());

class SignUp {
  SignUp({
    bool? captchaEnabled,
    String? captchaWidgetType,
    bool? customActionRequired,
    bool? progressive,
    bool? inviteOnlyEnabled,
  }) {
    _captchaEnabled = captchaEnabled;
    _captchaWidgetType = captchaWidgetType;
    _customActionRequired = customActionRequired;
    _progressive = progressive;
    _inviteOnlyEnabled = inviteOnlyEnabled;
  }

  SignUp.fromJson(dynamic json) {
    _captchaEnabled = json['captcha_enabled'];
    _captchaWidgetType = json['captcha_widget_type'];
    _customActionRequired = json['custom_action_required'];
    _progressive = json['progressive'];
    _inviteOnlyEnabled = json['invite_only_enabled'];
  }

  bool? _captchaEnabled;
  String? _captchaWidgetType;
  bool? _customActionRequired;
  bool? _progressive;
  bool? _inviteOnlyEnabled;

  SignUp copyWith({
    bool? captchaEnabled,
    String? captchaWidgetType,
    bool? customActionRequired,
    bool? progressive,
    bool? inviteOnlyEnabled,
  }) =>
      SignUp(
        captchaEnabled: captchaEnabled ?? _captchaEnabled,
        captchaWidgetType: captchaWidgetType ?? _captchaWidgetType,
        customActionRequired: customActionRequired ?? _customActionRequired,
        progressive: progressive ?? _progressive,
        inviteOnlyEnabled: inviteOnlyEnabled ?? _inviteOnlyEnabled,
      );

  bool? get captchaEnabled => _captchaEnabled;

  String? get captchaWidgetType => _captchaWidgetType;

  bool? get customActionRequired => _customActionRequired;

  bool? get progressive => _progressive;

  bool? get inviteOnlyEnabled => _inviteOnlyEnabled;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['captcha_enabled'] = _captchaEnabled;
    map['captcha_widget_type'] = _captchaWidgetType;
    map['custom_action_required'] = _customActionRequired;
    map['progressive'] = _progressive;
    map['invite_only_enabled'] = _inviteOnlyEnabled;
    return map;
  }
}

/// second_factor : {"required":false}

SignIn signInFromJson(String str) => SignIn.fromJson(json.decode(str));

String signInToJson(SignIn data) => json.encode(data.toJson());

class SignIn {
  SignIn({
    SecondFactor? secondFactor,
  }) {
    _secondFactor = secondFactor;
  }

  SignIn.fromJson(dynamic json) {
    _secondFactor = json['second_factor'] != null
        ? SecondFactor.fromJson(json['second_factor'])
        : null;
  }

  SecondFactor? _secondFactor;

  SignIn copyWith({
    SecondFactor? secondFactor,
  }) =>
      SignIn(
        secondFactor: secondFactor ?? _secondFactor,
      );

  SecondFactor? get secondFactor => _secondFactor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (_secondFactor != null) {
      map['second_factor'] = _secondFactor?.toJson();
    }
    return map;
  }
}

/// required : false

SecondFactor secondFactorFromJson(String str) =>
    SecondFactor.fromJson(json.decode(str));

String secondFactorToJson(SecondFactor data) => json.encode(data.toJson());

class SecondFactor {
  SecondFactor({
    bool? required,
  }) {
    _required = required;
  }

  SecondFactor.fromJson(dynamic json) {
    _required = json['required'];
  }

  bool? _required;

  SecondFactor copyWith({
    bool? required,
  }) =>
      SecondFactor(
        required: required ?? _required,
      );

  bool? get required => _required;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['required'] = _required;
    return map;
  }
}

Attributes attributesFromJson(String str) =>
    Attributes.fromJson(json.decode(str));

String attributesToJson(Attributes data) => json.encode(data.toJson());

class Attributes {
  const Attributes();

  Attributes.fromJson(dynamic json);

  Attributes copyWith() => const Attributes();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    return map;
  }
}

/// object : "display_config"
/// id : "display_config_something"
/// instance_environment_type : "production"
/// application_name : "life-coaching-ai"
/// theme : {"buttons":{"font_color":"#ffffff",
/// "font_family":"\"Source Sans Pro\", sans-serif","font_weight":"600"},
/// "general":{"color":"#0F172A","padding":"1em",
/// "box_shadow":"0 2px 8px rgba(0, 0, 0, 0.2)",
/// "font_color":"#151515","font_family":"\"Source Sans Pro\",
/// sans-serif","border_radius":"0.5em","background_color":"#ffffff",
/// "label_font_weight":"600"},"accounts":{"background_color":"#ffffff"}}
/// preferred_sign_in_strategy : "password"
/// logo_image_url : "https://img.clerk.com/something"
/// favicon_image_url : "https://img.clerk.com/something"
/// home_url : "https://lifecoach.turskyi.com"
/// sign_in_url : "https://lifecoach.turskyi.com/sign-in"
/// sign_up_url : "https://lifecoach.turskyi.com/sign-up"
/// user_profile_url : "https://accounts.turskyi.com/user"
/// after_sign_in_url : "https://lifecoach.turskyi.com/goals"
/// after_sign_up_url : "https://lifecoach.turskyi.com/goals"
/// after_sign_out_one_url : "https://accounts.turskyi.com/sign-in/choose"
/// after_sign_out_all_url : "https://lifecoach.turskyi.com/"
/// after_switch_session_url : "https://lifecoach.turskyi.com"
/// organization_profile_url : "https://accounts.turskyi.com/organization"
/// create_organization_url : "https://accounts.turskyi.com/create-organization"
/// after_leave_organization_url : "https://lifecoach.turskyi.com"
/// after_create_organization_url : "https://lifecoach.turskyi.com"
/// logo_link_url : "https://lifecoach.turskyi.com"
/// support_email : "support@turskyi.com"
/// branded : true
/// experimental_force_oauth_first : false
/// clerk_js_version : "5"
/// show_devmode_warning : false
/// google_one_tap_client_id : null
/// help_url : null
/// privacy_policy_url : null
/// terms_url : null
/// logo_url : "https://images.clerk.dev/uploaded/img_something"
/// favicon_url : "https://images.clerk.dev/uploaded/img_something"
/// logo_image : {"object":"image","id":"img_something",
/// "public_url":"https://images.clerk.dev/uploaded/img_something"}
/// favicon_image : {"object":"image","id":"img_something",
/// "public_url":"https://images.clerk.dev/uploaded/img_something"}
/// captcha_public_key : "0xsomething"
/// captcha_widget_type : "invisible"
/// captcha_public_key_invisible : "0xsomething"
/// captcha_provider : "turnstile"

DisplayConfig displayConfigFromJson(String str) =>
    DisplayConfig.fromJson(json.decode(str));

String displayConfigToJson(DisplayConfig data) => json.encode(data.toJson());

class DisplayConfig {
  DisplayConfig({
    String? object,
    String? id,
    String? instanceEnvironmentType,
    String? applicationName,
    Theme? theme,
    String? preferredSignInStrategy,
    String? logoImageUrl,
    String? faviconImageUrl,
    String? homeUrl,
    String? signInUrl,
    String? signUpUrl,
    String? userProfileUrl,
    String? afterSignInUrl,
    String? afterSignUpUrl,
    String? afterSignOutOneUrl,
    String? afterSignOutAllUrl,
    String? afterSwitchSessionUrl,
    String? organizationProfileUrl,
    String? createOrganizationUrl,
    String? afterLeaveOrganizationUrl,
    String? afterCreateOrganizationUrl,
    String? logoLinkUrl,
    String? supportEmail,
    bool? branded,
    bool? experimentalForceOauthFirst,
    String? clerkJsVersion,
    bool? showDevmodeWarning,
    dynamic googleOneTapClientId,
    dynamic helpUrl,
    dynamic privacyPolicyUrl,
    dynamic termsUrl,
    String? logoUrl,
    String? faviconUrl,
    LogoImage? logoImage,
    FaviconImage? faviconImage,
    String? captchaPublicKey,
    String? captchaWidgetType,
    String? captchaPublicKeyInvisible,
    String? captchaProvider,
  }) {
    _object = object;
    _id = id;
    _instanceEnvironmentType = instanceEnvironmentType;
    _applicationName = applicationName;
    _theme = theme;
    _preferredSignInStrategy = preferredSignInStrategy;
    _logoImageUrl = logoImageUrl;
    _faviconImageUrl = faviconImageUrl;
    _homeUrl = homeUrl;
    _signInUrl = signInUrl;
    _signUpUrl = signUpUrl;
    _userProfileUrl = userProfileUrl;
    _afterSignInUrl = afterSignInUrl;
    _afterSignUpUrl = afterSignUpUrl;
    _afterSignOutOneUrl = afterSignOutOneUrl;
    _afterSignOutAllUrl = afterSignOutAllUrl;
    _afterSwitchSessionUrl = afterSwitchSessionUrl;
    _organizationProfileUrl = organizationProfileUrl;
    _createOrganizationUrl = createOrganizationUrl;
    _afterLeaveOrganizationUrl = afterLeaveOrganizationUrl;
    _afterCreateOrganizationUrl = afterCreateOrganizationUrl;
    _logoLinkUrl = logoLinkUrl;
    _supportEmail = supportEmail;
    _branded = branded;
    _experimentalForceOauthFirst = experimentalForceOauthFirst;
    _clerkJsVersion = clerkJsVersion;
    _showDevmodeWarning = showDevmodeWarning;
    _googleOneTapClientId = googleOneTapClientId;
    _helpUrl = helpUrl;
    _privacyPolicyUrl = privacyPolicyUrl;
    _termsUrl = termsUrl;
    _logoUrl = logoUrl;
    _faviconUrl = faviconUrl;
    _logoImage = logoImage;
    _faviconImage = faviconImage;
    _captchaPublicKey = captchaPublicKey;
    _captchaWidgetType = captchaWidgetType;
    _captchaPublicKeyInvisible = captchaPublicKeyInvisible;
    _captchaProvider = captchaProvider;
  }

  DisplayConfig.fromJson(dynamic json) {
    _object = json['object'];
    _id = json['id'];
    _instanceEnvironmentType = json['instance_environment_type'];
    _applicationName = json['application_name'];
    _theme = json['theme'] != null ? Theme.fromJson(json['theme']) : null;
    _preferredSignInStrategy = json['preferred_sign_in_strategy'];
    _logoImageUrl = json['logo_image_url'];
    _faviconImageUrl = json['favicon_image_url'];
    _homeUrl = json['home_url'];
    _signInUrl = json['sign_in_url'];
    _signUpUrl = json['sign_up_url'];
    _userProfileUrl = json['user_profile_url'];
    _afterSignInUrl = json['after_sign_in_url'];
    _afterSignUpUrl = json['after_sign_up_url'];
    _afterSignOutOneUrl = json['after_sign_out_one_url'];
    _afterSignOutAllUrl = json['after_sign_out_all_url'];
    _afterSwitchSessionUrl = json['after_switch_session_url'];
    _organizationProfileUrl = json['organization_profile_url'];
    _createOrganizationUrl = json['create_organization_url'];
    _afterLeaveOrganizationUrl = json['after_leave_organization_url'];
    _afterCreateOrganizationUrl = json['after_create_organization_url'];
    _logoLinkUrl = json['logo_link_url'];
    _supportEmail = json['support_email'];
    _branded = json['branded'];
    _experimentalForceOauthFirst = json['experimental_force_oauth_first'];
    _clerkJsVersion = json['clerk_js_version'];
    _showDevmodeWarning = json['show_devmode_warning'];
    _googleOneTapClientId = json['google_one_tap_client_id'];
    _helpUrl = json['help_url'];
    _privacyPolicyUrl = json['privacy_policy_url'];
    _termsUrl = json['terms_url'];
    _logoUrl = json['logo_url'];
    _faviconUrl = json['favicon_url'];
    _logoImage = json['logo_image'] != null
        ? LogoImage.fromJson(json['logo_image'])
        : null;
    _faviconImage = json['favicon_image'] != null
        ? FaviconImage.fromJson(json['favicon_image'])
        : null;
    _captchaPublicKey = json['captcha_public_key'];
    _captchaWidgetType = json['captcha_widget_type'];
    _captchaPublicKeyInvisible = json['captcha_public_key_invisible'];
    _captchaProvider = json['captcha_provider'];
  }

  String? _object;
  String? _id;
  String? _instanceEnvironmentType;
  String? _applicationName;
  Theme? _theme;
  String? _preferredSignInStrategy;
  String? _logoImageUrl;
  String? _faviconImageUrl;
  String? _homeUrl;
  String? _signInUrl;
  String? _signUpUrl;
  String? _userProfileUrl;
  String? _afterSignInUrl;
  String? _afterSignUpUrl;
  String? _afterSignOutOneUrl;
  String? _afterSignOutAllUrl;
  String? _afterSwitchSessionUrl;
  String? _organizationProfileUrl;
  String? _createOrganizationUrl;
  String? _afterLeaveOrganizationUrl;
  String? _afterCreateOrganizationUrl;
  String? _logoLinkUrl;
  String? _supportEmail;
  bool? _branded;
  bool? _experimentalForceOauthFirst;
  String? _clerkJsVersion;
  bool? _showDevmodeWarning;
  dynamic _googleOneTapClientId;
  dynamic _helpUrl;
  dynamic _privacyPolicyUrl;
  dynamic _termsUrl;
  String? _logoUrl;
  String? _faviconUrl;
  LogoImage? _logoImage;
  FaviconImage? _faviconImage;
  String? _captchaPublicKey;
  String? _captchaWidgetType;
  String? _captchaPublicKeyInvisible;
  String? _captchaProvider;

  DisplayConfig copyWith({
    String? object,
    String? id,
    String? instanceEnvironmentType,
    String? applicationName,
    Theme? theme,
    String? preferredSignInStrategy,
    String? logoImageUrl,
    String? faviconImageUrl,
    String? homeUrl,
    String? signInUrl,
    String? signUpUrl,
    String? userProfileUrl,
    String? afterSignInUrl,
    String? afterSignUpUrl,
    String? afterSignOutOneUrl,
    String? afterSignOutAllUrl,
    String? afterSwitchSessionUrl,
    String? organizationProfileUrl,
    String? createOrganizationUrl,
    String? afterLeaveOrganizationUrl,
    String? afterCreateOrganizationUrl,
    String? logoLinkUrl,
    String? supportEmail,
    bool? branded,
    bool? experimentalForceOauthFirst,
    String? clerkJsVersion,
    bool? showDevmodeWarning,
    dynamic googleOneTapClientId,
    dynamic helpUrl,
    dynamic privacyPolicyUrl,
    dynamic termsUrl,
    String? logoUrl,
    String? faviconUrl,
    LogoImage? logoImage,
    FaviconImage? faviconImage,
    String? captchaPublicKey,
    String? captchaWidgetType,
    String? captchaPublicKeyInvisible,
    String? captchaProvider,
  }) =>
      DisplayConfig(
        object: object ?? _object,
        id: id ?? _id,
        instanceEnvironmentType:
            instanceEnvironmentType ?? _instanceEnvironmentType,
        applicationName: applicationName ?? _applicationName,
        theme: theme ?? _theme,
        preferredSignInStrategy:
            preferredSignInStrategy ?? _preferredSignInStrategy,
        logoImageUrl: logoImageUrl ?? _logoImageUrl,
        faviconImageUrl: faviconImageUrl ?? _faviconImageUrl,
        homeUrl: homeUrl ?? _homeUrl,
        signInUrl: signInUrl ?? _signInUrl,
        signUpUrl: signUpUrl ?? _signUpUrl,
        userProfileUrl: userProfileUrl ?? _userProfileUrl,
        afterSignInUrl: afterSignInUrl ?? _afterSignInUrl,
        afterSignUpUrl: afterSignUpUrl ?? _afterSignUpUrl,
        afterSignOutOneUrl: afterSignOutOneUrl ?? _afterSignOutOneUrl,
        afterSignOutAllUrl: afterSignOutAllUrl ?? _afterSignOutAllUrl,
        afterSwitchSessionUrl: afterSwitchSessionUrl ?? _afterSwitchSessionUrl,
        organizationProfileUrl:
            organizationProfileUrl ?? _organizationProfileUrl,
        createOrganizationUrl: createOrganizationUrl ?? _createOrganizationUrl,
        afterLeaveOrganizationUrl:
            afterLeaveOrganizationUrl ?? _afterLeaveOrganizationUrl,
        afterCreateOrganizationUrl:
            afterCreateOrganizationUrl ?? _afterCreateOrganizationUrl,
        logoLinkUrl: logoLinkUrl ?? _logoLinkUrl,
        supportEmail: supportEmail ?? _supportEmail,
        branded: branded ?? _branded,
        experimentalForceOauthFirst:
            experimentalForceOauthFirst ?? _experimentalForceOauthFirst,
        clerkJsVersion: clerkJsVersion ?? _clerkJsVersion,
        showDevmodeWarning: showDevmodeWarning ?? _showDevmodeWarning,
        googleOneTapClientId: googleOneTapClientId ?? _googleOneTapClientId,
        helpUrl: helpUrl ?? _helpUrl,
        privacyPolicyUrl: privacyPolicyUrl ?? _privacyPolicyUrl,
        termsUrl: termsUrl ?? _termsUrl,
        logoUrl: logoUrl ?? _logoUrl,
        faviconUrl: faviconUrl ?? _faviconUrl,
        logoImage: logoImage ?? _logoImage,
        faviconImage: faviconImage ?? _faviconImage,
        captchaPublicKey: captchaPublicKey ?? _captchaPublicKey,
        captchaWidgetType: captchaWidgetType ?? _captchaWidgetType,
        captchaPublicKeyInvisible:
            captchaPublicKeyInvisible ?? _captchaPublicKeyInvisible,
        captchaProvider: captchaProvider ?? _captchaProvider,
      );

  String? get object => _object;

  String? get id => _id;

  String? get instanceEnvironmentType => _instanceEnvironmentType;

  String? get applicationName => _applicationName;

  Theme? get theme => _theme;

  String? get preferredSignInStrategy => _preferredSignInStrategy;

  String? get logoImageUrl => _logoImageUrl;

  String? get faviconImageUrl => _faviconImageUrl;

  String? get homeUrl => _homeUrl;

  String? get signInUrl => _signInUrl;

  String? get signUpUrl => _signUpUrl;

  String? get userProfileUrl => _userProfileUrl;

  String? get afterSignInUrl => _afterSignInUrl;

  String? get afterSignUpUrl => _afterSignUpUrl;

  String? get afterSignOutOneUrl => _afterSignOutOneUrl;

  String? get afterSignOutAllUrl => _afterSignOutAllUrl;

  String? get afterSwitchSessionUrl => _afterSwitchSessionUrl;

  String? get organizationProfileUrl => _organizationProfileUrl;

  String? get createOrganizationUrl => _createOrganizationUrl;

  String? get afterLeaveOrganizationUrl => _afterLeaveOrganizationUrl;

  String? get afterCreateOrganizationUrl => _afterCreateOrganizationUrl;

  String? get logoLinkUrl => _logoLinkUrl;

  String? get supportEmail => _supportEmail;

  bool? get branded => _branded;

  bool? get experimentalForceOauthFirst => _experimentalForceOauthFirst;

  String? get clerkJsVersion => _clerkJsVersion;

  bool? get showDevmodeWarning => _showDevmodeWarning;

  dynamic get googleOneTapClientId => _googleOneTapClientId;

  dynamic get helpUrl => _helpUrl;

  dynamic get privacyPolicyUrl => _privacyPolicyUrl;

  dynamic get termsUrl => _termsUrl;

  String? get logoUrl => _logoUrl;

  String? get faviconUrl => _faviconUrl;

  LogoImage? get logoImage => _logoImage;

  FaviconImage? get faviconImage => _faviconImage;

  String? get captchaPublicKey => _captchaPublicKey;

  String? get captchaWidgetType => _captchaWidgetType;

  String? get captchaPublicKeyInvisible => _captchaPublicKeyInvisible;

  String? get captchaProvider => _captchaProvider;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['object'] = _object;
    map['id'] = _id;
    map['instance_environment_type'] = _instanceEnvironmentType;
    map['application_name'] = _applicationName;
    if (_theme != null) {
      map['theme'] = _theme?.toJson();
    }
    map['preferred_sign_in_strategy'] = _preferredSignInStrategy;
    map['logo_image_url'] = _logoImageUrl;
    map['favicon_image_url'] = _faviconImageUrl;
    map['home_url'] = _homeUrl;
    map['sign_in_url'] = _signInUrl;
    map['sign_up_url'] = _signUpUrl;
    map['user_profile_url'] = _userProfileUrl;
    map['after_sign_in_url'] = _afterSignInUrl;
    map['after_sign_up_url'] = _afterSignUpUrl;
    map['after_sign_out_one_url'] = _afterSignOutOneUrl;
    map['after_sign_out_all_url'] = _afterSignOutAllUrl;
    map['after_switch_session_url'] = _afterSwitchSessionUrl;
    map['organization_profile_url'] = _organizationProfileUrl;
    map['create_organization_url'] = _createOrganizationUrl;
    map['after_leave_organization_url'] = _afterLeaveOrganizationUrl;
    map['after_create_organization_url'] = _afterCreateOrganizationUrl;
    map['logo_link_url'] = _logoLinkUrl;
    map['support_email'] = _supportEmail;
    map['branded'] = _branded;
    map['experimental_force_oauth_first'] = _experimentalForceOauthFirst;
    map['clerk_js_version'] = _clerkJsVersion;
    map['show_devmode_warning'] = _showDevmodeWarning;
    map['google_one_tap_client_id'] = _googleOneTapClientId;
    map['help_url'] = _helpUrl;
    map['privacy_policy_url'] = _privacyPolicyUrl;
    map['terms_url'] = _termsUrl;
    map['logo_url'] = _logoUrl;
    map['favicon_url'] = _faviconUrl;
    if (_logoImage != null) {
      map['logo_image'] = _logoImage?.toJson();
    }
    if (_faviconImage != null) {
      map['favicon_image'] = _faviconImage?.toJson();
    }
    map['captcha_public_key'] = _captchaPublicKey;
    map['captcha_widget_type'] = _captchaWidgetType;
    map['captcha_public_key_invisible'] = _captchaPublicKeyInvisible;
    map['captcha_provider'] = _captchaProvider;
    return map;
  }
}

/// object : "image"
/// id : "img_something"
/// public_url : "https://images.clerk.dev/uploaded/img_something"

FaviconImage faviconImageFromJson(String str) =>
    FaviconImage.fromJson(json.decode(str));

String faviconImageToJson(FaviconImage data) => json.encode(data.toJson());

class FaviconImage {
  FaviconImage({
    String? object,
    String? id,
    String? publicUrl,
  }) {
    _object = object;
    _id = id;
    _publicUrl = publicUrl;
  }

  FaviconImage.fromJson(dynamic json) {
    _object = json['object'];
    _id = json['id'];
    _publicUrl = json['public_url'];
  }

  String? _object;
  String? _id;
  String? _publicUrl;

  FaviconImage copyWith({
    String? object,
    String? id,
    String? publicUrl,
  }) =>
      FaviconImage(
        object: object ?? _object,
        id: id ?? _id,
        publicUrl: publicUrl ?? _publicUrl,
      );

  String? get object => _object;

  String? get id => _id;

  String? get publicUrl => _publicUrl;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['object'] = _object;
    map['id'] = _id;
    map['public_url'] = _publicUrl;
    return map;
  }
}

/// object : "image"
/// id : "img_2kFn64a9LeajXEnjD4w8koPUUxG"
/// public_url : "https://images.clerk.dev/uploaded/img_2kFn64a9LeajXEnjD4w8koPUUxG"

LogoImage logoImageFromJson(String str) => LogoImage.fromJson(json.decode(str));

String logoImageToJson(LogoImage data) => json.encode(data.toJson());

class LogoImage {
  LogoImage({
    String? object,
    String? id,
    String? publicUrl,
  }) {
    _object = object;
    _id = id;
    _publicUrl = publicUrl;
  }

  LogoImage.fromJson(dynamic json) {
    _object = json['object'];
    _id = json['id'];
    _publicUrl = json['public_url'];
  }

  String? _object;
  String? _id;
  String? _publicUrl;

  LogoImage copyWith({
    String? object,
    String? id,
    String? publicUrl,
  }) =>
      LogoImage(
        object: object ?? _object,
        id: id ?? _id,
        publicUrl: publicUrl ?? _publicUrl,
      );

  String? get object => _object;

  String? get id => _id;

  String? get publicUrl => _publicUrl;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['object'] = _object;
    map['id'] = _id;
    map['public_url'] = _publicUrl;
    return map;
  }
}

/// buttons : {"font_color":"#ffffff","font_family":"\"Source Sans Pro\", sans-serif","font_weight":"600"}
/// general : {"color":"#0F172A","padding":"1em","box_shadow":"0 2px 8px rgba(0, 0, 0, 0.2)","font_color":"#151515","font_family":"\"Source Sans Pro\", sans-serif","border_radius":"0.5em","background_color":"#ffffff","label_font_weight":"600"}
/// accounts : {"background_color":"#ffffff"}

Theme themeFromJson(String str) => Theme.fromJson(json.decode(str));

String themeToJson(Theme data) => json.encode(data.toJson());

class Theme {
  Theme({
    Buttons? buttons,
    General? general,
    Accounts? accounts,
  }) {
    _buttons = buttons;
    _general = general;
    _accounts = accounts;
  }

  Theme.fromJson(dynamic json) {
    _buttons =
        json['buttons'] != null ? Buttons.fromJson(json['buttons']) : null;
    _general =
        json['general'] != null ? General.fromJson(json['general']) : null;
    _accounts =
        json['accounts'] != null ? Accounts.fromJson(json['accounts']) : null;
  }

  Buttons? _buttons;
  General? _general;
  Accounts? _accounts;

  Theme copyWith({
    Buttons? buttons,
    General? general,
    Accounts? accounts,
  }) =>
      Theme(
        buttons: buttons ?? _buttons,
        general: general ?? _general,
        accounts: accounts ?? _accounts,
      );

  Buttons? get buttons => _buttons;

  General? get general => _general;

  Accounts? get accounts => _accounts;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (_buttons != null) {
      map['buttons'] = _buttons?.toJson();
    }
    if (_general != null) {
      map['general'] = _general?.toJson();
    }
    if (_accounts != null) {
      map['accounts'] = _accounts?.toJson();
    }
    return map;
  }
}

/// background_color : "#ffffff"

Accounts accountsFromJson(String str) => Accounts.fromJson(json.decode(str));

String accountsToJson(Accounts data) => json.encode(data.toJson());

class Accounts {
  Accounts({
    String? backgroundColor,
  }) {
    _backgroundColor = backgroundColor;
  }

  Accounts.fromJson(dynamic json) {
    _backgroundColor = json['background_color'];
  }

  String? _backgroundColor;

  Accounts copyWith({
    String? backgroundColor,
  }) =>
      Accounts(
        backgroundColor: backgroundColor ?? _backgroundColor,
      );

  String? get backgroundColor => _backgroundColor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['background_color'] = _backgroundColor;
    return map;
  }
}

/// color : "#0F172A"
/// padding : "1em"
/// box_shadow : "0 2px 8px rgba(0, 0, 0, 0.2)"
/// font_color : "#151515"
/// font_family : "\"Source Sans Pro\", sans-serif"
/// border_radius : "0.5em"
/// background_color : "#ffffff"
/// label_font_weight : "600"

General generalFromJson(String str) => General.fromJson(json.decode(str));

String generalToJson(General data) => json.encode(data.toJson());

class General {
  General({
    String? color,
    String? padding,
    String? boxShadow,
    String? fontColor,
    String? fontFamily,
    String? borderRadius,
    String? backgroundColor,
    String? labelFontWeight,
  }) {
    _color = color;
    _padding = padding;
    _boxShadow = boxShadow;
    _fontColor = fontColor;
    _fontFamily = fontFamily;
    _borderRadius = borderRadius;
    _backgroundColor = backgroundColor;
    _labelFontWeight = labelFontWeight;
  }

  General.fromJson(dynamic json) {
    _color = json['color'];
    _padding = json['padding'];
    _boxShadow = json['box_shadow'];
    _fontColor = json['font_color'];
    _fontFamily = json['font_family'];
    _borderRadius = json['border_radius'];
    _backgroundColor = json['background_color'];
    _labelFontWeight = json['label_font_weight'];
  }

  String? _color;
  String? _padding;
  String? _boxShadow;
  String? _fontColor;
  String? _fontFamily;
  String? _borderRadius;
  String? _backgroundColor;
  String? _labelFontWeight;

  General copyWith({
    String? color,
    String? padding,
    String? boxShadow,
    String? fontColor,
    String? fontFamily,
    String? borderRadius,
    String? backgroundColor,
    String? labelFontWeight,
  }) =>
      General(
        color: color ?? _color,
        padding: padding ?? _padding,
        boxShadow: boxShadow ?? _boxShadow,
        fontColor: fontColor ?? _fontColor,
        fontFamily: fontFamily ?? _fontFamily,
        borderRadius: borderRadius ?? _borderRadius,
        backgroundColor: backgroundColor ?? _backgroundColor,
        labelFontWeight: labelFontWeight ?? _labelFontWeight,
      );

  String? get color => _color;

  String? get padding => _padding;

  String? get boxShadow => _boxShadow;

  String? get fontColor => _fontColor;

  String? get fontFamily => _fontFamily;

  String? get borderRadius => _borderRadius;

  String? get backgroundColor => _backgroundColor;

  String? get labelFontWeight => _labelFontWeight;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['color'] = _color;
    map['padding'] = _padding;
    map['box_shadow'] = _boxShadow;
    map['font_color'] = _fontColor;
    map['font_family'] = _fontFamily;
    map['border_radius'] = _borderRadius;
    map['background_color'] = _backgroundColor;
    map['label_font_weight'] = _labelFontWeight;
    return map;
  }
}

/// font_color : "#ffffff"
/// font_family : "\"Source Sans Pro\", sans-serif"
/// font_weight : "600"

Buttons buttonsFromJson(String str) => Buttons.fromJson(json.decode(str));

String buttonsToJson(Buttons data) => json.encode(data.toJson());

class Buttons {
  Buttons({
    String? fontColor,
    String? fontFamily,
    String? fontWeight,
  }) {
    _fontColor = fontColor;
    _fontFamily = fontFamily;
    _fontWeight = fontWeight;
  }

  Buttons.fromJson(dynamic json) {
    _fontColor = json['font_color'];
    _fontFamily = json['font_family'];
    _fontWeight = json['font_weight'];
  }

  String? _fontColor;
  String? _fontFamily;
  String? _fontWeight;

  Buttons copyWith({
    String? fontColor,
    String? fontFamily,
    String? fontWeight,
  }) =>
      Buttons(
        fontColor: fontColor ?? _fontColor,
        fontFamily: fontFamily ?? _fontFamily,
        fontWeight: fontWeight ?? _fontWeight,
      );

  String? get fontColor => _fontColor;

  String? get fontFamily => _fontFamily;

  String? get fontWeight => _fontWeight;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['font_color'] = _fontColor;
    map['font_family'] = _fontFamily;
    map['font_weight'] = _fontWeight;
    return map;
  }
}
