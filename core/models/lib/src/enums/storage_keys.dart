enum StorageKeys {
  authToken('auth_token'),
  signUpId('sign_up_id'),
  userId('user_id'),
  email('email'),
  password('password'),
  languageIsoCode('language_iso_code');

  const StorageKeys(this.key);

  final String key;
}
