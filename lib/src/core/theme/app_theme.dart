import 'package:flutter/material.dart';

import '../constant/colors.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: aLightPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: aLightBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: aLightSecondaryColor,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: aLightSecondaryColor)),
    colorScheme: ColorScheme.light(secondary: aLightSecondaryColor)
        .copyWith(surface: aLightBackgroundColor),
  );

  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: aDarkPrimaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: aDarkTextColor)),
      colorScheme: ColorScheme.light(secondary: aLightSecondaryColor)
          .copyWith(surface: aDarkBackgroundColor));
}
