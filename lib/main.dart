import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messenger/controllers/theme_controller.dart';
import 'package:messenger/screens/home_screen.dart';
import 'package:messenger/screens/intro_screen.dart';
import 'package:messenger/screens/register_screen.dart';
import 'package:messenger/utils/constants.dart';
import 'package:messenger/utils/translations.dart';
import 'firebase_options.dart';
import 'utils/themes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    _themeController.getThemeStatus();
  }

  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Messenger',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      translations: Messages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      home: FutureBuilder(
        future: getSharedPreferences()
            .then((prefs) => prefs.getBool("isFirstTime")!),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          if (snapshot.hasError) {
            EasyLoading.showInfo(
                'Failed with error code ${snapshot.error.hashCode.toString()}');
          }
          bool? isFirstTime = snapshot.data;
          if (isFirstTime == null) {
            getSharedPreferences()
                .then((prefs) => prefs.setBool('isFirstTime', false));
            return const IntroScreen();
          }
          return const RegisterScreen();
        },
      ),
      builder: EasyLoading.init(),
    );
  }
}
