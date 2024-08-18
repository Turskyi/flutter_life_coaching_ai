enum AppRoute {
  home('/'),
  anonymousChat('/anonymous-chat'),
  goals('/goals'),
  signIn('/sign-in'),
  signUp('/sign-up');

  const AppRoute(this.path);

  final String path;
}
