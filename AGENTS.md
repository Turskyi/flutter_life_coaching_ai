# Agent guide for contributors (AI coding agents)

Purpose: quick, action-oriented instructions so an AI agent (or new developer)
can be productive in this repo.

1) Big-picture architecture

- Onion (monolithic) inside `lib/` — core layers are `models`,
  `domain_services` (interfaces), `application_services` (
  blocs/use-cases/implementations), and outer `infrastructure` + `ui`.
- Composition root: `lib/main.dart` initializes DI and bootstraps the app. Keep
  GetIt usage at that file only. See `lib/di/injector.dart` and generated
  `injector.config.dart`.

2) Dependency Injection & codegen

- Uses `get_it` + `injectable`. Generated entry: `lib/di/injector.config.dart` (
  created by `injectable_generator`).
- Other generators in use: `json_serializable`, `retrofit_generator`,
  `envied_generator`.
- Regenerate generated code before running/building:
  dart run build_runner clean
  dart run build_runner build --delete-conflicting-outputs

3) Build / run / test commands (the ones that actually matter)

- Install deps: `flutter pub get`
- Generate code (required): build_runner commands above
- Run app: `flutter run` (or use IDE run configurations). Composition root reads
  from `GetIt` so ensure generated DI exists.
- Tests: `flutter test` (unit/widget tests live in `test/`). Mocks use
  `mockito`/`mocktail` and some test helpers are under `test/`.

4) Important project-specific conventions & patterns

- Domain-first: `domain_services` declare interfaces (e.g.,
  `AiConsentRepository`) and `application_services` implements them. Always
  prefer editing/adding interfaces in `domain_services` and concrete
  implementations in `application_services` or `infrastructure`.
- Composition-root-only GetIt: main.dart contains comments explaining design —
  do not spread GetIt.get() throughout the app; instead prefer constructor
  injection for widgets/services.
- Bloc provisioning pattern: routes use pre-resolved blocs and
  `BlocProvider.value(...)` with immediate event dispatch, e.g.
  `chatBloc..add(const LoadingInitialChatStateEvent())` in
  `lib/router/router.dart`. When adding routes that need blocs follow the same
  pattern.
- Localization bootstrap: `flutter_translate` delegate is created in startup (
  not registered in GetIt). See `lib/main.dart` and
  `lib/localization/localization_delelegate_getter.dart`.
- Persistent small services via `injectable` singletons: e.g. `ThemeService` (
  `@lazySingleton`) uses `SharedPreferences` and exposes a
  `ValueNotifier<ThemeMode>` (see
  `lib/infrastructure/services/theme_service.dart`).
- File organization: Prefer one class per file. Common sense exceptions allowed
  for related small classes like BLoC states/events or the `State` of a
  `StatefulWidget`.

5) Integration points & external dependencies

- Internal path packages: `core/models`, `core/repositories/*` are referenced
  via `path:` in `pubspec.yaml`. Edits in those folders affect app build —
  ensure to run `flutter pub get` after changes.
- Remote/infrastructure: `dio`, `retrofit` used for HTTP clients — codegen
  produces API clients via annotations. Look under `lib/infrastructure` for REST
  clients and DTOs.
- Authentication & AI: `authentication_repository` is an internal package; AI
  consent surfaces via `AiConsentRepository` interface and `AiConsentDialog`
  UI (see `lib/domain_services/ai_consent_repository.dart` and
  `lib/ui/dialogs/ai_consent_dialog.dart`). If you wire new AI features, follow
  existing consent flow and privacy policy route `AppRoute.privacyPolity`.

6) Where to change routes & navigation

- Centralized in `lib/router/` — `app_route.dart` defines paths and
  `router.dart` maps them to widgets. To add a page: add route enum in
  `app_route.dart` and mapping in `router.dart`; if the page needs a bloc,
  accept a pre-resolved instance and use `BlocProvider.value` as existing pages
  do.

7) Quick code examples (copy-paste friendly)

- Bootstrap DI and run app (composition root): `lib/main.dart` — see how
  `injectDependencies()` is awaited and services/blocs are retrieved before
  `runApp`.
- Provide pre-resolved bloc to a route (example from `router.dart`):
  AppRoute.chat.path: (BuildContext _) => BlocProvider<ChatBloc>.value(
  value: chatBloc..add(const LoadingInitialChatStateEvent()),
  child: const AiChatPage(),
  ),

8) Searching for relevant files

- Key directories: `lib/application_services`, `lib/domain_services`,
  `lib/infrastructure`, `lib/ui`, `lib/di`, `lib/router`, `core/` (external
  internal packages).

9) Tests & CI hints

- Tests are in `test/`. CI includes build badges in `README.md` — expect codegen
  step to be present in CI. If CI fails with missing generated files, run
  build_runner locally and commit generated outputs if CI expects them.

10) Non-obvious gotchas

- Many services are provided by `injectable` and require generated code —
  runtime errors like missing types usually mean DI wasn't generated.
- `LocalizationDelegate` intentionally not injected — changing it into DI would
  break the intended startup separation.
- When changing route arguments, check how
  `ModalRoute.of(context)?.settings.arguments` is used (see reset password route
  in `router.dart`).

Reference files: `lib/main.dart`, `lib/di/injector.dart`,
`lib/router/router.dart`, `lib/domain_services/ai_consent_repository.dart`,
`lib/ui/dialogs/ai_consent_dialog.dart`,
`lib/infrastructure/services/theme_service.dart`, `pubspec.yaml`, `README.md`.

If something else needs to be added to this guide (examples, CI commands, or
codegen tips), tell me which area to expand.

Note: This `AGENTS.md` file must not be longer than 200 lines - the line
containing this rule must appear at or before line 200.
