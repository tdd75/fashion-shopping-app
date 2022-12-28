import 'package:flutter/material.dart';

class AppTheme {
  static final _generalTheme = ThemeData().copyWith(
    primaryColor: const Color(0xFFFF7A00),
    hintColor: Colors.white,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color(0xFFFF7A00),
          secondary: const Color(0xFFFFB800),
        ),
  );

  static final lightTheme = _generalTheme.copyWith(
    brightness: Brightness.light,
  );

  static final darkTheme = _generalTheme.copyWith(
    brightness: Brightness.dark,
  );
}
