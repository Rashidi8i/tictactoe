// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/utils/utils.dart';
import 'package:tictactoe/views/verificationsview/verificationView.dart';

class SignupController extends GetxController {
  final _auth = FirebaseAuth.instance;
  RxBool loading = false.obs;
  RxBool isPasswordHide = true.obs;
  final usernameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final usernameFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  Future<void> sendEmailVerification() async {
    User user = FirebaseAuth.instance.currentUser!;
    if (user != null) {
      await user.sendEmailVerification().then((value) async {
        Utils.toastMessage('Mail sent successfully!');
        Get.to(() => const EmailVerificationScreen(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 450));
      }).onError((error, stackTrace) {
        Utils.toastMessage(error!.toString());

        loading.value = false;
      }).catchError((error) {
        Utils.toastMessage(error!.toString());

        loading.value = false;
      });
    }
  }

  void signup() {
    loading.value = true;
    _auth
        .createUserWithEmailAndPassword(
            email: usernameController.value.text.toString(),
            password: passwordController.value.text.toString())
        .then((value) async {
      usernameController.value.clear();
      passwordController.value.clear();
      Utils.toastMessage('User register successfully!');

      sendEmailVerification();
      loading.value = false;
    }).onError((error, stackTrace) {
      Utils.toastMessage(error!.toString());

      loading.value = false;
    }).catchError((error) {
      Utils.toastMessage(error!.toString());

      loading.value = false;
    });
  }
}
