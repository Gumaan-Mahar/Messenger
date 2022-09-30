import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxString brightnessMode = 'system'.obs;

  saveThemeStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('theme', brightnessMode.value);
  }

  getThemeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String currentTheme = prefs.getString('theme') ?? 'system';
    brightnessMode.value = currentTheme;
    Get.changeThemeMode(brightnessMode.value == 'system'
        ? ThemeMode.system
        : brightnessMode.value == 'dark'
            ? ThemeMode.dark
            : ThemeMode.light);
  }
}
