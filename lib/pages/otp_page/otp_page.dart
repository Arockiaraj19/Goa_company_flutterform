import 'dart:async';

import 'package:dating_app/models/otp_model.dart';
import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/networks/firebase_auth.dart';
import 'package:dating_app/networks/signup_network.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/otp_text_field.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes.dart';

class OtpPage extends StatefulWidget {
  final OtpModel otpData;
  OtpPage({Key key, this.otpData}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  Timer _resendOTPTimer;
  int _resendTimerString = 300;
  bool _enableResendBtn = false;
  bool loading = false, err = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    timerFunction();
  }

  timerFunction() {
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
      if (constraints.maxWidth < 1100) {
        return _buildPhone();
      } else {
        return _buildWeb();
      }
    });
  }

  Widget _buildPhone() {
    var _textStyleforHeading = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    var _textForEnterMobile = TextStyle(
        color: MainTheme.enterTextColor,
        fontWeight: FontWeight.w500,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    var _textForCodeIs = TextStyle(
        color: MainTheme.codeIsSendTextColor,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
        fontFamily: "lato");

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.black,
                    size: 25,
                  )),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Container(
                  child:
                      Text("Verify Phone Number", style: _textStyleforHeading)),
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsetsDirectional.only(top: 20),
                      height: ScreenUtil().setHeight(100),
                      width: ScreenUtil().setWidth(180),
                      child: Image.asset(
                        "assets/images/mobileImageWithMsg.png",
                        fit: BoxFit.fill,
                      ))
                ],
              ),
              _commonBuild(context)
            ]))));
  }
  //
  // goVerify(String otp) {
  //   // Routes.sailor(Routes.signup);
  //   // widget.otpData.submitOTP(otp);
  // }

  goToAddingPasswordPage() async {
    setState(() {
      loading = true;
    });
    if (widget.otpData.isMob == false) {
      var network = EmailSignUpNetwork();
      ResponseData result = await network.verifyOtpForSignup(
          widget.otpData.value, _otpController.text);
      showtoast(result.msg.toString());
      result.statusDetails == 2
          ? Routes.sailor(Routes.addingPasswordPage,
              params: {"email": widget.otpData.value})
          : Routes.sailor(Routes.loginPage);
    } else {
      var _credential = PhoneAuthProvider.credential(
          verificationId: widget.otpData.id, smsCode: _otpController.text);
      Master_function(
          context, _credential, widget.otpData.value, widget.otpData.isSignUp);
    }
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

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: onWeb ? null : EdgeInsetsDirectional.only(top: 50),
                  child: Text("Enter your 6-digit code",
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
                  child: Text("code is sent to ${widget.otpData.value}",
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
                      end: _width * 0.12,
                      start: _width * 0.12,
                    )
                  : EdgeInsetsDirectional.only(
                      end: 35,
                      start: 35,
                    ),
              child: OtpTextField(
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                numberOfFields: 6,
                autoFocus: false,
                controller: _otpController,
                // onSubmit: goVerify,
                showFieldAsBox: true,
                fieldWidth: onWeb ? _width / 18 : ScreenUtil().setWidth(100),
                fieldHeight: onWeb ? 36 : ScreenUtil().setWidth(98),
                focusedBorderColor: MainTheme.primaryColor,
                enabledBorderColor: Colors.black,
                borderRadius: BorderRadius.circular(10),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              )),
          onWeb
              ? Container(
                  child: err
                      ? Text(
                          "Please enter 6 digit OTP number",
                          style: TextStyle(color: Colors.red),
                        )
                      : SizedBox())
              : SizedBox(
                  height: ScreenUtil().setHeight(50),
                  child: err
                      ? Text(
                          "Please enter 6 digit OTP number",
                          style: TextStyle(color: Colors.red),
                        )
                      : SizedBox(),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GradientButton(
                      height: 40,
                      name: loading ? "Logging In.." : "Log In",
                      gradient: MainTheme.loginBtnGradient,
                      active: true,
                      color: Colors.white,
                      width: onWeb ? _width / 6 : ScreenUtil().setWidth(480),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      isLoading: loading,
                      onPressed: () {
                        if (_otpController.text.length == 6) {
                          goToAddingPasswordPage();
                        } else {
                          setState(() {
                            err = true;
                          });
                        }
                      },
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () async {
                    if (_enableResendBtn == true) {
                      setState(() {
                        _enableResendBtn = false;
                        _resendTimerString = 300;
                      });
                      timerFunction();
                      var network = EmailSignUpNetwork();
                      bool result =
                          await network.resendOtpForEmail(widget.otpData.value);
                    }
                  },
                  child: Text(
                    "Resend Code ",
                    style: TextStyle(
                        color: _enableResendBtn
                            ? MainTheme.primaryColor
                            : Colors.black,
                        fontSize: onWeb ? 13 : ScreenUtil().setSp(40),
                        fontFamily: "Inter"),
                  )),
              Container(
                  child: Text(
                _resendTimerString == 0 ? "" : ": ${_resendTimerString}",
                style: TextStyle(
                    color: MainTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: onWeb ? 13 : ScreenUtil().setSp(40),
                    fontFamily: "Inter"),
              )),
            ],
          ),
        ],
      ),
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
                // Container(
                //   height: _height / 20,
                //   width: _width,
                // ),
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
                  height: _height / 12,
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
                        child: _commonBuild(context, onWeb: true)),
                  ],
                ),
                Container(
                  height: 69,
                  width: _width,
                ),
              ],
            )))
      ]),
    ));
  }
}
