import 'package:flutter/material.dart';
import 'package:tictactoe/res/colors/app_color.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {Key? key,
      this.buttonColor = AppColor.primaryButtonColor,
      this.textColor = AppColor.primaryTextColor,
      required this.title,
      required this.onPress,
      this.width = 60,
      this.height = 50,
      this.loading = false})
      : super(key: key);

  final bool loading;
  final String title;
  final double height, width;
  final VoidCallback onPress;
  final Color textColor, buttonColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 1, 39, 37),
                Color.fromARGB(255, 1, 116, 110)
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 2, color: const Color.fromARGB(255, 141, 139, 139))),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: AppColor.buttonTextColor, fontSize: 20),
                ),
              ),
      ),
    );
  }
}
