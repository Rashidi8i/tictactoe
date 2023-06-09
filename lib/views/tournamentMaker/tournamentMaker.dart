// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/controllers/roundrobinController/roundrobinController.dart';
import 'package:tictactoe/controllers/tournamentController/tournamentController.dart';
import 'package:tictactoe/res/colors/app_color.dart';
import 'package:tictactoe/res/components/round_button.dart';
import 'package:tictactoe/res/constants/constants.dart';
import 'package:tictactoe/utils/utils.dart';

class TournamentMaker extends StatefulWidget {
  const TournamentMaker({super.key});

  @override
  State<TournamentMaker> createState() => _TournamentMakerState();
}

class _TournamentMakerState extends State<TournamentMaker> {
  final tournamentController = Get.put(TournamentMakerController());
  final robinController = Get.put(RoundRobinController());
  final nameController = TextEditingController();
  List<TextEditingController> textFeildList = [];

  String? nonEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is requried*';
    }
    return null;
  }

  bool allFieldsValid() {
    for (var controller in textFeildList) {
      if (nonEmptyValidator(controller.text) != null) {
        return false;
      }
    }
    return true;
  }

  void savePlayersName() {
    for (int i = 0; i < textFeildList.length; i++) {
      tournamentController.playersName.add(textFeildList[i].text);
    }
  }

  void saveRobinPlayersName() {
    for (int i = 0; i < textFeildList.length; i++) {
      robinController.playersName.add(textFeildList[i].text);
    }
  }

  @override
  void initState() {
    super.initState();
    textFeildList = List.generate(
        int.parse(tournamentController.selectedPlayersCount.value),
        (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Constants.getHeight(context),
          width: Constants.getWidth(context),
          color: AppColor.greyColor,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround
              children: [
                const Center(
                  child: Text('Tournament Type',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
                tournamentDrop(),
                const Center(
                  child: Text('Select PLayers',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
                playersDropDown(),
                textFieldBox(context),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(() => tournamentController.selectedType.value ==
                          'Elimination'
                      ? RoundButton(
                          loading: tournamentController.loading.value,
                          title: 'Generate e Tournament',
                          onPress: () {
                            tournamentController.playedMatches.value = 0;
                            tournamentController.loading.value = true;
                            // tournamentController.deletematch();

                            if (allFieldsValid()) {
                              tournamentController.generateTournament.value =
                                  true;
                              savePlayersName();
                              tournamentController.eliminationTournament(
                                  tournamentController.playersName);
                              if (kDebugMode) {
                                print(
                                    tournamentController.eliminationTournament(
                                        tournamentController.playersName));
                              }

                              //insert tournment
                              tournamentController.insertournmentData();
                              tournamentController.loading.value = false;
                            } else {
                              Utils.toastMessage('All names are required*');
                              tournamentController.loading.value = false;
                            }
                          },
                          width: double.infinity,
                        )
                      : RoundButton(
                          loading: tournamentController.loading.value,
                          title: 'Generate r Tournament',
                          onPress: () {
                            robinController.playedMatches.value = 0;
                            robinController.loading.value = true;

                            if (allFieldsValid()) {
                              robinController.generateTournament.value = true;
                              saveRobinPlayersName();
                              robinController
                                  .robinTournment(robinController.playersName);

                              //insert tournment
                              robinController.insertournmentData();
                              robinController.loading.value = false;
                            } else {
                              Utils.toastMessage('All names are required*');
                              robinController.loading.value = false;
                            }
                          },
                          width: double.infinity,
                        )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Obx textFieldBox(BuildContext context) {
    return Obx(() {
      return Container(
        height: Constants.getHeight(context) * 0.6,
        width: Constants.getWidth(context) * 0.95,
        decoration: const BoxDecoration(
            color: AppColor.darkBlue,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: ListView.builder(
          itemCount: int.parse(tournamentController.selectedPlayersCount.value),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Constants.getWidth(context) * 0.3,
                color: AppColor.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '(${index + 1})',
                        style: const TextStyle(
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: 300,
                          child: TextFormField(
                            style: const TextStyle(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.bold),
                            validator: nonEmptyValidator,
                            controller: textFeildList[index],
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintStyle:
                                    const TextStyle(color: AppColor.whiteColor),
                                hintText: 'Player${index + 1} name'),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Obx tournamentDrop() {
    return Obx(() {
      return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.lightBlue, //background color of dropdown button
            border: Border.all(
                color: Colors.black38, width: 3), //border of dropdown button
            borderRadius:
                BorderRadius.circular(20), //border raiuds of dropdown button
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: DropdownButton(
                value: tournamentController.selectedType.value,
                items: tournamentController.tournamentType.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  tournamentController.selectedType.value = value!;
                  if (value == 'Elimination') {
                    tournamentController.selectedPlayersCount.value = '4';
                  }

                  if (kDebugMode) {
                    print("You selected $value");
                  }
                },
                icon: const Padding(
                    //Icon at tail, arrow bottom is default icon
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_circle_down_sharp)),
                iconEnabledColor: Colors.white, //Icon color
                style: const TextStyle(
                    //te
                    color: Colors.white, //Font color
                    fontSize: 20 //font size on dropdown button
                    ),
                dropdownColor: Colors.redAccent, //dropdown background color
              )));
    });
  }

  Obx playersDropDown() {
    return Obx(() {
      return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.lightBlue, //background color of dropdown button
            border: Border.all(
                color: Colors.black38, width: 3), //border of dropdown button
            borderRadius:
                BorderRadius.circular(20), //border raiuds of dropdown button
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: DropdownButton(
                value: tournamentController.selectedPlayersCount.value,
                items: tournamentController.selectedType.value == 'Elimination'
                    ? tournamentController.eliminationTournamentList
                        .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()
                    : tournamentController.playerCountList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                onChanged: (value) {
                  tournamentController.selectedPlayersCount.value = value!;
                  textFeildList.clear();
                  textFeildList = List.generate(
                      int.parse(
                          tournamentController.selectedPlayersCount.value),
                      (index) => TextEditingController());

                  // addTextfields();
                  if (kDebugMode) {
                    print("You selected $value");
                  }
                },
                icon: const Padding(
                    //Icon at tail, arrow bottom is default icon
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_circle_down_sharp)),
                iconEnabledColor: Colors.white, //Icon color
                style: const TextStyle(
                    //te
                    color: Colors.white, //Font color
                    fontSize: 20 //font size on dropdown button
                    ),
                dropdownColor: Colors.redAccent, //dropdown background color
              )));
    });
  }
}
