import 'package:flutter/material.dart';

class BottomEllipseClipper extends CustomClipper<Path> {
  final double clipSize;

  const BottomEllipseClipper({this.clipSize = 10});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - clipSize);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - clipSize);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
