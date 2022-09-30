import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messenger/controllers/theme_controller.dart';
import 'package:messenger/screens/home_screen.dart';
import 'package:messenger/screens/register_screen.dart';
import 'package:messenger/utils/translations.dart';
import 'firebase_options.dart';
import 'utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
      home:  const RegisterScreen(),
      builder: EasyLoading.init(),
    );
  }
}
