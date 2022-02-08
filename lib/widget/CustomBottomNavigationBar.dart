import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomBottomNavigationBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(Offset(0, 0), Offset(size.width, 50),
          [Colors.purpleAccent, Colors.blueAccent]);

    Path path = Path();
    path.quadraticBezierTo(size.width * 0, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.42, 0, size.width * 0.42, 10);
    path.arcToPoint(Offset(size.width * 0.58, 10),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.58, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.65, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
