import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This example was taken from the official documentation at
/// https://pub.dev/packages/injectable#pre-resolving-futures.
///
/// The `SharedPreferencesModule` class uses the `@module` annotation to
/// indicate that it provides dependencies. The `@preResolve` annotation
/// is used to ensure that the `SharedPreferences` instance is resolved
/// before it is injected.
@module
abstract class SharedPreferencesModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
