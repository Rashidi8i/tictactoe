// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tictactoe/res/colors/app_color.dart';

class CounterBadge extends StatelessWidget {
  final String value;
  const CounterBadge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: AppColor.redColor,
          shape: BoxShape.circle,
        ),
        child: Text(
          value, // Replace with your counter value
          style: const TextStyle(
            color: AppColor.whiteColor,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
