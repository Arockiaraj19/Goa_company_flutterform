import 'dart:async';

import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes.dart';

class LoginOtpPage extends StatefulWidget {
  LoginOtpPage({Key key}) : super(key: key);

  @override
  _LoginOtpPageState createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  final TextEditingController _otpController = TextEditingController();

  Timer _resendOTPTimer;
  int _resendTimerString = 20;
  bool _enableResendBtn = false;

  @override
  void initState() {
    super.initState();
    _resendOTPTimer =
        Timer.periodic(Duration(seconds: 1), _updateResendOTPString);
  }

  @override
  void dispose() {
    super.dispose();
    _resendOTPTimer?.cancel();
  }

  void _updateResendOTPString(Timer timer) {
    if (_resendTimerString == 0) {
      _resendOTPTimer?.cancel();
      setState(() {
        _enableResendBtn = true;
      });
      return;
    }
    setState(() {
      _resendTimerString--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return _buildPhone();
      } else {
        return _buildWeb();
      }
    });
  }

  Widget _buildPhone() {
    var _textStyleforSpark = TextStyle(
        color: MainTheme.sparksTextColor,
        fontWeight: FontWeight.w900,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryHeadingfontSize),
        fontFamily: "lato");

    var _textStyleforWelcomBack = TextStyle(
        color: MainTheme.welcomeBackTextColor,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondaryHeadingfontSize),
        // fontSize: 24,
        fontFamily: "lato");

    var _goodToSeeTextColor = TextStyle(
        color: MainTheme.goodToSeeTextColor,
        fontWeight: FontWeight.w400,
        height: 2,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
        fontFamily: "lato");

    var _enterTextColor = TextStyle(
        color: MainTheme.enterTextColor,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(40),
        fontFamily: "Inter");

    var _codeIsTextColor = TextStyle(
        color: MainTheme.codeIsSendTextColor,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(35),
        fontFamily: "Inter");

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              "assets/images/login pic.png",
                            ))),
                    child: Column(children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsetsDirectional.only(
                                  start: 10, top: 20),
                              child: Text("Sparks", style: _textStyleforSpark)),
                        ],
                      ),
                      Container(
                          margin: EdgeInsetsDirectional.only(
                              start: 5, top: 50, bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  "Welcome Back !!",
                                  style: _textStyleforWelcomBack,
                                ),
                              ),
                            ],
                          )),
                      Container(
                          margin: EdgeInsetsDirectional.only(
                            bottom: 10,
                            start: 5,
                          ),
                          child: Row(children: [
                            Expanded(
                              child: Text("Hey! Good to see you again",
                                  style: _goodToSeeTextColor),
                            )
                          ])),
                      SizedBox(height: ScreenUtil().setHeight(50)),
                      _commonBuild(context)
                    ])))));
  }

  goVerify(String otp) {}

  goToFindMatchPagePage() {
    Routes.sailor(
      Routes.findMatchPage,
    );
  }

  Widget _commonBuild(BuildContext context, {bool onWeb = false}) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width / 2;

    var _textStyleSubHeading =
        TextStyle(color: Colors.black, fontSize: 14, fontFamily: "lato");

    var _textStyleContent =
        TextStyle(color: Colors.black, fontSize: 12, fontFamily: "lato");

    var _enterTextColor = TextStyle(
        color: MainTheme.enterTextColor,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(40),
        fontFamily: "Inter");

    var _codeIsTextColor = TextStyle(
        color: MainTheme.codeIsSendTextColor,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(35),
        fontFamily: "Inter");

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: onWeb ? null : EdgeInsetsDirectional.only(top: 50),
                child: Text("Enter your 4-digit code",
                    style: onWeb ? _textStyleSubHeading : _enterTextColor)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: onWeb ? null : EdgeInsetsDirectional.only(top: 10),
                padding: onWeb
                    ? EdgeInsetsDirectional.only(
                        top: _height / 80,
                        bottom: _height / 40,
                      )
                    : null,
                child: Text("code is sent to +91 9880400324",
                    style: onWeb ? _textStyleContent : _codeIsTextColor)),
          ],
        ),
        onWeb
            ? Container()
            : SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
        Container(
            padding: onWeb
                ? EdgeInsetsDirectional.only(
                    end: _width * 0.19,
                    start: _width * 0.19,
                  )
                : EdgeInsetsDirectional.only(
                    end: 50,
                    start: 50,
                  ),
            child: OtpTextField(
              textStyle: TextStyle(fontWeight: FontWeight.bold),
              numberOfFields: 4,
              autoFocus: false,
              controller: _otpController,
              onSubmit: goVerify,
              showFieldAsBox: true,
              fieldWidth: onWeb ? _width / 18 : ScreenUtil().setWidth(100),
              fieldHeight: onWeb ? 36 : ScreenUtil().setWidth(98),
              focusedBorderColor: MainTheme.primaryColor,
              enabledBorderColor: Colors.black,
              borderRadius: BorderRadius.circular(10),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )),
        onWeb
            ? Container()
            : SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientButton(
              height: 40,
              name: "Login",
              gradient: _enableResendBtn
                  ? MainTheme.loginBtnGradientGrey
                  : MainTheme.loginBtnGradient,
              active: true,
              color: _enableResendBtn ? Colors.black : Colors.white,
              width: onWeb ? _width / 6 : ScreenUtil().setWidth(480),
              fontWeight: FontWeight.w400,
              fontSize: 14,
              onPressed: () {
                goToFindMatchPagePage();
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Text(
              "Resend Code : ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: onWeb ? 13 : ScreenUtil().setSp(40),
                  fontFamily: "Inter"),
            )),
            Container(
                child: Text(
              "${_resendTimerString}",
              style: TextStyle(
                  color: MainTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: onWeb ? 13 : ScreenUtil().setSp(40),
                  fontFamily: "Inter"),
            )),
          ],
        ),
      ],
    );
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
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24,
        fontFamily: "lato");

    var _textStyleforSentence = TextStyle(
        color: Colors.grey,
        // fontWeight: FontWeight.bold,
        height: 1.5,
        fontSize: 14,
        fontFamily: "lato");

    var _textStyleSubHeading =
        TextStyle(color: Colors.black, fontSize: 14, fontFamily: "lato");

    var _textStyleContent =
        TextStyle(color: Colors.black, fontSize: 12, fontFamily: "lato");

    var _textStyleforAlreadyHave =
        TextStyle(color: Colors.black, fontSize: 14, fontFamily: "lato");

    var _textStyleforLogin = TextStyle(
        color: Colors.black,
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
                    margin: EdgeInsetsDirectional.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          height: _height / 40,
                          width: _width / 20,
                        ),
                        Container(
                          child: Text(
                            "Welcome Back !!",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: "lato"),
                          ),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsetsDirectional.only(bottom: 10),
                    child: Row(children: [
                      Container(
                        height: _height / 40,
                        width: _width / 20,
                      ),
                      Expanded(
                        child: Text(
                          "Hey! Good to see you again",
                          style: TextStyle(
                              color: Colors.grey,
                              // fontWeight: FontWeight.bold,
                              height: 2,
                              fontSize: 12,
                              fontFamily: "lato"),
                        ),
                      )
                    ])),
                Container(
                  height: _height / 5,
                  width: _width,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: _height / 5,
                        width: _width * 0.2,
                        child: Image.asset(
                          "assets/images/mobileImageWithMsg.png",
                          fit: BoxFit.contain,
                        )),
                    Container(
                      height: _height / 2,
                      width: _width * 0.72,
                      child: _commonBuild(context, onWeb: true),
                    ),
                  ],
                ),
              ],
            )))
      ]),
    ));
  }
}
