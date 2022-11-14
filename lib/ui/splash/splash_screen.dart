import 'dart:async';

import 'package:amirta_mobile/my_material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GradientView(
              child: Center(
                child: AppLogo(
                  logoSize: AppLogoSize.big,
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: messaging.requestPermission(
              alert: true,
              announcement: false,
              badge: true,
              carPlay: false,
              criticalAlert: false,
              provisional: false,
              sound: true,
            ),
            builder: (context, snapshot) {
              return FutureBuilder<int>(
                future: context.appProvider().setupAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    startOpeningPage(snapshot.data);
                  }
                  return SizedBox();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void startOpeningPage(int? result) {
    Future.microtask(() {
      if (result == 0) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.main,
          (route) => false,
        );
      }
    });
  }
}
