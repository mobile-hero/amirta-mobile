import 'package:amirta_mobile/my_material.dart';

class BottomEllipsePainter extends CustomPainter {
  final double clipSize;

  const BottomEllipsePainter({this.clipSize = 10});

  @override
  void paint(Canvas canvas, Size size) {
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

    canvas.drawShadow(path, shadowBoxColor, 1, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
