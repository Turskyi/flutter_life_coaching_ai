enum StorageKeys {
  authToken('auth_token'),
  signUpId('sign_up_id'),
  userId('sign_up_id'),
  email('email'),
  languageIsoCode('language_iso_code');

  const StorageKeys(this.key);

  final String key;
}
