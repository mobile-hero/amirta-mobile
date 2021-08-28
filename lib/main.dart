import 'package:amirta_mobile/ui/home/home_screen.dart';
import 'package:amirta_mobile/ui/login/login_screen.dart';
import 'package:amirta_mobile/ui/main/main_screen.dart';
import 'package:amirta_mobile/ui/notification/notification_screen.dart';
import 'package:amirta_mobile/ui/profile/profile_screen.dart';
import 'package:amirta_mobile/ui/splash/splash_screen.dart';
import 'package:amirta_mobile/ui/water/check/water_check_data_screen.dart';
import 'package:amirta_mobile/ui/water/search/water_search_result_screen.dart';
import 'package:amirta_mobile/ui/water/water_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_material.dart';

void main() {
  runApp(BaseConfiguration(child: MyApp()));
}

class BaseConfiguration extends StatelessWidget {
  final Widget child;
  
  BaseConfiguration({required this.child});
  
  final locales = [Locale("id", "ID")];
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return EasyLocalization(
            child: child,
            supportedLocales: locales,
            startLocale: locales.first,
            fallbackLocale: locales.first,
            path: 'res/localization',
          );
        }
        
        return Container(
          color: darkBackground,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(red),
            ),
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: customTextTheme,
        primarySwatch: Colors.deepPurple,
        primaryColor: egyptian,
        backgroundColor: backgroundColor,
        scaffoldBackgroundColor: white,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: egyptian,
        ),
        splashColor: forest,
      ),
      routes: <String, WidgetBuilder>{
        // '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
        '/main': (context) => MainScreen(),
        '/notification': (context) => NotificationScreen(),
        '/profile': (context) => ProfileScreen(),
        '/water': (context) => WaterFormScreen(),
        '/water/search_result': (context) => WaterSearchResultScreen(),
        '/water/check': (context) => WaterCheckDataScreen(),
      },
      initialRoute: "/water",
    );
  }
}

final pageRoutes = <String, WidgetBuilder>{
  '/': (context) => SplashScreen(),
  '/login': (context) => LoginPage(),
  '/home': (context) => HomeScreen(),
  '/main': (context) => MainScreen(),
};

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Amirta"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceMedium),
        child: Container(
          child: Column(
            children: [
              AppLogo(),
              LabeledInputField(
                TextEditingController(),
                label: "NRK",
              ),
              LabeledInputField(
                TextEditingController(),
                label: "Password",
              ),
              PrimaryButton(
                () {},
                "Submit",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
