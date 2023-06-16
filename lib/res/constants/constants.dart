// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Constants {
  static int t_id = 0;
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
