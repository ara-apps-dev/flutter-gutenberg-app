import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';

class AppTheme {
  const AppTheme._();

  static TextStyle blackTextStyle = GoogleFonts.poppins(
    color: kBlackColor,
  );
  static TextStyle whiteTextStyle = GoogleFonts.poppins(
    color: kWhiteColor,
  );
  static TextStyle greyTextStyle = GoogleFonts.poppins(
    color: kGreyColor,
  );
  static TextStyle greenTextStyle = GoogleFonts.poppins(
    color: kGreenColor,
  );
  static TextStyle redTextStyle = GoogleFonts.poppins(
    color: kRedColor,
  );
  static TextStyle primaryTextStyle = GoogleFonts.poppins(
    color: kPrimaryColor,
  );

  static BottomNavigationBarThemeData bottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
    selectedItemColor: kPrimaryColor,
    unselectedItemColor: kGreyColor,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  );

  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;

  static ColorScheme kColorScheme = const ColorScheme(
    primary: kPrimaryColor,
    primaryContainer: kBackgroundColor,
    secondary: kGreenColor,
    secondaryContainer: kGreenColor,
    surface: kBackgroundColor,
    error: Colors.red,
    onPrimary: kPrimaryColor,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primaryColor: kPrimaryColor,
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      colorScheme: kColorScheme.copyWith(secondary: kPrimaryColor),
      bottomNavigationBarTheme: bottomNavigationBarTheme);
}
