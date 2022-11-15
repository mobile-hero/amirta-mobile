import 'package:amirta_mobile/my_material.dart';

class BottomEllipseContainer extends StatelessWidget {
  final double clipSize;
  final Color color;
  final double height;
  final Widget child;

  const BottomEllipseContainer({Key? key,
    required this.child,
    this.clipSize = 30,
    this.color = egyptian,
    this.height = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BottomEllipsePainter(clipSize: clipSize),
      child: ClipPath(
        clipper: BottomEllipseClipper(clipSize: clipSize),
        child: SizedBox(
          width: double.infinity,
          child: GradientView(
            child: child,
          ),
        ),
      ),
    );
  }
}
