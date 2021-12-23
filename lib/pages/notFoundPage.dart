import 'dart:async';

import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<NotFoundPage> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 769) {
        return phone();
      } else {
        return Scaffold(
            body: Center(
                child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "NOT FOUND",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w900,
                          color: MainTheme.primaryColor),
                    ))
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
    });
  }

  Scaffold phone() {
    return Scaffold(
        body: Center(
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  "NOT FOUND",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: MainTheme.primaryColor),
                ))
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
