import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class ThemeService {
  ThemeService(this._prefs) {
    final String? savedTheme = _prefs.getString(_themeKey);
    final ThemeMode initialTheme = savedTheme == 'light'
        ? ThemeMode.light
        : ThemeMode.dark;
    _themeNotifier = ValueNotifier<ThemeMode>(initialTheme);
  }

  static const String _themeKey = 'app_theme_mode';

  final SharedPreferences _prefs;
  late ValueNotifier<ThemeMode> _themeNotifier;

  ValueNotifier<ThemeMode> get themeNotifier => _themeNotifier;

  ThemeMode get currentTheme => _themeNotifier.value;

  bool get isDarkMode => _themeNotifier.value == ThemeMode.dark;

  Future<void> toggleTheme() async {
    final ThemeMode newTheme = _themeNotifier.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    _themeNotifier.value = newTheme;
    await _prefs.setString(
      _themeKey,
      newTheme == ThemeMode.light ? 'light' : 'dark',
    );
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    _themeNotifier.value = themeMode;
    await _prefs.setString(
      _themeKey,
      themeMode == ThemeMode.light ? 'light' : 'dark',
    );
  }
}
