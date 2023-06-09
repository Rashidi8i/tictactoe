// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tictactoe/controllers/tournamentController/tournamentController.dart';
import 'package:tictactoe/models/robintournmentMatch.dart';
import 'package:tictactoe/models/tournmentModel.dart';
import 'package:tictactoe/sql_dbHandler/db_handler.dart';
import 'package:tictactoe/utils/utils.dart';
import 'package:tictactoe/views/roundrobinMatches/roundRobinView.dart';

class RoundRobinController extends GetxController {
  final tournamentController = Get.put(TournamentMakerController());

  RxBool loading = false.obs;
  RxBool finalDone = false.obs;
  RxBool generateTournament = false.obs;

  RxBool isfinal = false.obs;
  RxInt playedMatches = 0.obs;
  RxBool tournamentStarted = false.obs;
  int this_t_id = 0;
  DBHelper? dbHelper = DBHelper();
  final List<String> playersName = [];
  List<dynamic> resultList = [];
  List<dynamic> winnersList = [];

  late Future<List<TournmentModel>> tournamentFuture;
  late List<TournmentModel> latestTournmentData;
  late Future<List<RobinTournmentMatchModel>> robintournamentMatchesdata;

  Future<void> getTdata() async {
    tournamentFuture = dbHelper!.getLastTrnmnt();
    latestTournmentData = await tournamentFuture;
    for (int i = 0; i < resultList.length; i++) {
      // insertournmentmatchData(resultList[0].toString());
      if (kDebugMode) {
        print(resultList[i].toString().replaceAll(RegExp(r'[\[\]]'), ''));
      }
      insertournmentmatchData(
          resultList[i].toString().replaceAll(RegExp(r'[\[\]]'), ''));
    }
    dbHelper!.getTournmentData();
    if (kDebugMode) {
      print(latestTournmentData.first);
    }
  }

  void insertournmentData() {
    dbHelper!
        .insert_tournment(TournmentModel(
            playerList: playersName.toString(),
            playerCount:
                int.parse(tournamentController.selectedPlayersCount.value),
            tournamentType: tournamentController.selectedType.value))
        .then((value) {
      if (kDebugMode) {
        print("Tournment added");
      }
      Utils.toastMessage('Tournment Added');
      playersName.clear();

      getTdata();

      Get.to(() => RobinMatchesView(t_id: this_t_id),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 450));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }).catchError((error) {
      Utils.toastMessage(error!.toString());
    });
  }

  void insertournmentmatchData(String playerList) {
    TournmentModel data = latestTournmentData.first;
    this_t_id = data.t_id!;
    dbHelper!
        .insert_robin_tournment_match(RobinTournmentMatchModel(
      matchPlayed: 'false',
      playerList: playerList,
      tournment_id: data.t_id,
      winnerScore: '0',
      winner: 'none',
    ))
        .then((value) {
      if (kDebugMode) {
        print("matches fixed");
      }
      Utils.toastMessage('Matches fixed');
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    }).catchError((error) {
      Utils.toastMessage(error!.toString());
    });
  }

  void loadMatchesData() {
    robintournamentMatchesdata = dbHelper!.getRobinMatchesData(this_t_id);
  }

  List<dynamic> robinTournment(List<String> teamList) {
    for (int i = 0; i < teamList.length - 1; i++) {
      for (int j = i + 1; j < teamList.length; j++) {
        resultList.add([teamList[i], teamList[j]]);
      }
    }

    // Shuffle the result list
    resultList.shuffle(Random());
    if (kDebugMode) {
      print(resultList);
    }
    return resultList;
  }

  String matchNum(int matchNum) {
    if (matchNum < resultList.length + 1) {
      return 'Match #$matchNum';
    } else {
      return 'final';
    }
    // if (resultList.length == 2) {
    //   if (matchNum <= resultList.length) {
    //     return 'Match #$matchNum';
    //   } else {
    //     isfinal.value = true;
    //     return 'Final';
    //   }
    // } else if (resultList.length == 4) {
    //   if (matchNum <= resultList.length) {
    //     return 'Match #$matchNum';
    //   } else if (matchNum == 5 || matchNum == 6) {
    //     return 'Semi-Final';
    //   } else {
    //     return 'Final';
    //   }
    // } else {
    //   return 'error';
    // }
  }
}
