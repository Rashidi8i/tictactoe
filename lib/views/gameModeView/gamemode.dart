import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/res/colors/app_color.dart';
import 'package:tictactoe/views/gameView/gameView.dart';
import 'package:tictactoe/views/tournamentMaker/tournamentMaker.dart';

import '../../res/constants/constants.dart';

class GameMode extends StatefulWidget {
  const GameMode({super.key});

  @override
  State<GameMode> createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiQmcqzN9KSMx-hxPJfiB3yt59uQhN9R4IqjisfUEitJv9lbQVN14QYLsUfmgiH-AoH2VgTFMdRBaTWa9XXpU9aMV1fveYnRgRsf4peaqt_rCR_qyQ483NgjHHdhfYpOr8axyGWhk3DHw5lAUQkXl6NGMugPS7k6Apw7CUjqRMgwAv01i2_AXyRumuBfw/w680/blank-profile-picture-hd-images-photo.JPG'),
        ),
        automaticallyImplyLeading: false,
        title: const Text('Select Game mode'),
      ),
      body: Container(
        height: Constants.getHeight(context),
        width: Constants.getWidth(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/icons/back_1.jpg'),
                fit: BoxFit.fitHeight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            modeBox(context, 'Single Match', () {
              Get.to(() => const GameView(),
                  transition: Transition.rightToLeftWithFade,
                  duration: const Duration(milliseconds: 450));
            }),
            const SizedBox(
              height: 20,
            ),
            modeBox(context, 'Tournament', () {
              // showMyDialog();
              Get.to(() => const TournamentMaker(),
                  transition: Transition.rightToLeftWithFade,
                  duration: const Duration(milliseconds: 450));
            }),
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Tournament Name'),
            content: SizedBox(
              height: 100,
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(color: AppColor.greyColor),
                    hintText: 'Tournament name'),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    // databaseRef.child(id).set(
                    //     {'title': nameController.text, 'id': id}).then((value) {
                    //   Utils.toastMessage('Tournament Added!');
                    //   Get.to(() => const TournamentMaker(),
                    //       transition: Transition.rightToLeftWithFade,
                    //       duration: const Duration(milliseconds: 450));
                    // }).onError((error, stackTrace) {
                    //   Utils.toastMessage(error!.toString());
                    // }).catchError((error) {
                    //   Utils.toastMessage(error!.toString());
                    // });
                    // Navigator.pop(context);
                  },
                  child: const Text('Add')),
            ],
          );
        });
  }

  InkWell modeBox(BuildContext context, String title, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Center(
        child: Container(
          height: Constants.getHeight(context) * 0.1,
          width: Constants.getWidth(context) * 0.9,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: AppColor.blue,
              border: Border.all(color: AppColor.pinkColor)),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
