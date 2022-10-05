import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/screens/register_screen.dart';

import '../utils/themes.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? const Color(0xFF595959) : const Color(0xFFEEECEC),
        body: DefaultTabController(
          length: 3,
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  Container(
                    color: Get.isDarkMode
                        ? const Color(0xFF404040)
                        : const Color(0xFFEEECEC),
                    width: Get.width,
                    height: Get.height * 0.8,
                    child: TabBarView(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              'assets/images/intro_1.png',
                              width: Get.width,
                              fit: BoxFit.fitHeight,
                            ),
                            const IntroTextContainer(
                              textTitle: 'Call Your Contacts',
                              textDescription:
                                  'Call your contacts in the app for free. A best calling quality.',
                            ),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              'assets/images/intro_2.png',
                              width: Get.width,
                              fit: BoxFit.fitHeight,
                            ),
                            const IntroTextContainer(
                                textTitle: 'Stay Connected With Your Friends!',
                                textDescription:
                                    'Keep in touch with your friends. Chat with each other flawlessly.'),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              'assets/images/intro_3.png',
                              width: Get.width,
                              fit: BoxFit.fitHeight,
                            ),
                            const IntroTextContainer(
                                textTitle: 'Share Media With Each Other',
                                textDescription:
                                    'Using this app you can share images, videos, and attached files easily with each other.'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const TabPageSelector(
                    selectedColor: buttonColor,
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => const RegisterScreen());
                    },
                    child: const Text('Get Started'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class IntroTextContainer extends StatelessWidget {
  const IntroTextContainer({
    Key? key,
    required this.textTitle,
    required this.textDescription,
  }) : super(key: key);

  final String textTitle;
  final String textDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.2,
      padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.02, horizontal: Get.width * 0.04),
      decoration: BoxDecoration(
        color:
            Get.isDarkMode ? const Color(0xFF595959) : const Color(0xFFEEECEC),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width * 0.6,
            child: Text(
              textTitle,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.headlineSmall!.copyWith(
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          SizedBox(
            width: Get.width * 0.8,
            child: Text(
              textDescription,
              textAlign: TextAlign.center,
              style: Get.theme.textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
