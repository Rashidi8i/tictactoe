// ignore_for_file: non_constant_identifier_names, file_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/controllers/gameviewController/gameviewController.dart';
import 'package:tictactoe/controllers/roundrobinController/roundrobinController.dart';
import 'package:tictactoe/controllers/tournamentController/tournamentController.dart';
import 'package:tictactoe/res/colors/app_color.dart';
import 'package:tictactoe/res/constants/constants.dart';
import 'package:tictactoe/sql_dbHandler/db_handler.dart';
import 'package:tictactoe/views/gameModeView/gamemode.dart';
import 'package:tictactoe/views/tournamentmatches/tournamentMatches.dart';

class GameView extends StatefulWidget {
  const GameView(
      {Key? key,
      this.playerA = 'Player B',
      this.playerB = 'Player A',
      this.matchid = '',
      this.matchnum = 0,
      this.matchNum = 'Single Match',
      this.isTournament = false})
      : super(key: key);

  final String playerA, playerB, matchid;
  final bool isTournament;
  final int matchnum;
  final String matchNum;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final gameViewController = Get.put(GameViewController());
  final tournamentController = Get.put(TournamentMakerController());
  final robinController = Get.put(RoundRobinController());
  String winner = '';
  String winnerScore = '';
  DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Obx(() {
      return Stack(
        children: [
          Container(
            height: Constants.getHeight(context),
            width: Constants.getWidth(context),
            color: AppColor.greyColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PlayerABox(),
                    PlayerBBox(),
                  ],
                ),
                SizedBox(
                  height: Constants.getHeight(context) * 0.01,
                ),
                Text(widget.matchNum,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22)),
                SizedBox(
                  height: Constants.getHeight(context) * 0.1,
                ),
                Container(
                    height: 270,
                    width: 270,
                    color: AppColor.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                !gameViewController.r1c1_done.value
                                    ? gameViewController.make_turn('r1c1')
                                    : null;
                              },
                              child: GameBox(
                                  'r1c1',
                                  gameViewController.r1c1_win.value
                                      ? AppColor.pinkColor
                                      : AppColor.darkBlue),
                            ),
                            InkWell(
                              onTap: () {
                                !gameViewController.r1c2_done.value
                                    ? gameViewController.make_turn('r1c2')
                                    : null;
                              },
                              child: GameBox(
                                  'r1c2',
                                  gameViewController.r1c2_win.value
                                      ? AppColor.pinkColor
                                      : AppColor.darkBlue),
                            ),
                            InkWell(
                              onTap: () {
                                !gameViewController.r1c3_done.value
                                    ? gameViewController.make_turn('r1c3')
                                    : null;
                              },
                              child: GameBox(
                                  'r1c3',
                                  gameViewController.r1c3_win.value
                                      ? AppColor.pinkColor
                                      : AppColor.darkBlue),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                !gameViewController.r2c1_done.value
                                    ? gameViewController.make_turn('r2c1')
                                    : null;
                              },
                              child: GameBox(
                                  'r2c1',
                                  gameViewController.r2c1_win.value
                                      ? AppColor.pinkColor
                                      : AppColor.darkBlue),
                            ),
                            InkWell(
                              onTap: () {
                                !gameViewController.r2c2_done.value
                                    ? gameViewController.make_turn('r2c2')
                                    : null;
                              },
                              child: GameBox(
                                  'r2c2',
                                  gameViewController.r2c2_win.value
                                      ? AppColor.pinkColor
                                      : AppColor.darkBlue),
                            ),
                            InkWell(
                              onTap: () {
                                !gameViewController.r2c3_done.value
                                    ? gameViewController.make_turn('r2c3')
                                    : null;
                              },
                              child: GameBox(
                                  'r2c3',
                                  gameViewController.r2c3_win.value
                                      ? AppColor.pinkColor
                                      : AppColor.darkBlue),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                !gameViewController.r3c1_done.value
                                    ? gameViewController.make_turn('r3c1')
                                    : null;
                              },
                              child: GameBox(
                                  'r3c1',
                                  gameViewController.r3c1_win.value
                                      ? AppColor.pinkColor
                                      : AppColor.darkBlue),
                            ),
                            InkWell(
                              onTap: () {
                                !gameViewController.r3c2_done.value
                                    ? gameViewController.make_turn('r3c2')
                                    : null;
                              },
                              child: GameBox(
                                  'r3c2',
                                  gameViewController.r3c2_win.value
                                      ? AppColor.pinkColor
                                      : AppColor.darkBlue),
                            ),
                            InkWell(
                              onTap: () {
                                !gameViewController.r3c3_done.value
                                    ? gameViewController.make_turn('r3c3')
                                    : null;
                              },
                              child: GameBox(
                                  'r3c3',
                                  gameViewController.r3c3_win.value
                                      ? AppColor.pinkColor
                                      : AppColor.darkBlue),
                            )
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
          gameViewController.winner_decided.value
              ? winnerBox(context)
              : Container(),
          !gameViewController.gameStarted.value
              ? Padding(
                  padding:
                      EdgeInsets.only(top: Constants.getHeight(context) * 0.3),
                  child: start_game(),
                )
              : Container()
        ],
      );
    })));
  }

  InkWell start_game() {
    return InkWell(
      onTap: () {
        gameViewController.start_game();
      },
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.redColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: AppColor.blackColor.withOpacity(0.6)),
        child: const Center(
          child: Text(
            'Start',
            style: TextStyle(
                color: AppColor.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 45),
          ),
        ),
      ),
    );
  }

  Positioned winnerBox(BuildContext context) {
    return Positioned(
      top: Constants.getHeight(context) * 0.4,
      left: Constants.getWidth(context) * 0.03,
      child: Container(
        margin: EdgeInsets.only(top: Constants.getHeight(context) * 0.22),
        child: Column(
          children: [
            Container(
              height: Constants.getHeight(context) * 0.33,
              width: Constants.getWidth(context) * 0.95,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: AppColor.blackColor.withOpacity(1.0).withOpacity(0.3)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: Constants.getHeight(context) * 0.3,
                      width: Constants.getWidth(context) * 0.95,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: AppColor.whiteColor),
                      child: gameViewController.winner.value != 'Match Draw!'
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: AppColor.pinkColor,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ImageIcon(
                                          AssetImage(
                                              gameViewController.winner.value ==
                                                      'Player A winner'
                                                  ? 'Assets/icons/tick.png'
                                                  : 'Assets/icons/cross.png'),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: Text(
                                        gameViewController.winner.value ==
                                                'Player A winner'
                                            ? widget.playerA
                                            : widget.playerB,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Winner',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: AppColor.primaryTextColor),
                                ),
                                !widget.isTournament
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                gameViewController
                                                    .restart_game();
                                              },
                                              child: Image.asset(
                                                'Assets/icons/restart.png',
                                                height: 70,
                                              )),
                                          InkWell(
                                              onTap: () {
                                                Get.off(() => const GameMode(),
                                                    transition: Transition
                                                        .rightToLeftWithFade,
                                                    duration: const Duration(
                                                        milliseconds: 450));
                                              },
                                              child: Image.asset(
                                                'Assets/icons/home.png',
                                                height: 70,
                                              ))
                                        ],
                                      )
                                    : InkWell(
                                        onTap: () {
                                          nextMatch();
                                        },
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Image.asset(
                                              'Assets/icons/next.png',
                                              height: 70,
                                            ),
                                          ),
                                        ),
                                      )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                          child: Text(
                                            'Player A',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                          color: AppColor.greyColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                  'Time: ${gameViewController.player_A_Score.value}'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                          child: Text(
                                            'Player B',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                          color: AppColor.greyColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                  'Time: ${gameViewController.player_B_Score.value}'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Match is draw but from time taking',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                      color: AppColor.primaryTextColor),
                                ),
                                Text(
                                  gameViewController.player_A_Score.value >
                                          gameViewController
                                              .player_B_Score.value
                                      ? 'Winner => Player B'
                                      : 'Winner => Player A',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: AppColor.primaryTextColor),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          gameViewController.restart_game();
                                        },
                                        child: Image.asset(
                                          'Assets/icons/restart.png',
                                          height: 60,
                                        )),
                                    InkWell(
                                        onTap: () {
                                          if (widget.isTournament) {
                                            nextMatch();
                                          } else {
                                            Get.off(() => const GameMode(),
                                                transition: Transition
                                                    .rightToLeftWithFade,
                                                duration: const Duration(
                                                    milliseconds: 450));
                                          }

                                          gameViewController.restart_game();
                                        },
                                        child: Image.asset(
                                          widget.isTournament
                                              ? 'Assets/icons/next.png'
                                              : 'Assets/icons/home.png',
                                          height: 60,
                                        ))
                                  ],
                                )
                              ],
                            ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void nextMatch() {
    if (tournamentController.selectedType.value == 'Elimination') {
      tournamentController.playedMatches.value++;
      if (gameViewController.winner.value == 'Player A winner') {
        winner = widget.playerA;
        winnerScore = gameViewController.player_A_Score.value.toString();
        tournamentController.winnersList.add(widget.playerA);
      } else {
        winner = widget.playerB;
        winnerScore = gameViewController.player_A_Score.value.toString();
        tournamentController.winnersList.add(widget.playerB);
      }

      dbHelper.updateMatch(int.parse(widget.matchid), winner, 'true');
      gameViewController.restart_game();
      if (tournamentController.isfinal.value) {
        tournamentController.finalDone.value = true;
      }
      Get.off(() => TournamentMatches(t_id: tournamentController.this_t_id),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 450));
    } else {
      robinController.playedMatches.value++;
      if (gameViewController.winner.value == 'Player A winner') {
        winner = widget.playerA;

        robinController.winnersList.add(widget.playerA);
      } else {
        winner = widget.playerB;
        robinController.winnersList.add(widget.playerB);
      }

      dbHelper.updateRobinMatch(
          int.parse(widget.matchid), winner, winnerScore, 'true');
      gameViewController.restart_game();
      if (robinController.isfinal.value) {
        robinController.finalDone.value = true;
      }
      Get.off(() => TournamentMatches(t_id: robinController.this_t_id),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 450));
    }
  }

  Container GameBox(String box_name, Color color) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.darkBlue,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: color),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ImageIcon(
          AssetImage(gameViewController.player_A_list.contains(box_name)
              ? gameViewController.player_A_icon
              : gameViewController.player_B_list.contains(box_name)
                  ? gameViewController.player_B_icon
                  : gameViewController.nutral_icon),
          color: AppColor.greyColor,
        ),
      ),
    );
  }

  Container PlayerABox() {
    return Container(
      height: 80,
      width: 130,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.whiteColor,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: gameViewController.player_turn.value == 0
              ? AppColor.primaryColor
              : const Color.fromARGB(0, 251, 255, 0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const ImageIcon(
                AssetImage('Assets/icons/tick.png'),
                size: 30,
              ),
              SizedBox(
                  height: 30,
                  child: Center(
                      child: Text(
                    widget.playerA,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ))),
            ],
          ),
          Container(
              color: gameViewController.player_turn.value == 0
                  ? AppColor.primaryColor
                  : const Color.fromARGB(0, 251, 255, 0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<GameViewController>(
                  builder: (controller) =>
                      Text('Time: ${gameViewController.player_A_Score}'),
                ),
              ))
        ],
      ),
    );
  }

  Container PlayerBBox() {
    return Container(
      height: 80,
      width: 130,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.whiteColor,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: gameViewController.player_turn.value == 1
              ? AppColor.primaryColor
              : const Color.fromARGB(0, 251, 255, 0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const ImageIcon(
                AssetImage('Assets/icons/cross.png'),
                size: 30,
              ),
              SizedBox(
                height: 30,
                child: Center(
                  child: Text(
                    widget.playerB,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          Container(
              color: gameViewController.player_turn.value == 1
                  ? AppColor.primaryColor
                  : const Color.fromARGB(0, 251, 255, 0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<GameViewController>(
                  builder: (controller) =>
                      Text('Time: ${gameViewController.player_B_Score}'),
                ),
              ))
        ],
      ),
    );
  }
}
