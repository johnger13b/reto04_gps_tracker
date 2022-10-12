import 'package:flutter/material.dart';

class MyTheme {
  static const Color primaryColor = Color(0xffeb5e28);
  static const Color secondaryColor = Color(0xff00aa65);
  static const Color tertiaryColor = Color(0xffccc5b9);
  static const Color lightPrimaryColor = Color(0xffffe5d9);
  static const Color lightTertiaryColor = Color(0xfffffcf2);
  static const Color darkColor = Color(0xff252422);

  static final ThemeData theme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: tertiaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
    ),
  );
}
