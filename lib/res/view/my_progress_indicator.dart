import 'package:amirta_mobile/res/resources.dart';

class MyProgressIndicator extends StatefulWidget {
  final double height;

  const MyProgressIndicator({this.height = buttonDefaultHeight});

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
      duration: new Duration(seconds: 2),
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
    return Container(
      height: widget.height,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: animationController.drive(
            ColorTween(begin: gradientTop, end: gradientBottom),
          ),
        ),
      ),
    );
  }
}
