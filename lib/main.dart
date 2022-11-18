import 'dart:convert';

import 'package:amirta_mobile/bloc/fcm/fcm_bloc.dart';
import 'package:amirta_mobile/event_bus.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:amirta_mobile/repository/repository_impl.dart';
import 'package:amirta_mobile/ui/complaint/complaint_screen.dart';
import 'package:amirta_mobile/ui/complaint/history/complaint_history_screen.dart';
import 'package:amirta_mobile/ui/complaint/report/complaint_set_complete_screen.dart';
import 'package:amirta_mobile/ui/complaint/report/create_complaint_report_screen.dart';
import 'package:amirta_mobile/ui/home/home_screen.dart';
import 'package:amirta_mobile/ui/login/login_screen.dart';
import 'package:amirta_mobile/ui/main/main_screen.dart';
import 'package:amirta_mobile/ui/notification/notification_screen.dart';
import 'package:amirta_mobile/ui/panic/history/panic_history_screen.dart';
import 'package:amirta_mobile/ui/panic/panic_screen.dart';
import 'package:amirta_mobile/ui/panic/report/create_panic_report_screen.dart';
import 'package:amirta_mobile/ui/panic/report/panic_set_complete_screen.dart';
import 'package:amirta_mobile/ui/password/change/change_password_screen.dart';
import 'package:amirta_mobile/ui/password/change/change_password_success_screen.dart';
import 'package:amirta_mobile/ui/password/email/email_password_screen.dart';
import 'package:amirta_mobile/ui/password/email/email_password_success_screen.dart';
import 'package:amirta_mobile/ui/password/reset/reset_password_screen.dart';
import 'package:amirta_mobile/ui/profile/profile_screen.dart';
import 'package:amirta_mobile/ui/settings/settings_screen.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    BaseConfiguration(
      child: const MyApp(),
    ),
  );
}

class BaseConfiguration extends StatelessWidget {
  final Widget child;

  BaseConfiguration({Key? key, required this.child}) : super(key: key);

  final locales = [const Locale('en', 'US'), const Locale('id', 'ID')];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final language = snapshot.data!.getString('language') ?? 'en';
          late Locale locale;
          switch (language) {
            case 'en':
              locale = locales.first;
              break;
            case 'id':
              locale = locales.last;
              break;
          }

          return EasyLocalization(
            child: child,
            supportedLocales: locales,
            startLocale: locale,
            fallbackLocale: locales.first,
            path: 'res/localization',
          );
        }

        return Container(
          color: borderColor,
          width: double.infinity,
          height: double.infinity,
          child: const Center(
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

  print('Handling a background message: ${message.messageId}');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
        if (message.data.containsKey('click_action')) {
          if (message.data['click_action'] == 'payment_success') {
            eventBus.fire(NotificationTopupEvent());
          } else {
            eventBus.fire(CheckUnreadNotificationEvent());
          }
        }
        print(
            'Message also contained a notification: ${message.notification?.android?.clickAction}');
        final imageUrl = message.notification?.android?.imageUrl;
        late DefaultStyleInformation styleInformation;
        AndroidBitmap? largeIcon;
        if (imageUrl != null) {
          final tempDir = await getTemporaryDirectory();
          final downloadPath =
              tempDir.path + Uri.parse(imageUrl).pathSegments.last;
          await dio.download(imageUrl, downloadPath);

          styleInformation = BigPictureStyleInformation(
            largeIcon ??= FilePathAndroidBitmap(downloadPath),
            summaryText: message.notification?.body ?? '-',
          );
        } else {
          styleInformation = BigTextStyleInformation(
            message.notification?.body ?? '-',
          );
        }
        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
          'amirta-notification',
          'Amirta',
          'Channel notifikasi Amirta',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          playSound: true,
          sound: const RawResourceAndroidNotificationSound('danger_alarm'),
          icon: 'ic_app_notification',
          largeIcon: largeIcon,
          color: egyptian,
          styleInformation: styleInformation,
        );
        IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
          presentAlert: true,
          presentSound: true,
          sound: 'alarm.m4r',
          subtitle: message.notification?.body ?? '-',
        );
        NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidNotificationDetails,
          iOS: iosNotificationDetails,
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
      print(
          'Message also contained a notification: ${message.notification?.android?.clickAction}');
      selectNotification(jsonEncode(message.data));
    });
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
      Map<String, dynamic> json = jsonDecode(payload);
      if (json.containsKey('click_action')) {
        final action = json['click_action'] as String;
        switch (action) {
        }
      } else {
        _navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/main',
          (route) => false,
        );
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
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
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
                    AccountLocalRepositoryImpl(const FlutterSecureStorage()),
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
                  return _initFcmBloc();
                }
                return const Center(
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
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(egyptian),
            ),
          ),
        );
      },
    );
  }

  Widget _initFcmBloc() {
    return BlocProvider(
      create: (context) {
        return FcmBloc(
          context.appProvider().fcmRepository,
          FirebaseMessaging.instance,
        );
      },
      child: BlocBuilder<FcmBloc, FcmState>(
        builder: (context, state) {
          return _initApp();
        },
      ),
    );
  }

  Widget _initApp() {
    return MaterialApp(
      title: 'Amirta',
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
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: egyptian,
        ),
        splashColor: waterfall,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: darkCustomTextTheme,
        primarySwatch: Colors.deepPurple,
        primaryColor: egyptianDark,
        backgroundColor: darkBackground,
        scaffoldBackgroundColor: darkBackground,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: egyptianDark,
        ),
        splashColor: waterfallDark,
      ),
      routes: <String, WidgetBuilder>{
        Routes.splash: (context) => const SplashScreen(),
        Routes.login: (context) => const LoginPage(),
        Routes.home: (context) => const HomeScreen(),
        Routes.main: (context) => const MainScreen(),
        Routes.notification: (context) => const NotificationScreen(),
        Routes.passwordChange: (context) => const ChangePasswordScreen(),
        Routes.passwordChangeSuccess: (context) =>
            const ChangePasswordSuccessScreen(),
        Routes.passwordEmail: (context) => const EmailPasswordScreen(),
        Routes.passwordEmailSuccess: (context) =>
            const EmailPasswordSuccessScreen(),
        Routes.passwordReset: (context) => const ResetPasswordScreen(),
        Routes.profile: (context) => const ProfileScreen(),
        Routes.water: (context) => const WaterFormScreen(),
        Routes.waterSearch: (context) => const WaterSearchResultScreen(),
        Routes.waterCheck: (context) => const WaterCheckDataScreen(),
        Routes.complaint: (context) => const ComplaintScreen(),
        Routes.complaintHistory: (context) => const ComplaintHistoryScreen(),
        Routes.complaintSetComplete: (context) =>
            const ComplaintSetCompleteScreen(),
        Routes.complaintCreateReport: (context) =>
            const CreateComplaintReportScreen(),
        Routes.panic: (context) => const PanicScreen(),
        Routes.panicHistory: (context) => const PanicHistoryScreen(),
        Routes.panicSetComplete: (context) => const PanicSetCompleteScreen(),
        Routes.panicCreateReport: (context) => const CreatePanicReportScreen(),
        Routes.settings: (context) => const SettingsScreen(),
      },
      initialRoute: Routes.splash,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amirta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceMedium),
        child: Column(
          children: [
            const AppLogo(),
            LabeledInputField(
              TextEditingController(),
              label: 'NRK',
            ),
            LabeledInputField(
              TextEditingController(),
              label: 'Password',
            ),
            PrimaryButton(
              () {},
              'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
