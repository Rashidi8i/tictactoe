// ignore_for_file: non_constant_identifier_names, file_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/controllers/gameviewController/gameviewController.dart';
import 'package:tictactoe/controllers/tournamentController/tournamentController.dart';
import 'package:tictactoe/res/colors/app_color.dart';
import 'package:tictactoe/res/constants/constants.dart';
import 'package:tictactoe/sql_dbHandler/db_handler.dart';
import 'package:tictactoe/views/gameModeView/gamemode.dart';
import 'package:tictactoe/views/tournamentMaker/tournamentMaker.dart';
import 'package:tictactoe/views/tournamentmatches/tournamentMatches.dart';
import 'package:audioplayers/audioplayers.dart';

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
  String winner = '';
  String winnerScore = '';
  DBHelper dbHelper = DBHelper();
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: WillPopScope(
      onWillPop: () async {
        if (!gameViewController.gameStarted.value) {
          if (widget.isTournament) {
            Get.off(() => TournamentMatches(t_id: Constants.t_id),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 450));
          } else {
            Get.off(() => const GameMode(),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 450));
          }
          return true;
        } else {
          return false;
        }
      },
      child: Obx(() {
        return Stack(
          children: [
            Container(
              height: Constants.getHeight(context),
              width: Constants.getWidth(context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('Assets/icons/back_2.png'),
                      fit: BoxFit.fitHeight)),
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
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 1, 39, 37),
                            Color.fromARGB(255, 1, 116, 110)
                          ],
                        ),
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 141, 139, 139))),
                    child: Center(
                      child: Text(widget.matchNum,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: AppColor.whiteColor)),
                    ),
                  ),
                  SizedBox(
                    height: Constants.getHeight(context) * 0.1,
                  ),
                  Container(
                      height: 270,
                      width: 270,
                      // decoration: const BoxDecoration(
                      //     image: DecorationImage(
                      //         image: AssetImage('Assets/icons/back_2.png'),
                      //         fit: BoxFit.cover)),
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

                                  // player.play(AssetSource('audio/tapsound.mp3'));
                                },
                                child: GameBox(
                                    'r1c1',
                                    gameViewController.r1c1_win.value
                                        ? AppColor.darkgreyColor
                                        : AppColor.blackColor),
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
                                        ? AppColor.darkgreyColor
                                        : AppColor.blackColor),
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
                                        ? AppColor.darkgreyColor
                                        : AppColor.blackColor),
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
                                        ? AppColor.darkgreyColor
                                        : AppColor.blackColor),
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
                                        ? AppColor.darkgreyColor
                                        : AppColor.blackColor),
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
                                        ? AppColor.darkgreyColor
                                        : AppColor.blackColor),
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
                                        ? AppColor.darkgreyColor
                                        : AppColor.blackColor),
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
                                        ? AppColor.darkgreyColor
                                        : AppColor.blackColor),
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
                                        ? AppColor.darkgreyColor
                                        : AppColor.blackColor),
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
                ? Center(child: start_game())
                : Container()
          ],
        );
      }),
    )));
  }

  Container alertBox(BuildContext context) {
    return Container(
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
                  width: 2, color: const Color.fromARGB(255, 255, 255, 255))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Want to Quit match?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: AppColor.blackColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 255, 255, 255))),
                    child: InkWell(
                      onTap: () {
                        Get.off(() => TournamentMatches(
                              t_id: Constants.t_id,
                            ));
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
                            Color.fromARGB(255, 124, 124, 124),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 255, 255, 255))),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
    );
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
            border: Border.all(color: AppColor.greyColor, width: 2),
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

  Container winnerBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Constants.getHeight(context) * 0.62),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: Constants.getHeight(context) * 0.3,
              width: Constants.getWidth(context),
              decoration: AppColor.decoration,
              child: gameViewController.winner.value != 'Match Draw!'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 1, 39, 37),
                                      Color.fromARGB(255, 1, 116, 110)
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2,
                                      color: const Color.fromARGB(
                                          255, 141, 139, 139))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageIcon(
                                  AssetImage(gameViewController.winner.value ==
                                          'Player A winner'
                                      ? 'Assets/icons/tick.png'
                                      : 'Assets/icons/cross.png'),
                                  size: 30,
                                  color: AppColor.whiteColor,
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
                                    fontSize: 25,
                                    color: AppColor.whiteColor),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Winner',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: AppColor.whiteColor),
                        ),
                        !widget.isTournament
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      gameViewController.restart_game();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 1, 39, 37),
                                              Color.fromARGB(255, 1, 116, 110)
                                            ],
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2,
                                              color: const Color.fromARGB(
                                                  255, 141, 139, 139))),
                                      child: const ImageIcon(
                                        AssetImage('Assets/icons/restart.png'),
                                        size: 60,
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.off(() => const GameMode(),
                                          transition:
                                              Transition.rightToLeftWithFade,
                                          duration: const Duration(
                                              milliseconds: 450));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 1, 39, 37),
                                              Color.fromARGB(255, 1, 116, 110)
                                            ],
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2,
                                              color: const Color.fromARGB(
                                                  255, 141, 139, 139))),
                                      child: const ImageIcon(
                                        AssetImage('Assets/icons/home.png'),
                                        size: 60,
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  )
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 1, 39, 37),
                                              Color.fromARGB(255, 1, 116, 110)
                                            ],
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2,
                                              color: const Color.fromARGB(
                                                  255, 141, 139, 139))),
                                      child: const ImageIcon(
                                        AssetImage('Assets/icons/next.png'),
                                        size: 60,
                                        color: AppColor.whiteColor,
                                      ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Text(
                                    widget.isTournament
                                        ? widget.playerA
                                        : 'Player A',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColor.whiteColor),
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
                                SizedBox(
                                  height: 30,
                                  child: Text(
                                    widget.isTournament
                                        ? widget.playerB
                                        : 'Player B',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColor.whiteColor),
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
                              color: AppColor.whiteColor),
                        ),
                        Text(
                          widget.isTournament
                              ? gameViewController.player_A_Score.value >
                                      gameViewController.player_B_Score.value
                                  ? 'Winner => ${widget.playerB}'
                                  : 'Winner => ${widget.playerA}'
                              : gameViewController.player_A_Score.value >
                                      gameViewController.player_B_Score.value
                                  ? 'Winner => Player B'
                                  : 'Winner => Player A',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColor.whiteColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                gameViewController.restart_game();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 1, 39, 37),
                                        Color.fromARGB(255, 1, 116, 110)
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2,
                                        color: const Color.fromARGB(
                                            255, 141, 139, 139))),
                                child: const ImageIcon(
                                  AssetImage('Assets/icons/restart.png'),
                                  size: 60,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (widget.isTournament) {
                                  nextMatch();
                                } else {
                                  Get.off(() => const GameMode(),
                                      transition:
                                          Transition.rightToLeftWithFade,
                                      duration:
                                          const Duration(milliseconds: 450));
                                }

                                gameViewController.restart_game();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 1, 39, 37),
                                        Color.fromARGB(255, 1, 116, 110)
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2,
                                        color: const Color.fromARGB(
                                            255, 141, 139, 139))),
                                child: ImageIcon(
                                  AssetImage(widget.isTournament
                                      ? 'Assets/icons/next.png'
                                      : 'Assets/icons/home.png'),
                                  size: 60,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  void nextMatch() {
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
    Get.off(() => TournamentMatches(t_id: Constants.t_id),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 450));
  }

  Container GameBox(String box_name, Color color) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.greyColor,
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
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(
            width: 2,
            color: gameViewController.player_turn.value == 0
                ? const Color.fromARGB(255, 255, 251, 0)
                : const Color.fromARGB(255, 151, 151, 151)),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 1, 39, 37),
            Color.fromARGB(255, 1, 116, 110)
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const ImageIcon(
                AssetImage('Assets/icons/tick.png'),
                size: 30,
                color: AppColor.whiteColor,
              ),
              SizedBox(
                  height: 30,
                  child: Center(
                      child: Text(
                    widget.playerA,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColor.whiteColor),
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
                  builder: (controller) => Text(
                    'Time: ${gameViewController.player_A_Score}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColor.whiteColor),
                  ),
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
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(
            width: 2,
            color: gameViewController.player_turn.value == 1
                ? const Color.fromARGB(255, 255, 251, 0)
                : const Color.fromARGB(255, 151, 151, 151)),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 1, 39, 37),
            Color.fromARGB(255, 1, 116, 110)
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const ImageIcon(
                AssetImage('Assets/icons/cross.png'),
                size: 30,
                color: AppColor.whiteColor,
              ),
              SizedBox(
                height: 30,
                child: Center(
                  child: Text(
                    widget.playerB,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColor.whiteColor),
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
                  builder: (controller) => Text(
                    'Time: ${gameViewController.player_B_Score}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColor.whiteColor),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
