enum AppRoute {
  home('/'),
  chat('/chat'),
  goals('/goals'),
  signIn('/sign-in'),
  code('/code'),
  signUp('/sign-up');

  const AppRoute(this.path);

  final String path;
}
