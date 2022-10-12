import 'package:flutter/material.dart';

class MyTheme {
  static const Color primaryColor = Color(0xff009476);
  static const Color secondaryColor = Color(0xffffc40c);
  static const Color tertiaryColor = Color(0xffbbe2c9);
  static const Color lightPrimaryColor = Color(0xffd3d7dc);
  static const Color lightTertiaryColor = Color(0xffF1EFDC);
  static const Color darkColor = Color(0xff141c14);
  static const Color white = Color(0xffffffff);

  static final ThemeData theme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: tertiaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        textStyle: const TextStyle(fontSize: 19),
      ),
    ),
  );
}
