// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tictactoe/res/constants/constants.dart';

class FullScreenImage extends StatefulWidget {
  final String img;
  const FullScreenImage({super.key, required this.img});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      height: Constants.getHeight(context),
      width: Constants.getWidth(context),
      child: Image.network(
        widget.img,
        fit: BoxFit.fitWidth,
      ),
    ));
  }
}
