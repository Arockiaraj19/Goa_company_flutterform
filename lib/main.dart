import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:dating_app/models/expertGroup_model.dart';
import 'package:dating_app/networks/messaging.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/networks/topic_network.dart';
import 'package:dating_app/providers/blind_provider.dart';
import 'package:dating_app/providers/chat_provider.dart';
import 'package:dating_app/providers/expertChat_provider.dart';
import 'package:dating_app/providers/game_provider.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/match_provider.dart';
import 'package:dating_app/providers/notification_provider.dart';
import 'package:dating_app/providers/ref_provider.dart';
import 'package:dating_app/providers/single_user_provider.dart';
import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:url_strategy/url_strategy.dart';
import 'models/chatmessage_model.dart';
import 'models/expertGroup_model.dart';
import 'models/expertGroup_model.dart';
import 'models/expertGroup_model.dart';
import 'models/expertchatmessage_model.dart';
import 'models/question_model.dart';
import 'providers/countryCode_provider.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
    statusBarIconBrightness: Brightness.light,
  ));
  // final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(DetailsAdapter());
  Hive.registerAdapter(ExpertChatMessageAdapter());

  runApp(ModularApp(module: Navigate(), child: MyApp()));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    // initDynamicLinks();
    super.initState();

    _messaging.init().then((value) => request());
    _messaging.stream.listen(
      (event) {
        print('New Message: ${event}');
      },
    );
  }

  final _messaging = Messaging.instance;
  Future<void> request() async {
    _messaging.requestPermission().then((_) async {
      final _token = await _messaging.getToken();

      print('Token: $_token');
      saveFCMToken(_token);
      Topic().subscripeToken(_token, "broadcast_user");
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
          ChangeNotifierProvider(create: (context) => GameProvider()),
          ChangeNotifierProvider(create: (context) => SingleUserProvider()),
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
                ).modular()));
  }
}
