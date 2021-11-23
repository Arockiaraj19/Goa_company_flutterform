import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/providers/blind_provider.dart';
import 'package:dating_app/providers/chat_provider.dart';
import 'package:dating_app/providers/expertChat_provider.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/match_provider.dart';
import 'package:dating_app/providers/notification_provider.dart';
import 'package:dating_app/providers/ref_provider.dart';
import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'models/question_model.dart';
import 'providers/countryCode_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'fun', // id
    'hello', // title
    description: 'hello bro', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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
        ),
        payload: json.encode(message.data));
    print("onMessage: $message");
    print(message);
  }
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

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onselectnotication);
  await MobileAds.instance.initialize();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

onselectnotication(String payload) async {
  var data = json.decode(payload);
  print(data);
  if (data["type"] == "1") {
    print("page 1");
    Routes.sailor(
      Routes.chattingPage,
      params: {
        "groupid": data["group_id"],
        "id": data["sender_id"],
        "image": data["identification_image"],
        "name": data["first_name"]
      },
    );
  } else if (data["type"] == "2") {
    print("second step kku varuthaa");
    print(data);
    print(json.decode(data["questions"]));
    print(data["user2_identification_image"]);
    print(data["user1_identification_image"]);
    print(data["user2_first_name"]);
    print(data["user1_first_name"]);
    final finaldata = List.from(json.decode(data["questions"]));
    List<Getquestion> result = await finaldata
        .map((codeData) => Getquestion.fromMap(codeData))
        .toList(growable: false);
    print(result);
    Routes.sailor(Routes.quizGamePage, params: {
      "questions": result,
      "playid": data["play_id"],
      "user1": data["user2_identification_image"],
      "user2": data["user1_identification_image"],
      "istrue": false,
      "user1name": data["user2_first_name"],
      "user2name": data["user1_first_name"],
    });
  } else if (data["type"] == "4") {
    print("four th step kku varuthaa");
    print(data);
    Routes.sailor(Routes.expertchat, params: {
      "groupid": data["group_id"],
      "id": data["sender_id"],
      "name": data["first_name"],
      "status": int.parse(data["online_status"]),
      "image": List<String>.from([data["identification_image"].toString()]),
    });
  } else {
    print("third scenario");
    Routes.sailor(Routes.quizSucessPage, params: {
      "user1image": data["user2_identification_image"] as String,
      "user2image": data["user1_identification_image"] as String,
      "user1name": data["user2_first_name"] as String,
      "user2name": data["user1_first_name"] as String,
      "score": int.parse(data["score"]),
      "length": int.parse(data["questions"]),
    });
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

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
    initDynamicLinks();
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
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
            ),
            payload: json.encode(message.data));
        print("onMessage: $message");
        print(message);
      }
    });
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
            ),
            payload: json.encode(message.data));
        print("onMessage: $message");
        print(message);
      }
    });

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   print("onMessage: $message");
    //   print(message.data);
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
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
            ),
            payload: json.encode(message.data));
        print("onMessage: $message");
        print(message);
      }
    });
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
        await _handleDeepLink(dynamicLinkData);
      },
      onError: (OnLinkErrorException e) async {
        print('DynamicLink Failed: ${e.message}');
        return e.message;
      },
    );

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data.link != null) {
      _handleDeepLink(data);
    }
  }

  // bool _deeplink = true;
  _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      // Check if we want to make a post
      var isPost = deepLink.pathSegments.contains('ref');

      if (isPost) {
        // get the title of the post
        var title = deepLink.queryParameters['id'];

        if (title != null) {
          print("id main la correct a varuthaa");
          print(title);

          // Future.delayed(Duration(seconds: 1), () {
          //   context.read<RefProvider>().saveId(title);
          // });

          setRef(title.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => MatchProvider()),
          ChangeNotifierProvider(create: (context) => BlindProvider()),
          ChangeNotifierProvider(create: (context) => ChatProvider()),
          ChangeNotifierProvider(create: (context) => CodeProvider()),
          ChangeNotifierProvider(create: (context) => NotificationProvider()),
          ChangeNotifierProvider(create: (context) => SubscriptionProvider()),
          ChangeNotifierProvider(create: (context) => RefProvider()),
          ChangeNotifierProvider(create: (context) => ExpertChatProvider()),
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
                      primaryColor: MainTheme.primaryColor,
                      indicatorColor: MainTheme.primaryColor,
                      accentColor: MainTheme.primaryColor,
                      appBarTheme: AppBarTheme(
                        elevation: 2,
                        iconTheme:
                            IconThemeData(color: Colors.white, size: 100),
                      )),
                )));
  }
}
