// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/controllers/roundrobinController/roundrobinController.dart';
import 'package:tictactoe/controllers/tournamentController/tournamentController.dart';
import 'package:tictactoe/models/robintournmentMatch.dart';
import 'package:tictactoe/models/tournmentmatchModel.dart';
import 'package:tictactoe/res/colors/app_color.dart';
import 'package:tictactoe/res/components/round_button.dart';
import 'package:tictactoe/res/constants/constants.dart';
import 'package:tictactoe/views/gameView/gameView.dart';
import 'package:tictactoe/views/tournamentMaker/tournamentMaker.dart';

class RobinMatchesView extends StatefulWidget {
  final int t_id;
  const RobinMatchesView({super.key, required this.t_id});

  @override
  State<RobinMatchesView> createState() => _TournamentMatchesState();
}

class _TournamentMatchesState extends State<RobinMatchesView> {
  final tournamentController = Get.put(TournamentMakerController());
  final robinController = Get.put(RoundRobinController());

  @override
  void initState() {
    super.initState();
    // if (robinController.playedMatches.value == 6) {
    //   robinController.isfinal.value = true;
    // } else {
    //   robinController.isfinal.value = false;
    // }
    // if (robinController.resultList.length ==
    //     robinController.playedMatches.value) {
    //   if (tournamentController.winnersList.length == 2) {
    //     fixFinal(tournamentController.winnersList);
    //   } else {
    //     for (int i = 0; i < tournamentController.winnersList.length; i += 2) {
    //       var playerlist =
    //           '${tournamentController.winnersList[i]},${tournamentController.winnersList[i + 1]}';

    //       robinController.insertournmentmatchData(playerlist);
    //     }
    //     tournamentController.winnersList.clear();
    //   }
    // }
    robinController.loadMatchesData();
  }

  void fixFinal(List winners) {
    var playerList = tournamentController.listTostring(winners);
    robinController.insertournmentmatchData(playerList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Matches'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                // databaseRef.remove();
                if (!robinController.tournamentStarted.value) {
                  robinController.deleteTournment();
                  robinController.winnersList.clear();
                }
                Get.off(() => const TournamentMaker());
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        backgroundColor: AppColor.darkBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FutureBuilder<List<RobinTournmentMatchModel>>(
                  future: robinController.robintournamentMatchesdata,
                  builder: ((context,
                      AsyncSnapshot<List<RobinTournmentMatchModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(robinController.matchNum(index + 1),
                                    style: const TextStyle(
                                        color: AppColor.whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22)),
                                Container(
                                  height: Constants.getHeight(context) * 0.15,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColor.whiteColor,
                                        width: 2.0,
                                      ),
                                      color: AppColor.blue,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColor.whiteColor,
                                                  width: 2.0,
                                                ),
                                                color: AppColor.pinkColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Center(
                                                child: Text(
                                                    snapshot.data![index]
                                                        .playerList!
                                                        .split(',')[0],
                                                    style: const TextStyle(
                                                        color:
                                                            AppColor.whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22)),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Center(
                                              child: Text('VS',
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22)),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColor.whiteColor,
                                                  width: 2.0,
                                                ),
                                                color: AppColor.pinkColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Center(
                                                child: Text(
                                                    snapshot.data![index]
                                                        .playerList!
                                                        .split(',')[1],
                                                    style: const TextStyle(
                                                        color:
                                                            AppColor.whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Obx(() {
                                        return robinController
                                                        .playedMatches.value ==
                                                    index &&
                                                snapshot.data![index]
                                                        .matchPlayed ==
                                                    'false' &&
                                                snapshot.data![index].winner ==
                                                    'none'
                                            ? InkWell(
                                                onTap: () {
                                                  robinController
                                                      .tournamentStarted
                                                      .value = true;
                                                  Get.off(
                                                      () => GameView(
                                                          matchNum:
                                                              robinController.matchNum(
                                                                  index + 1),
                                                          matchid: snapshot
                                                              .data![index].m_id
                                                              .toString(),
                                                          matchnum: index,
                                                          playerA: snapshot
                                                              .data![index]
                                                              .playerList!
                                                              .split(',')[0],
                                                          playerB: snapshot
                                                              .data![index]
                                                              .playerList!
                                                              .split(',')[1],
                                                          isTournament: true),
                                                      transition: Transition
                                                          .rightToLeftWithFade,
                                                      duration: const Duration(
                                                          milliseconds: 450));
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            AppColor.redColor,
                                                        width: 2.0,
                                                      ),
                                                      color:
                                                          AppColor.greenColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  22))),
                                                  child: const Center(
                                                    child: Text('Play',
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .whiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18)),
                                                  ),
                                                ),
                                              )
                                            : snapshot.data![index]
                                                            .matchPlayed ==
                                                        'true' &&
                                                    snapshot.data![index]
                                                            .winner !=
                                                        'none'
                                                ? Text(
                                                    'Winner: ${snapshot.data![index].winner}'
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            AppColor.whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18))
                                                : const Text('Waiting...',
                                                    style: TextStyle(
                                                        color:
                                                            AppColor.whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18));
                                      })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
              ),
              robinController.finalDone.value
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundButton(
                          width: double.infinity,
                          title: 'Finish',
                          onPress: () {
                            robinController.winnersList.clear();
                            robinController.finalDone.value = false;
                            robinController.isfinal.value = false;
                            Get.off(() => const TournamentMaker(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 450));
                          }),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
