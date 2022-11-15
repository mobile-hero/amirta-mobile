import 'package:amirta_mobile/my_material.dart';

class AppBarBottomEllipseContainer extends StatelessWidget
    with PreferredSizeWidget {
  final double clipSize;
  final Color color;
  final double height;
  final Widget child;

  AppBarBottomEllipseContainer({Key? key,
    required this.child,
    this.clipSize = 10,
    this.color = egyptian,
    this.height = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const BottomEllipsePainter(),
      child: ClipPath(
        clipper: const BottomEllipseClipper(),
        child: Container(width: double.infinity, color: color, child: child),
      ),
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(height);
  }
}
