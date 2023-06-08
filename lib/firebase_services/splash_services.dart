import 'dart:async';
import 'package:tictactoe/views/gameModeView/gamemode.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GameMode())));
  }
}
