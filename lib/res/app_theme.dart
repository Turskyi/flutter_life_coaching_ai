import 'package:flutter/material.dart';

abstract class AppTheme {
  AppTheme._();

  static ThemeData darkTheme = ThemeData.dark();

  static ThemeData lightTheme = ThemeData.light(useMaterial3: true);
}
