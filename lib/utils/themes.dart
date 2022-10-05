import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color buttonColor = Color(0xFFF15223);
const Color darkBackgroundColor = Color(0xFF404040);
const Color lightBackgroundColor = Color(0xFFFAFAFA);
const Color primaryColor = Color(0xFFF4A135);
const Color textFieldFillColorDark = Color(0xFF2C2C2C);
const Color textFieldFillColorLight = Color(0xFFEEECEC);
const Color iconColor = Color(0xFF4E4D4F);

class Themes {
  static ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primaryColor,
    ),
    appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: darkBackgroundColor,
        iconTheme: Get.theme.iconTheme.copyWith(
          color: primaryColor,
        )),
    textTheme: Get.theme.textTheme.apply(
      displayColor: primaryColor,
      bodyColor: Colors.white,
    ),
    iconTheme: Get.theme.iconTheme.copyWith(
      color: primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        fixedSize: Size.fromWidth(Get.width * 0.8),
        padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.02,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: textFieldFillColorDark,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none),
    ),
  );

  static ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
    ),
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: lightBackgroundColor,
      iconTheme: Get.theme.iconTheme.copyWith(
        color: primaryColor,
      ),
      // systemOverlayStyle: SystemUiOverlayStyle.dark
    ),
    textTheme: Get.theme.textTheme.apply(
      displayColor: primaryColor,
      bodyColor: Colors.black,
    ),
    iconTheme: Get.theme.iconTheme.copyWith(
      color: primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fixedSize: Size.fromWidth(Get.width * 0.8),
          padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
          )),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: textFieldFillColorLight,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none),
    ),
  );
}
