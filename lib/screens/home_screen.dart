import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/controllers/home_screen_controller.dart';
import 'package:messenger/controllers/theme_controller.dart';
import 'package:messenger/utils/themes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.user}) : super(key: key);

  final User? user;

  final ThemeController _themeController = Get.find();
  final HomeScreenController _homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messenger'),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
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
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        
        items: [
        CustomNavigationBarItem(
          icon: IconButton(
            icon: Icon(
              Icons.message_rounded,
              color: _homeScreenController.currentBottomBarItemIndex.value == 0
                  ? primaryColor
                  : iconColor,
            ),
            onPressed: () {},
          ),
        ),
        CustomNavigationBarItem(
          icon: IconButton(
            icon: Icon(
              Icons.call,
              color: _homeScreenController.currentBottomBarItemIndex.value == 1
                  ? primaryColor
                  : iconColor,
            ),
            onPressed: () {},
          ),
        ),
        CustomNavigationBarItem(
          icon: IconButton(
            icon: Icon(
              Icons.people,
              color: _homeScreenController.currentBottomBarItemIndex.value == 2
                  ? primaryColor
                  : iconColor,
            ),
            onPressed: () {},
          ),
        ),
        CustomNavigationBarItem(
          icon: IconButton(
            icon: Icon(
              Icons.settings,
              color: _homeScreenController.currentBottomBarItemIndex.value == 3
                  ? primaryColor
                  : iconColor,
            ),
            onPressed: () {},
          ),
        ),
      ]),
    );
  }
}
