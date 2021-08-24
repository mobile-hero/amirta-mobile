import 'package:amirta_mobile/my_material.dart';

class GradientView extends StatelessWidget {
  final Widget child;

  const GradientView({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            gradientTop,
            gradientBottom,
          ],
        ),
      ),
      child: child,
    );
  }
}
