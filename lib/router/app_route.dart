enum AppRoute {
  home('/'),
  chat('/chat'),
  goals('/goals'),
  signIn('/sign-in'),
  code('/code'),
  resetPassword('/reset-password'),
  privacyPolity('/privacy-policy'),
  about('/about'),
  support('/support'),
  signUp('/sign-up');

  const AppRoute(this.path);

  final String path;
}
