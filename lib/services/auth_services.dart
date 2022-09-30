import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:messenger/utils/constants.dart';

import '../screens/home_screen.dart';
import '../screens/verify_screen.dart';

class AuthServices {
  static void verifyPhoneNumber({required String phoneNumber}) async {
    try {
      EasyLoading.show(status: 'Verifying...'.tr);
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // auth.signInWithCredential(credential).then(
          //   (UserCredential result) {
          //     EasyLoading.dismiss();
          //     Get.offAll(
          //       () => HomeScreen(
          //         user: result.user,
          //       ),
          //     );
          //   },
          // ).catchError((e) {
          //   EasyLoading.dismiss();
          //   log(e.toString());
          // });
        },
        verificationFailed: (FirebaseAuthException e) {
          EasyLoading.dismiss();
          EasyLoading.showError(e.message ?? 'Verification failed.', duration: const Duration(seconds: 8));
        },
        codeSent: (String verificationId, int? resendToken) {
          EasyLoading.dismiss();
          Get.to(
            () => VerifyPhoneNumber(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
              forceResendingToken: resendToken,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
        },
      );
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
    }
  }
}
