import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/web_gredient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 1100) {
          return _buildPhone();
        } else {
          return _buildWeb();
        }
      }),
    );
  }

  Widget _buildPhone() {
    var _textStyleforSpark = TextStyle(
        color: MainTheme.sparksTextColor,
        fontWeight: FontWeight.w900,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryHeadingfontSize),
        fontFamily: "lato");

    var _textStyleforMatchText = TextStyle(
        color: MainTheme.matchTextColor,
        fontWeight: FontWeight.w900,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondaryHeadingfontSize),
        // fontSize: 24,
        fontFamily: "lato");

    var _textStyleforSentence = TextStyle(
        color: MainTheme.contentTextColor,
        fontWeight: FontWeight.w400,
        height: 1.5,
        // fontSize: 14,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
        fontFamily: "lato");

    var _textStyleforOr = TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
        // fontSize: 14,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
        fontFamily: "lato");

    var _textStyleforAlreadyHave = TextStyle(
        color: MainTheme.alreadyTextColor,
        // fontSize: 14,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
        fontFamily: "lato");

    var _textStyleforLogin = TextStyle(
        color: MainTheme.logincontentTextColor,
        fontWeight: FontWeight.w700,
        // fontSize: 14,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
        fontFamily: "lato");

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/loginImage.png",
                  ))),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.r, vertical: 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 35.h,
                    ),
                    Text("Sparks", style: _textStyleforSpark),
                    SizedBox(
                      height: 50.h,
                    ),
                    Text("Match. Chat. Date.", style: _textStyleforMatchText),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                        "Spark is the only dating app that connects people based on interests, beliefs and profession.",
                        style: _textStyleforSentence),
                    SizedBox(height: 230.h),
                    GradientButton(
                      height: 125.w,
                      name: "Login with Mobile",
                      gradient: MainTheme.loginBtnGradient,
                      active: true,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.r),
                      onPressed: () {
                        goToLoginWithMobile(name: "MOBILE");
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text(
                            "___    OR   ___",
                            style: TextStyle(
                                color: Color.fromRGBO(190, 190, 190, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil()
                                    .setSp(MainTheme.mPrimaryContentfontSize),
                                fontFamily: "lato"),
                          ),
                        ])),
                    SizedBox(
                      height: 15.h,
                    ),
                    GradientButton(
                      height: 125.w,
                      name: "Login with email",
                      borderRadius: BorderRadius.circular(40.r),
                      color: Colors.white,
                      buttonColor: Colors.black,
                      onPressed: () {
                        goToLoginWithMobile(name: "EMAIL");
                      },
                    ),
                    SizedBox(height: 40.h),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Container(
                              margin: EdgeInsetsDirectional.only(end: 5),
                              child: Text("Don’t have an account?",
                                  style: _textStyleforAlreadyHave)),
                          InkWell(
                              onTap: () {
                                goToSignUpPage();
                              },
                              child:
                                  Text("Sign up", style: _textStyleforLogin)),
                        ])),
                  ]),
            ),
          )),
      // bottomSheet: Container(
      //     color: Colors.black,
      //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //       Container(
      //           margin: EdgeInsetsDirectional.only(end: 5),
      //           child: Text("Already have account?",
      //               style: _textStyleforAlreadyHave)),
      //       InkWell(
      //           onTap: () {
      //             goToSignUpPage();
      //           },
      //           child: Text("Sign up", style: _textStyleforLogin)),
      //     ])),
    ));
  }

  goToSignUpPage() {
    NavigateFunction().withquery(Navigate.signUpPage);
  }

  goToLoginWithMobile({String name}) {
    NavigateFunction().withquery(Navigate.loginWith + "?name=$name");
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width / 2;

    var _textStyleforSpark = TextStyle(
        color: MainTheme.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 28,
        fontFamily: "lato");

    var _textStyleforMatchText = TextStyle(
        color: Color.fromRGBO(71, 71, 71, 1),
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: "lato");

    var _textStyleforSentence = TextStyle(
        color: Color.fromRGBO(138, 138, 143, 1),
        // fontWeight: FontWeight.bold,
        height: 1.5,
        fontSize: 14,
        fontFamily: "lato");

    var _textStyleforOr = TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: "lato");

    var _textStyleforAlreadyHave = TextStyle(
        color: Color.fromRGBO(90, 90, 90, 1), fontSize: 14, fontFamily: "lato");

    var _textStyleforLogin = TextStyle(
        color: Color.fromRGBO(90, 90, 90, 1),
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontFamily: "lato");

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Row(children: [
        Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/web_login_image.png",
                  ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsetsDirectional.only(
                    top: 30,
                    start: 30,
                  ),
                  child: Text("Spark", style: _textStyleforSpark)),
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[100],
                  blurRadius: 1.0,
                  offset: Offset(0, 5),
                )
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.zero,
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.zero,
              ),
            ),
            height: _height,
            width: _width,
            padding: EdgeInsetsDirectional.only(
              top: _height / 9,
              // bottom: _height / 9,
              end: _width / 30,
              start: _width / 30,
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    child: Row(
                  children: [
                    Container(
                      height: _height / 40,
                      width: _width / 20,
                    ),
                    Container(
                      child: Text("Match. Chat. Date.",
                          style: _textStyleforMatchText),
                    ),
                  ],
                )),
                Container(
                  height: _height / 40,
                  width: _width,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: _width / 1.5,
                          child: Row(children: [
                            Container(
                              height: _height / 40,
                              width: _width / 20,
                            ),
                            Expanded(
                              child: Text(
                                "Spark is the only dating app that connects people based on interests, beliefs and profession.",
                                style: _textStyleforSentence,
                                textAlign: TextAlign.start,
                              ),
                            )
                          ])),
                    ]),
                Container(
                  height: _height / 9,
                  width: _width,
                ),
                WebGradientButton(
                  gradient: MainTheme.loginBtnGradientwhite,
                  hoverColor: MainTheme.loginBtnGradient,
                  hoverTextColor: Colors.white,
                  height: 40,
                  fontSize: 14,
                  width: _width / 2,
                  name: "Login with Mobile",
                  color: Colors.black,
                  border: Border.all(width: 1, color: Colors.black),
                  active: true,
                  onPressed: () {
                    goToLoginWithMobile(name: "MOBILE");
                  },
                ),
                Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text("___  OR  ___", style: _textStyleforOr),
                    ])),
                WebGradientButton(
                  gradient: MainTheme.loginBtnGradientwhite,
                  hoverColor: MainTheme.loginBtnGradient,
                  hoverTextColor: Colors.white,
                  height: 40,
                  fontSize: 14,
                  width: _width / 2,
                  name: "Login with email",
                  color: Colors.black,
                  border: Border.all(width: 1, color: Colors.black),
                  onPressed: () {
                    goToLoginWithMobile(name: "EMAIL");
                  },
                ),
                Container(
                  height: _height / 20,
                  width: _width,
                ),
                Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Container(
                          margin: EdgeInsetsDirectional.only(end: 5),
                          child: Text("Don’t have an account? ",
                              style: _textStyleforAlreadyHave)),
                      InkWell(
                          onTap: () {
                            goToSignUpPage();
                          },
                          child: Text("Sign up", style: _textStyleforLogin)),
                    ])),
                Container(
                  height: 150,
                  width: _width,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(child: Text("Get the App")),
                      SizedBox(
                        width: _width / 20,
                      ),
                      Container(
                        width: _width / 7,
                        height: 30,
                        child: Image.asset(
                          "assets/images/playStore.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: _width / 20,
                      ),
                      Container(
                        width: _width / 7,
                        height: 30,
                        child: Image.asset(
                          "assets/images/apple_store.png",
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )))
      ]),
    ));
  }
}
