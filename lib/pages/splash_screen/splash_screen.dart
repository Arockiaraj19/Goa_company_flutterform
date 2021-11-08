import 'dart:async';

import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setOnboarding();
    });
  }

  setOnboarding() async {
    var val = await getLoginStatus();

    if (val == 1 || kIsWeb) {
      Routes.sailor(Routes.loginPage);
    } else if (val == 2) {
      Routes.sailor(Routes.findMatchPage);
    } else {
      Routes.sailor(Routes.onboardingPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
      width: double.infinity,
      child: TextLiquidFill(
        boxHeight: 200.h,
        boxWidth: double.infinity,
        text: 'SPARKS', loadDuration: Duration(seconds: 2),
        textAlign: TextAlign.center,
        waveColor: MainTheme.primaryColor,
        boxBackgroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 230.sp,
          fontWeight: FontWeight.w900,
        ),
        // boxHeight: 300.0,
      ),
    )
            //     Text("SPARKS",
            //       style: new TextStyle(
            //           fontSize: 60.0,
            //           fontWeight: FontWeight.bold,
            //           foreground: Paint()..shader = MainTheme.loginBtnGradient.
            // createShader((Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
            //     ),
            //   ),
            ));
  }
}
