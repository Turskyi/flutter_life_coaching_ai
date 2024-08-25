enum StorageKeys {
  authToken('auth_token'),
  signUpId('sign_up_id'),
  languageIsoCode('language_iso_code');

  const StorageKeys(this.key);

  final String key;
}
