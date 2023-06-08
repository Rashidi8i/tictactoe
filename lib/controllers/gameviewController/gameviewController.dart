// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GameViewController extends GetxController {
  RxInt player_turn = 0.obs;
  RxList player_A_list = [].obs;
  RxList player_B_list = [].obs;
  RxBool r1c1_done = false.obs;
  RxBool r1c2_done = false.obs;
  RxBool r1c3_done = false.obs;
  RxBool r2c1_done = false.obs;
  RxBool r2c2_done = false.obs;
  RxBool r2c3_done = false.obs;
  RxBool r3c1_done = false.obs;
  RxBool r3c2_done = false.obs;
  RxBool r3c3_done = false.obs;
  RxBool r1c1_win = false.obs;
  RxBool r1c2_win = false.obs;
  RxBool r1c3_win = false.obs;
  RxBool r2c1_win = false.obs;
  RxBool r2c2_win = false.obs;
  RxBool r2c3_win = false.obs;
  RxBool r3c1_win = false.obs;
  RxBool r3c2_win = false.obs;
  RxBool r3c3_win = false.obs;
  RxBool winner_decided = false.obs;
  RxInt turnCount = 0.obs;
  RxString winner = ''.obs;
  RxInt player_A_Score = 0.obs;
  RxInt player_B_Score = 0.obs;
  RxBool gameStarted = false.obs;
  RxBool isFirstTurn = true.obs;
  String winnerTournment = '';

  final String player_A_icon = 'Assets/icons/tick.png';
  final String player_B_icon = 'Assets/icons/cross.png';
  final String nutral_icon = 'Assets/icons/circle.png';
  void start_game() {
    player_A_Score.value = 0;
    player_B_Score.value = 0;
    gameStarted.value = true;
    if (player_turn.value == 0) {
      calculate_A_score(false);
    } else {
      calculate_B_score(false);
    }
  }

  void get_initial_turn() {
    gameStarted.value = false;
    int randomNum = Random().nextInt(2);
    player_turn.value = randomNum;
  }

  void make_turn(String box_name) {
    if (gameStarted.value) {
      if (!winner_decided.value) {
        if (player_turn.value == 0) {
          calculate_B_score(false);
          turnCount.value++;
          disable_box(box_name);
          player_A_list.add(box_name);
          winner.value = get_winner();

          player_turn.value = 1;
        } else {
          calculate_A_score(false);
          turnCount.value++;
          disable_box(box_name);
          player_B_list.add(box_name);
          winner.value = get_winner();
          player_turn.value = 0;
        }
      }
    }
  }

  void disable_box(String box_name) {
    if (box_name == 'r1c1') {
      r1c1_done.value = true;
    } else if (box_name == 'r1c2') {
      r1c2_done.value = true;
    } else if (box_name == 'r1c3') {
      r1c3_done.value = true;
    } else if (box_name == 'r2c1') {
      r2c1_done.value = true;
    } else if (box_name == 'r2c2') {
      r2c2_done.value = true;
    } else if (box_name == 'r2c3') {
      r2c3_done.value = true;
    } else if (box_name == 'r3c1') {
      r3c1_done.value = true;
    } else if (box_name == 'r3c2') {
      r3c2_done.value = true;
    } else if (box_name == 'r3c3') {
      r3c3_done.value = true;
    }
  }

  void calculate_A_score(bool stop) {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (player_turn.value == 1 || stop || winner_decided.value) {
        if (kDebugMode) {
          print('stop');
        }
        timer.cancel();
      } else {
        player_A_Score.value += 10;
        update();
        if (kDebugMode) {
          print('A score ${player_A_Score.value}');
        }
      }
    });
  }

  void calculate_B_score(bool stop) {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (player_turn.value == 0 || stop || winner_decided.value) {
        if (kDebugMode) {
          print('stop');
        }

        timer.cancel();
      } else {
        player_B_Score.value += 10;
        update();
        if (kDebugMode) {
          print('B score ${player_B_Score.value}');
        }
      }
    });
  }

  String get_winner() {
    if (!winner_decided.value) {
      winner.value = find_winner(player_A_list, 'Player A winner');
      if (winner_decided.value) {
        return winner.value;
      }
    }
    if (!winner_decided.value) {
      winner.value = find_winner(player_B_list, 'Player B winner');
      if (winner_decided.value) {
        return winner.value;
      }
    }
    if (turnCount.value > 8 && !winner_decided.value) {
      winner_decided.value = true;
      winner.value = 'Match Draw!';
      return winner.value;
    }
    return winner.value;
  }

  String find_winner(RxList<dynamic> list, String winner_name) {
    if (list.contains('r1c1') &&
        list.contains('r1c2') &&
        list.contains('r1c3')) {
      r1c1_win.value = true;
      r1c2_win.value = true;
      r1c3_win.value = true;

      winner_decided.value = true;
      return winner_name;
    } else if (list.contains('r2c1') &&
        list.contains('r2c2') &&
        list.contains('r2c3')) {
      r2c1_win.value = true;
      r2c2_win.value = true;
      r2c3_win.value = true;
      winner_decided.value = true;
      return winner_name;
    } else if (list.contains('r3c1') &&
        list.contains('r3c2') &&
        list.contains('r3c3')) {
      r3c1_win.value = true;
      r3c2_win.value = true;
      r3c3_win.value = true;
      winner_decided.value = true;
      return winner_name;
    }

    if (list.contains('r1c1') &&
        list.contains('r2c1') &&
        list.contains('r3c1')) {
      r1c1_win.value = true;
      r2c1_win.value = true;
      r3c1_win.value = true;
      winner_decided.value = true;
      return winner_name;
    } else if (list.contains('r1c2') &&
        list.contains('r2c2') &&
        list.contains('r3c2')) {
      r1c2_win.value = true;
      r2c2_win.value = true;
      r3c2_win.value = true;
      winner_decided.value = true;
      return winner_name;
    } else if (list.contains('r1c3') &&
        list.contains('r2c3') &&
        list.contains('r3c3')) {
      r1c3_win.value = true;
      r2c3_win.value = true;
      r3c3_win.value = true;
      winner_decided.value = true;
      return winner_name;
    }

    if (list.contains('r1c1') &&
        list.contains('r2c2') &&
        list.contains('r3c3')) {
      r1c1_win.value = true;
      r2c2_win.value = true;
      r3c3_win.value = true;
      winner_decided.value = true;
      return winner_name;
    } else if (list.contains('r1c3') &&
        list.contains('r2c2') &&
        list.contains('r3c1')) {
      r1c3_win.value = true;
      r2c2_win.value = true;
      r3c1_win.value = true;
      winner_decided.value = true;
      return winner_name;
    }
    return 'match draw!';
  }

  void restart_game() {
    turnCount.value = 0;
    player_A_list.clear();
    player_B_list.clear();
    winner_decided.value = false;
    r1c1_done.value = false;
    r1c2_done.value = false;
    r1c3_done.value = false;
    r2c1_done.value = false;
    r2c2_done.value = false;
    r2c3_done.value = false;
    r3c1_done.value = false;
    r3c2_done.value = false;
    r3c3_done.value = false;
    r1c1_win.value = false;
    r1c2_win.value = false;
    r1c3_win.value = false;
    r2c1_win.value = false;
    r2c2_win.value = false;
    r2c3_win.value = false;
    r3c1_win.value = false;
    r3c2_win.value = false;
    r3c3_win.value = false;
    winner.value = '';
    calculate_A_score(true);
    calculate_B_score(true);
    player_A_Score.value = 0;
    player_B_Score.value = 0;
    get_initial_turn();
  }
}
