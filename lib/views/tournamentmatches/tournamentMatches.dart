// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/controllers/tournamentController/tournamentController.dart';
import 'package:tictactoe/models/tournmentmatchModel.dart';
import 'package:tictactoe/res/colors/app_color.dart';
import 'package:tictactoe/res/components/round_button.dart';
import 'package:tictactoe/res/constants/constants.dart';
import 'package:tictactoe/views/gameView/gameView.dart';
import 'package:tictactoe/views/tournamentMaker/tournamentMaker.dart';

class TournamentMatches extends StatefulWidget {
  final int t_id;
  const TournamentMatches({super.key, required this.t_id});

  @override
  State<TournamentMatches> createState() => _TournamentMatchesState();
}

class _TournamentMatchesState extends State<TournamentMatches> {
  final tournamentController = Get.put(TournamentMakerController());

  @override
  void initState() {
    super.initState();
    if (tournamentController.playedMatches.value == 6) {
      tournamentController.isfinal.value = true;
    } else {
      tournamentController.isfinal.value = false;
    }
    if (tournamentController.resultList.length ==
            tournamentController.playedMatches.value ||
        tournamentController.isfinal.value) {
      if (tournamentController.winnersList.length == 2) {
        fixFinal(tournamentController.winnersList);
      } else {
        for (int i = 0; i < tournamentController.winnersList.length; i += 2) {
          var playerlist =
              '${tournamentController.winnersList[i]},${tournamentController.winnersList[i + 1]}';

          tournamentController.insertournmentmatchData(playerlist);
        }
        tournamentController.winnersList.clear();
      }
    }
    tournamentController.loadMatchesData(widget.t_id);
  }

  void fixFinal(List winners) {
    var playerList = tournamentController.listTostring(winners);
    tournamentController.insertournmentmatchData(playerList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.blackColor,
          title: const Text('Matches'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                tournamentController.quitTournament.value = true;
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Get.off(() => const TournamentMaker(),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 450));
            return true;
          },
          child: Container(
            height: Constants.getHeight(context),
            width: Constants.getWidth(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Assets/icons/back_2.png'),
                    fit: BoxFit.fitHeight)),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FutureBuilder<List<TournmentMatchModel>>(
                          future: tournamentController.tournamentMatchesdata,
                          builder: ((context,
                              AsyncSnapshot<List<TournmentMatchModel>>
                                  snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            tournamentController
                                                .matchNum(index + 1),
                                            style: const TextStyle(
                                                color: AppColor.whiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22)),
                                        Container(
                                          height: Constants.getHeight(context) *
                                              0.15,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'Assets/icons/button.png'),
                                                  fit: BoxFit.fitHeight)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(
                                                                255, 1, 39, 37),
                                                            Color.fromARGB(255,
                                                                1, 116, 110)
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                141,
                                                                139,
                                                                139))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: Center(
                                                        child: Text(
                                                            snapshot
                                                                .data![index]
                                                                .playerList!
                                                                .split(',')[0],
                                                            style: const TextStyle(
                                                                color: AppColor
                                                                    .whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 22)),
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    child: Center(
                                                      child: Text('VS',
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 22)),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(
                                                                255, 1, 39, 37),
                                                            Color.fromARGB(255,
                                                                1, 116, 110)
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                141,
                                                                139,
                                                                139))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: Center(
                                                        child: Text(
                                                            snapshot
                                                                .data![index]
                                                                .playerList!
                                                                .split(',')[1],
                                                            style: const TextStyle(
                                                                color: AppColor
                                                                    .whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 22)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Obx(() {
                                                return tournamentController
                                                                .playedMatches
                                                                .value ==
                                                            index &&
                                                        snapshot.data![index]
                                                                .matchPlayed ==
                                                            'false' &&
                                                        snapshot.data![index].winner ==
                                                            'none'
                                                    ? InkWell(
                                                        onTap: () {
                                                          tournamentController
                                                              .tournamentStarted
                                                              .value = true;
                                                          Get.to(
                                                              () => GameView(
                                                                  matchNum: tournamentController
                                                                      .matchNum(
                                                                          index +
                                                                              1),
                                                                  matchid: snapshot
                                                                      .data![
                                                                          index]
                                                                      .m_id
                                                                      .toString(),
                                                                  matchnum:
                                                                      index,
                                                                  playerA:
                                                                      snapshot.data![index].playerList!
                                                                              .split(',')[
                                                                          0],
                                                                  playerB: snapshot
                                                                      .data![index]
                                                                      .playerList!
                                                                      .split(',')[1],
                                                                  isTournament: true),
                                                              transition: Transition.rightToLeftWithFade,
                                                              duration: const Duration(milliseconds: 450));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 150,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'Assets/icons/button.png'),
                                                                  fit: BoxFit
                                                                      .fitHeight)),
                                                          child: const Center(
                                                            child: Text('Play',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .whiteColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18)),
                                                          ),
                                                        ),
                                                      )
                                                    : snapshot.data![index].matchPlayed ==
                                                                'true' &&
                                                            snapshot.data![index].winner !=
                                                                'none'
                                                        ? Text('Winner: ${snapshot.data![index].winner}'.toString(),
                                                            style: const TextStyle(
                                                                color: AppColor
                                                                    .whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18))
                                                        : const Text('Waiting...',
                                                            style: TextStyle(
                                                                color: AppColor
                                                                    .whiteColor,
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
                      tournamentController.finalDone.value
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RoundButton(
                                  width: double.infinity,
                                  title: 'Finish',
                                  onPress: () {
                                    tournamentController.winnersList.clear();
                                    tournamentController.finalDone.value =
                                        false;
                                    tournamentController.isfinal.value = false;
                                    Get.to(() => const TournamentMaker(),
                                        transition:
                                            Transition.rightToLeftWithFade,
                                        duration:
                                            const Duration(milliseconds: 450));
                                  }),
                            )
                          : Container()
                    ],
                  ),
                ),
                Obx(() {
                  return tournamentController.quitTournament.value
                      ? Container(
                          height: Constants.getHeight(context),
                          width: Constants.getWidth(context),
                          color: const Color.fromARGB(106, 255, 0, 0),
                          child: Center(
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 250, 0, 0),
                                      Color.fromARGB(255, 250, 114, 114),
                                      Color.fromARGB(255, 250, 0, 0),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 2,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Want to Quit tournament?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: AppColor.blackColor),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color.fromARGB(255, 250, 0, 0),
                                                Color.fromARGB(255, 0, 0, 0),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                width: 2,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255))),
                                        child: InkWell(
                                          onTap: () {
                                            tournamentController
                                                .deleteTournment();
                                            tournamentController.winnersList
                                                .clear();
                                            tournamentController
                                                .quitTournament.value = false;
                                            Get.to(
                                                () => const TournamentMaker());
                                          },
                                          child: const Center(
                                            child: Text('Yes',
                                                style: TextStyle(
                                                    color: AppColor.whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color.fromARGB(255, 0, 0, 0),
                                                Color.fromARGB(
                                                    255, 124, 124, 124),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                width: 2,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255))),
                                        child: InkWell(
                                          onTap: () {
                                            tournamentController
                                                .quitTournament.value = false;
                                          },
                                          child: const Center(
                                            child: Text('No',
                                                style: TextStyle(
                                                    color: AppColor.whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25)),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
