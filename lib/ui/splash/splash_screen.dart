import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.pushNamed(context, "/login");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientView(
        child: Center(
          child: AppLogo(
            logoSize: AppLogoSize.big,
          ),
        ),
      ),
    );
  }
}
