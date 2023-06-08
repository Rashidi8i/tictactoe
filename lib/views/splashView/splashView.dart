// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tictactoe/firebase_services/splash_services.dart';
import 'package:tictactoe/res/colors/app_color.dart';

// import 'package:tictactoe/views/login_view/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Game Arena',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryTextColor),
            ),
            Text(
              'Let\'s compete together!',
              style:
                  TextStyle(fontSize: 20, color: AppColor.secondaryTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
