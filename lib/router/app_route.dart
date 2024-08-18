enum AppRoute {
  home('/'),
  anonymousChat('/anonymous-chat'),
  goals('/goals');

  const AppRoute(this.path);

  final String path;
}
