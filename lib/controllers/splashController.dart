import 'dart:async';

import 'package:get/get.dart';
import 'package:tictactoe/views/gameModeView/gamemode.dart';

class SplashController extends GetxController {
  RxDouble iconSize = 160.0.obs;
  void increaseSize() {
    Timer.periodic(const Duration(milliseconds: 25), (Timer timer) {
      iconSize.value++;
      if (iconSize >= 400.0) {
        timer.cancel();
        Get.off(() => const GameMode(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(
                milliseconds:
                    450)); // Stop the timer when the desired size is reached
      }
    });
  }
}
