import 'dart:convert';

import 'package:amirta_mobile/bloc/app_provider.dart';
import 'package:amirta_mobile/event_bus.dart';
import 'package:amirta_mobile/repository/account_local_repository_impl.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:amirta_mobile/repository/repository_impl.dart';
import 'package:amirta_mobile/ui/home/home_screen.dart';
import 'package:amirta_mobile/ui/login/login_screen.dart';
import 'package:amirta_mobile/ui/main/main_screen.dart';
import 'package:amirta_mobile/ui/notification/notification_screen.dart';
import 'package:amirta_mobile/ui/profile/profile_screen.dart';
import 'package:amirta_mobile/ui/splash/splash_screen.dart';
import 'package:amirta_mobile/ui/water/check/water_check_data_screen.dart';
import 'package:amirta_mobile/ui/water/search/water_search_result_screen.dart';
import 'package:amirta_mobile/ui/water/water_form_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    BaseConfiguration(
      child: MyApp(),
    ),
  );
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
          color: borderColor,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(egyptian),
            ),
          ),
        );
      },
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  final Dio dio = Dio();

  final RepositoryConfig repositoryConfig = RepositoryConfig.staging();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _setupLocalNotification();
    _setupFirebaseMessage();
    super.initState();
  }

  void _setupLocalNotification() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_app_notification');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void _setupFirebaseMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        if (message.data.containsKey("click_action")) {
          if (message.data["click_action"] == "payment_success") {
            eventBus.fire(NotificationTopupEvent());
          } else {
            eventBus.fire(CheckUnreadNotificationEvent());
          }
        }
        print('Message also contained a notification: ${message.notification}');
        AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'amirta-notification',
          'Amirta',
          'Channel notifikasi Amirta',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          icon: "ic_app_notification",
          color: red,
          styleInformation:
              BigTextStyleInformation(message.notification?.body ?? "-"),
        );
        NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
        );
        await flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics,
          payload: jsonEncode(message.data),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      selectNotification(jsonEncode(message.data));
    });
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
      Map<String, dynamic> json = jsonDecode(payload);
      if (json.containsKey("click_action")) {
        final action = json["click_action"] as String;
        switch (action) {
          case "payment_success":
          case "invoice_expired":
          case "charging_complete":
            // _navigatorKey.currentState?.push(MaterialPageRoute(
            //   builder: (context) => TrxHistoryPage(),
            //   settings: RouteSettings(name: TransactionHistory().routeName),
            // ));
            break;
          case "charging_start":
          case "charging_incomplete":
          case "charging_stop":
          case "charging_requested":
            // _navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
            //   builder: (context) => HomePage(),
            //   settings: RouteSettings(name: Home().routeName),
            // ));
            break;
        }
      }
    }
  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final info = snapshot.data!;
          repositoryConfig.setVersion(info.version);
          return Provider<AppProvider>(
            create: (_) {
              return AppProvider(
                dio: dio,
                repositoryConfig: repositoryConfig,
                deviceInfo: DeviceInfoPlugin(),
                connectivity: Connectivity(),
                accountLocalRepository:
                    AccountLocalRepositoryImpl(FlutterSecureStorage()),
                accountRepository: AccountRepositoryImpl(dio, repositoryConfig),
                rusunRepository: RusunRepositoryImpl(dio, repositoryConfig),
                fcmRepository: FcmRepositoryImpl(dio, repositoryConfig),
                pengaduanRepository:
                    PengaduanRepositoryImpl(dio, repositoryConfig),
                uploadImageRepository:
                    UploadImageRepositoryImpl(dio, repositoryConfig),
              );
            },
            child: FutureBuilder(
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _initApp();
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        }

        return Container(
          color: borderColor,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(egyptian),
            ),
          ),
        );
      },
    );
  }

  Widget _initApp() {
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
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
        '/main': (context) => MainScreen(),
        '/notification': (context) => NotificationScreen(),
        '/profile': (context) => ProfileScreen(),
        '/water': (context) => WaterFormScreen(),
        '/water/search_result': (context) => WaterSearchResultScreen(),
        '/water/check': (context) => WaterCheckDataScreen(),
      },
      initialRoute: "/splash",
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
