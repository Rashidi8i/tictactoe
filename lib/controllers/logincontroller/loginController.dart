// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/utils/utils.dart';
import 'package:tictactoe/views/gameModeView/gamemode.dart';
// import 'package:sasti_pk/utils/utils.dart';

class LoginController extends GetxController {
  final _auth = FirebaseAuth.instance;
  RxBool loading = false.obs;
  RxBool isPasswordHide = true.obs;
  final usernameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final usernameFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  void login() {
    loading.value = true;
    _auth
        .signInWithEmailAndPassword(
            email: usernameController.value.text.toString(),
            password: passwordController.value.text.toString())
        .then((value) {
      Utils.toastMessage(value.user!.email.toString());
      usernameController.value.clear();
      passwordController.value.clear();
      Get.to(() => const GameMode(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 450));

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
