import 'package:amirta_mobile/my_material.dart';

class GradientView extends StatelessWidget {
  final Widget child;

  const GradientView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
