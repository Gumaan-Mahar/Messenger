import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:messenger/controllers/theme_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.user}) : super(key: key);

  final User? user;

  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messenger'),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: const Text('Light'),
                onTap: () {
                  _themeController.brightnessMode.value = 'light';

                  _themeController.saveThemeStatus();
                  _themeController.getThemeStatus();
                },
              ),
              PopupMenuItem(
                child: const Text('Dark'),
                onTap: () {
                  _themeController.brightnessMode.value = 'dark';
                  _themeController.saveThemeStatus();
                  _themeController.getThemeStatus();
                },
              ),
              PopupMenuItem(
                child: const Text('System'),
                onTap: () {
                  _themeController.brightnessMode.value = 'system';
                  _themeController.saveThemeStatus();
                  _themeController.getThemeStatus();
                },
              ),
            ];
          }),
        ],
      ),
    );
  }
}
