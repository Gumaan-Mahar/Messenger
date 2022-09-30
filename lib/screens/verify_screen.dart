import 'dart:developer';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:messenger/controllers/verify_screen_controller.dart';
import 'package:messenger/utils/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/themes.dart';
import 'home_screen.dart';

class VerifyPhoneNumber extends StatefulWidget {
  const VerifyPhoneNumber(
      {Key? key,
      required this.phoneNumber,
      required this.verificationId,
      required this.forceResendingToken})
      : super(key: key);

  final String phoneNumber;
  final String verificationId;
  final int? forceResendingToken;

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();
  final VerifyScreenController _verifyScreenController =
      Get.put(VerifyScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.15,
              ),
              SvgPicture.asset(
                'assets/images/Logo.svg',
                alignment: Alignment.centerRight,
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
              Text(
                'Verify Number'.tr,
                style: context.theme.textTheme.headlineSmall!.copyWith(
                  color: primaryColor,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                'Enter 6 digits code received on your number'.tr,
                style: context.theme.textTheme.labelLarge!.copyWith(
                  color: primaryColor,
                ),
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              Text(widget.phoneNumber),
              SizedBox(
                height: Get.height * 0.06,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: Get.width * 0.8,
                      child: PinCodeTextField(
                        controller: textEditingController,
                        appContext: context,
                        length: 6,
                        backgroundColor: Get.theme.scaffoldBackgroundColor,
                        keyboardType: TextInputType.phone,
                        pinTheme: PinTheme(
                          activeColor: Colors.black,
                          inactiveColor: const Color(0xFF959595),
                          selectedColor: primaryColor,
                          errorBorderColor: Colors.red,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Fields cannot be empty'.tr;
                          } else if (!value.isNumericOnly) {
                            return 'Fields only accept numeric values'.tr;
                          } else if (value.length < 6) {
                            return 'All fields are required'.tr;
                          }
                          return null;
                        },
                        onChanged: (String value) {},
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.08,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ArgonTimerButton(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.05,
                        color: Get.theme.scaffoldBackgroundColor,
                        roundLoadingShape: false,
                        borderRadius: 10.0,
                        elevation: 0.0,
                        loader: (timeLeft) {
                          return UnconstrainedBox(
                            child: Text('Resend Code in $timeLeft seconds'),
                          );
                        },
                        onTap: (startTimer, btnState) {
                          if (btnState == ButtonState.Idle) {
                            startTimer(30);
                          }
                        },
                        child: const Text(
                          'Resend Code',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Edit Number'.tr),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          EasyLoading.show(status: 'Verifying...'.tr);
                          final credential = PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: textEditingController.text);
                          auth
                              .signInWithCredential(credential)
                              .then((UserCredential result) {
                            EasyLoading.dismiss();
                            Get.offAll(() => HomeScreen(user: result.user));
                          }).catchError(
                            (e) {
                              EasyLoading.dismiss();
                              EasyLoading.showError(
                                e.message,
                                duration: const Duration(seconds: 8),
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        'VERIFY'.tr,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
