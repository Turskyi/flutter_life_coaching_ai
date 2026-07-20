import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:clerk_auth/clerk_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A [Persistor] implementation that uses [SharedPreferences] to persist
/// Clerk authentication data.
class SharedPreferencesPersistor implements Persistor {
  SharedPreferencesPersistor(this._preferences);

  final SharedPreferences _preferences;
  static const String _namespace = 'clerk_auth';

  String _prefixed(String key) => '$_namespace.$key';

  @override
  Future<void> initialize() async {
    // SharedPreferences is already initialized and injected via the
    // constructor, so no further initialization is required here.
  }

  @override
  void terminate() {
    // SharedPreferences does not require explicit termination in this context.
  }

  @override
  FutureOr<T?> read<T>(String key) {
    final String? value = _preferences.getString(_prefixed(key));
    if (value == null) return null;
    try {
      return jsonDecode(value) as T?;
    } catch (e, st) {
      log(
        'Error decoding Clerk data for key: $key',
        name: 'SharedPreferencesPersistor',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }

  @override
  FutureOr<void> write<T>(String key, T value) {
    _preferences.setString(_prefixed(key), jsonEncode(value));
  }

  @override
  FutureOr<void> delete(String key) {
    _preferences.remove(_prefixed(key));
  }
}
