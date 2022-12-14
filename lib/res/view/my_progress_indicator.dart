import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/utils/theme_utils.dart';

class MyProgressIndicator extends StatefulWidget {
  final double height;

  const MyProgressIndicator({
    Key? key,
    this.height = buttonDefaultHeight,
  }) : super(key: key);

  @override
  _MyProgressIndicatorState createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Center(
        child: CircularProgressIndicator(
          color: context.isDark ? borderColor : null,
          valueColor: context.isDark ? null : animationController.drive(
            ColorTween(begin: gradientTop, end: gradientBottom),
          ),
        ),
      ),
    );
  }
}
