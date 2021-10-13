import 'package:bot_toast/bot_toast.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/providers/blind_provider.dart';
import 'package:dating_app/providers/chat_provider.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/match_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'fun ', // id
    'hello', // title
    description: 'hello bro', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Routes.createRoutes();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  initPushNotification();
  runApp(MyApp());
}

initPushNotification() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  String id = await getUserId();
  print("user id");
  print(id);
  await FirebaseMessaging.instance.subscribeToTopic(id);
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _initialRoute = Routes.splashScreen;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => MatchProvider()),
          ChangeNotifierProvider(create: (context) => BlindProvider()),
          ChangeNotifierProvider(create: (context) => ChatProvider()),
        ],
        child: ScreenUtilInit(
            designSize: Size(1000, 690),
            builder: () => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Sparks',
                  // locale: DevicePreview.locale(context), // Add the locale here
                  // builder: DevicePreview.appBuilder, // Add the builder here
                  builder: BotToastInit(),
                  navigatorObservers: [BotToastNavigatorObserver()],
                  navigatorKey: Routes.sailor.navigatorKey,
                  onGenerateRoute: Routes.sailor.generator(),
                  initialRoute: _initialRoute,
                  theme: ThemeData(
                      scaffoldBackgroundColor: Colors.white,
                      fontFamily: 'Nunito',
                      appBarTheme: AppBarTheme(
                        elevation: 2,
                        iconTheme:
                            IconThemeData(color: Colors.white, size: 100),
                      )),
                )));
  }
}
