import 'package:flutter/material.dart';

import '../constants/color.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color primaryColor,
    required Color secondaryColor,
    required Color backgroundColor,
    required Color error,
  }) {
    return ThemeData(
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: brightness,
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: primaryColor,
        backgroundColor: ColorConstants.white,
        elevation: 0,
      ),
      fontFamily: 'Roboto',
      unselectedWidgetColor: ColorConstants.primary,
      toggleableActiveColor: ColorConstants.primary,
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        primaryColor: ColorConstants.primary,
        secondaryColor: ColorConstants.secondary,
        backgroundColor: ColorConstants.lightGray,
        error: ColorConstants.error,
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        primaryColor: ColorConstants.primary,
        secondaryColor: ColorConstants.secondary,
        backgroundColor: ColorConstants.black,
        error: ColorConstants.error,
      );
}
