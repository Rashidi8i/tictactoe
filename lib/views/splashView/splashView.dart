// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/controllers/splashController.dart';
import 'package:tictactoe/res/colors/app_color.dart';
import 'package:tictactoe/res/constants/constants.dart';

// import 'package:tictactoe/views/login_view/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    splashController.increaseSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Constants.getHeight(context),
        width: Constants.getWidth(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/icons/back_2.png'),
                fit: BoxFit.fitHeight)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Center(
                  child: Stack(
                    children: [
                      ImageIcon(
                        const AssetImage('Assets/icons/wolf.png'),
                        size: splashController.iconSize.value,
                        // color: AppColor.greyColor,
                      ),
                      splashController.iconSize.value > 243 &&
                              splashController.iconSize.value < 250
                          ? ImageIcon(
                              const AssetImage('Assets/icons/wolf.png'),
                              size: splashController.iconSize.value,
                              color: AppColor.redColor,
                            )
                          : const SizedBox(),
                    ],
                  ),
                );
              }),
              const Text(
                'Game Arena',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteColor),
              ),
              const Text(
                'Let\'s compete together!',
                style: TextStyle(fontSize: 20, color: AppColor.greyColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
