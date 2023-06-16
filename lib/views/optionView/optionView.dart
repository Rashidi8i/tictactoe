import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/controllers/optionController/optionController.dart';
import 'package:tictactoe/res/colors/app_color.dart';
import 'package:tictactoe/views/gameModeView/gamemode.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/constants/constants.dart';

class OptionView extends StatefulWidget {
  const OptionView({super.key});

  @override
  State<OptionView> createState() => _OptionViewState();
}

class _OptionViewState extends State<OptionView> {
  final optionController = Get.put(OptionController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            Get.off(() => const GameMode(),
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
                      modeBox(context, 'Help', () {
                        optionController.showHelp.value = true;
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      modeBox(context, 'Contact Us', () {
                        // showMyDialog();
                        optionController.showAboutus.value = true;
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      modeBox(context, 'Back', () {
                        // showMyDialog();
                        Get.off(() => const GameMode(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 450));
                      }),
                    ],
                  ),
                ),
                HelpBox(context),
                AboutUsBox(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Obx HelpBox(BuildContext context) {
    return Obx(() {
      return optionController.showHelp.value
          ? Container(
              height: Constants.getHeight(context),
              width: Constants.getWidth(context),
              color: const Color.fromARGB(106, 255, 0, 0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: Constants.getHeight(context) * 0.99,
                    width: Constants.getWidth(context),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 48, 48, 48),
                            Color.fromARGB(255, 116, 116, 116),
                            Color.fromARGB(255, 48, 48, 48),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 255, 255, 255))),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    optionController.showHelp.value = false;
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: AppColor.whiteColor,
                                    size: 30,
                                  ))
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'How to Play Tic Tac Toe, The strategy is the same whether you are a naught or a cross. Match 3 in a row to win the game, and block your opponent from being able to do the same. There\'s a basic level of strategy that suits all ages of player.Draw case:There is very high possibility that match will draw, to avoid that we add time. time is add-up continously until that player done its turn, if match will draw and which player have less time will win the game.Tournment:to engage mutliple players we add tournament mode, in which there Elimination tournament, means player loose the game will knockout from tournament, and winner goes to next stage. to start tournament you must have to enter all player\'s names to avoid confusion during match making.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: AppColor.whiteColor, fontSize: 18),
                            ),
                          ),
                          const Text(
                            'Draw Case:',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'There is very high possibility that match will draw, to avoid that we add time. time is add-up continously until that player done its turn, if match will draw and which player have less time will win the game.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: AppColor.whiteColor, fontSize: 18),
                            ),
                          ),
                          const Text(
                            'Tournament:',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'To engage mutliple players we add tournament mode, in which there Elimination tournament, means player loose the game will knockout from tournament, and winner goes to next stage. to start tournament you must have to enter all player\'s names to avoid confusion during match making.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: AppColor.whiteColor, fontSize: 18),
                            ),
                          ),
                          const Text(
                            'About Developer:',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: Constants.getWidth(context),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 48, 48, 48),
                                      Color.fromARGB(255, 116, 116, 116),
                                      Color.fromARGB(255, 48, 48, 48),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 2,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color.fromARGB(
                                                    255, 255, 255, 255),
                                                Color.fromARGB(
                                                    255, 192, 192, 192),
                                                Color.fromARGB(
                                                    255, 151, 150, 150),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                width: 2,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255))),
                                        child: Image.asset(
                                          'Assets/icons/wolf.png',
                                          height: 80,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Text(
                                            'Rashid Ali Amanat',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                color: AppColor.whiteColor,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            'rashidrajpoot289@gmail.com',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                color: AppColor.whiteColor,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            '+923467047798',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                color: AppColor.whiteColor,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color.fromARGB(
                                                    255, 255, 255, 255),
                                                Color.fromARGB(
                                                    255, 192, 192, 192),
                                                Color.fromARGB(
                                                    255, 151, 150, 150),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                width: 2,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255))),
                                        child: Image.asset(
                                          'Assets/icons/rashid.png',
                                          height: 80,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    optionController.showHelp.value = false;
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: AppColor.whiteColor,
                                    size: 30,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox();
    });
  }

  Obx AboutUsBox(BuildContext context) {
    return Obx(() {
      return optionController.showAboutus.value
          ? Container(
              height: Constants.getHeight(context),
              width: Constants.getWidth(context),
              color: const Color.fromARGB(106, 255, 0, 0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: Constants.getHeight(context) * 0.99,
                    width: Constants.getWidth(context),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 48, 48, 48),
                            Color.fromARGB(255, 116, 116, 116),
                            Color.fromARGB(255, 48, 48, 48),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 255, 255, 255))),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    optionController.showAboutus.value = false;
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: AppColor.whiteColor,
                                    size: 30,
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('Assets/icons/button.png'),
                                      fit: BoxFit.fitWidth)),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    'We\'re always here to hear you!',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: AppColor.whiteColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              const url =
                                  'mailto:rashidrajpoot289@gmail.com?subject=Subject%20of%20the%20email&body=Body%20of%20the%20email'; // Replace with the URL you want to open
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const ContactBox(
                                icon: 'Assets/icons/mail.png',
                                title: 'Email Address',
                                subtitle: 'rashidrajpot289@gmail.com'),
                          ),
                          InkWell(
                            onTap: () async {
                              const url = 'tel:+923467047798';

                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const ContactBox(
                                icon: 'Assets/icons/phone.png',
                                title: 'Phone',
                                subtitle: '+92346-7047798'),
                          ),
                          InkWell(
                            onTap: () async {
                              const url = 'whatsapp://send?phone=03467047798';

                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const ContactBox(
                                icon: 'Assets/icons/WA.png',
                                title: 'What\'s App',
                                subtitle: '+92346-7047798'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox();
    });
  }

  InkWell modeBox(BuildContext context, String title, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: Constants.getHeight(context) * 0.1,
        width: Constants.getWidth(context) * 0.9,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/icons/button.png'),
                fit: BoxFit.fitHeight)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: AppColor.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 35),
          ),
        ),
      ),
    );
  }
}

class ContactBox extends StatelessWidget {
  final String icon;
  final String title, subtitle;
  const ContactBox({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Constants.getHeight(context) * 0.22,
        width: Constants.getWidth(context) * 0.7,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/icons/button.png'),
                fit: BoxFit.fitHeight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.greyColor),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Image.asset(
                      icon,
                      height: 50,
                    )))),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColor.whiteColor),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: Constants.getWidth(context) * 0.6,
                child: Center(
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: AppColor.greyColor),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
