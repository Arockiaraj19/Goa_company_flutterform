import 'package:bot_toast/bot_toast.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/providers/blind_provider.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/match_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Routes.createRoutes();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _initialRoute = Routes.splashScreen;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>HomeProvider()),
        ChangeNotifierProvider(
            create: (context) =>MatchProvider()),
        ChangeNotifierProvider(
            create: (context) =>BlindProvider()),
      ],
      child:ScreenUtilInit(
          designSize: Size(1000, 690),
          builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
                title: 'Sparks',
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
                      iconTheme: IconThemeData(color: Colors.white, size: 100),
                    )),
              ))
    );
  }
}
