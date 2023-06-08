// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tictactoe/res/colors/app_color.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 0,
              right: 0,
              child: CustomPaint(size: Size(400.w, 210.h), painter: Cliper1())),
          Positioned(
              top: 0,
              right: 0,
              child: CustomPaint(size: Size(300.w, 240.h), painter: Cliper2())),
          Positioned(
            top: 50,
            right: 30,
            child: Image.asset("assets/images/cart.png",
                color: AppColor.whiteColor, width: size.width * 0.35),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Transform.rotate(
                  angle: 3.14,
                  child: CustomPaint(
                      size: Size(400.w, 440.h), painter: Cliper4()))),
          Positioned(
              bottom: 0,
              left: 0,
              child: Transform.rotate(
                  angle: 3.14,
                  child: CustomPaint(
                      size: Size(400.w, 340.h), painter: Cliper3()))),
          child
        ],
      ),
    );
  }
}

class Cliper1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColor.primaryColor2
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.quadraticBezierTo(size.width * 0.7500000, 0, size.width, 0);
    path0.quadraticBezierTo(
        size.width, size.height * 0.7500000, size.width, size.height);
    path0.cubicTo(size.width * 0.1859375, size.height * 0.8000000,
        size.width * 0.8109375, size.height * 0.2025000, 0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Cliper2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColor.secondaryColor2
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.quadraticBezierTo(size.width * 0.7500000, 0, size.width, 0);
    path0.quadraticBezierTo(
        size.width, size.height * 0.7500000, size.width, size.height);
    path0.cubicTo(size.width * 0.5578125, size.height * 0.9000000,
        size.width * 0.9375000, size.height * 0.6400000, 0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Cliper3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColor.primaryColor2
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.1480000);
    path0.cubicTo(size.width * -0.0140625, size.height * 0.0951200, 0,
        size.height * 0.0076200, 0, 0);
    path0.quadraticBezierTo(size.width * 0.2500000, 0, size.width, 0);
    path0.quadraticBezierTo(size.width * 1.0015625, size.height * 0.2478800,
        size.width, size.height * 0.4505000);
    path0.quadraticBezierTo(size.width * 0.9231250, size.height * 0.6468800,
        size.width * 0.5925000, size.height * 0.3065000);
    path0.quadraticBezierTo(size.width * 0.1412500, size.height * -0.0193800, 0,
        size.height * 0.1480000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Cliper4 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColor.secondaryColor2
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0015625, size.height * 0.2605000);
    path0.cubicTo(size.width * -0.0203125, size.height * 0.2076200, 0,
        size.height * 0.0076200, 0, 0);
    path0.quadraticBezierTo(size.width * 0.2500000, 0, size.width, 0);
    path0.quadraticBezierTo(size.width * 1.0062500, size.height * 0.0603800,
        size.width, size.height * 0.2630000);
    path0.quadraticBezierTo(size.width * 0.8106250, size.height * 0.4268800,
        size.width * 0.6034375, size.height * 0.1815000);
    path0.quadraticBezierTo(size.width * 0.2912500, size.height * -0.0468800,
        size.width * 0.0015625, size.height * 0.2605000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
