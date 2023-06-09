// ignore_for_file: file_names, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tictactoe/models/tournmentModel.dart';
import 'package:tictactoe/models/tournmentmatchModel.dart';
import 'package:tictactoe/sql_dbHandler/db_handler.dart';
import 'package:tictactoe/utils/utils.dart';
import 'package:tictactoe/views/roundrobinMatches/roundRobinView.dart';

class TournamentMakerController extends GetxController {
  RxString selectedPlayersCount = '4'.obs;
  RxString selectedType = 'Elimination'.obs;
  RxBool generateTournament = false.obs;
  RxBool loading = false.obs;
  RxBool finalDone = false.obs;
  RxBool isfinal = false.obs;
  RxInt playedMatches = 0.obs;
  RxBool tournamentStarted = false.obs;
  DBHelper? dbHelper = DBHelper();
  late Future<List<TournmentModel>> tournamentFuture;
  Future<List<TournmentMatchModel>>? tournamentMatchesdata;
  late List<TournmentModel> latestTournmentData;
  List<String> playerList = [];
  int this_t_id = 0;
  List<dynamic> winnersList = [];
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
    // dbHelper!.getTournmentData();
    if (kDebugMode) {
      print(latestTournmentData.first);
    }
  }

  final List<String> playerCountList = [
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  final List<String> eliminationTournamentList = ['4', '8'];
  final List<String> tournamentType = ['Elimination', 'Round Robin'];
  final List<String> playersName = [];
  List<dynamic> resultList = [];

  List<String> strinTolist(String playerListString) {
    playerListString =
        playerListString.substring(1, playerListString.length - 1);
// Split the string by commas and remove any leading or trailing spaces
    List<String> playerList =
        playerListString.split(',').map((e) => e.trim()).toList();

    return playerList;
  }

  String listTostring(List<dynamic> list) {
    String str = '';
    for (int i = 0; i < list.length; i++) {
      if (i < list.length - 1) {
        str += '${list[i]},';
      } else {
        str += '${list[i]}';
      }
    }
    return str;
  }

  String matchNum(int matchNum) {
    if (resultList.length == 2) {
      if (matchNum <= resultList.length) {
        return 'Match #$matchNum';
      } else {
        isfinal.value = true;
        return 'Final';
      }
    } else if (resultList.length == 4) {
      if (matchNum <= resultList.length) {
        return 'Match #$matchNum';
      } else if (matchNum == 5 || matchNum == 6) {
        return 'Semi-Final';
      } else {
        return 'Final';
      }
    } else {
      return 'error';
    }
  }

  void insertournmentData() {
    dbHelper!
        .insert_tournment(TournmentModel(
            playerList: playersName.toString(),
            playerCount: int.parse(selectedPlayersCount.value),
            tournamentType: selectedType.value))
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
        .insert_tournment_match(TournmentMatchModel(
      matchPlayed: 'false',
      playerList: playerList,
      tournment_id: data.t_id,
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

  void deleteTournment() {
    dbHelper!.delete(0).then((value) {
      Utils.toastMessage('Deleted tournment');
    });
  }

  void loadMatchesData() {
    tournamentMatchesdata = dbHelper!.getMatchesData(this_t_id);
  }

  List<dynamic> eliminationTournament(List<dynamic> inputList) {
    resultList.clear();
    List<dynamic> unpairedList = [];

    inputList.shuffle();

    int iterations =
        inputList.length ~/ 2; // Calculate the number of iterations

    for (var i = 0; i < iterations * 2; i += 2) {
      resultList.add([inputList[i], inputList[i + 1]]);
    }
    if (kDebugMode) {
      print(resultList);
    }
    return resultList.isNotEmpty ? resultList : unpairedList;
  }
}
