import 'package:dating_app/models/country_code_model.dart';
import 'package:dating_app/networks/countrycode_network.dart';
import 'package:dating_app/networks/firebase_auth.dart';
import 'package:dating_app/networks/signup_network.dart';
import 'package:dating_app/providers/chat_provider.dart';
import 'package:dating_app/providers/countryCode_provider.dart';
import 'package:dating_app/shared/helpers/loadingLottie.dart';
import 'package:dating_app/shared/helpers/regex_pattern.dart';
import 'package:dating_app/shared/helpers/websize.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/error_card.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/input_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../../routes.dart';

class SignUpWithMobilePage extends StatefulWidget {
  SignUpWithMobilePage({Key key}) : super(key: key);

  @override
  _SignUpWithMobilePageState createState() => _SignUpWithMobilePageState();
}

class _SignUpWithMobilePageState extends State<SignUpWithMobilePage> {
  TextEditingController _numberCtrl = TextEditingController();
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 769) {
        return _buildPhone();
      } else {
        return _buildWeb();
      }
    });
  }

  Widget _buildPhone() {
    var _textStyleforHeading = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w700,
        fontSize: 45.sp,
        fontFamily: "lato");

    var _textForEnterMobile = TextStyle(
        color: MainTheme.enterTextColor,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.r, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text("Continue with Phone", style: _textStyleforHeading),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                    height: 500.r,
                    width: 300.r,
                    child: Image.asset(
                      "assets/images/mobileImage.png",
                      fit: BoxFit.fill,
                    )),
                SizedBox(
                  height: ScreenUtil().setHeight(70),
                ),
                _commonBuild(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  FocusNode myFocusNode;
  String countrycode;
  CountryCode code;

  Widget _commonBuild(BuildContext context, {bool onWeb = false}) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width / 2;

    var _textForEnterMobile = TextStyle(
        color: MainTheme.enterTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 40.sp,
        fontFamily: "lato");
    var _textStyleforEnterNo =
        TextStyle(color: Colors.black, fontSize: 16, fontFamily: "lato");

    return Form(
      key: _formKey,
      child: Padding(
        padding: onWeb ? EdgeInsets.fromLTRB(50, 0, 50, 0) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: onWeb
                    ? EdgeInsetsDirectional.only(
                        top: _height / 18,
                        bottom: _height / 25,
                        start: _width * 0.1,
                      )
                    : EdgeInsets.all(0),
                child: Text(
                  "Enter your mobile number",
                  style: onWeb ? _textStyleforEnterNo : _textForEnterMobile,
                )),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: onWeb
                  ? EdgeInsetsDirectional.only(
                      start: _width * 0.1,
                    )
                  : EdgeInsets.all(0),
              width: onWeb ? _width / 1.5 : null,
              child: Row(
                children: [
                  Container(
                    width: onWeb ? 65 : 180.w,
                    child: TextFormField(
                      readOnly: true,
                      controller: codecontroller,
                      cursorColor: MainTheme.primaryColor,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: onWeb ? inputFont : 40.sp,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w400,
                          color: MainTheme.enterTextColor),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: onWeb
                            ? null
                            : EdgeInsets.only(
                                left: 18.0.w,
                                bottom: 12.0.h,
                                top: 12.0.h,
                                right: 2.0.w),
                        hintText: '+91',
                        hintStyle: TextStyle(
                            fontSize: onWeb ? inputFont : 40.sp,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffC4C4C4)),
                        errorStyle: TextStyle(
                          fontSize: onWeb ? inputFont : 40.sp,
                          fontWeight: FontWeight.w400,
                          color: MainTheme.primaryColor,
                        ),
                        errorBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide: BorderSide(
                              color: MainTheme.primaryColor,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MainTheme.primaryColor,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffC4C4C4),
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MainTheme.primaryColor,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*";
                        }
                        if (_numberCtrl.text.isEmpty) {
                          return "*";
                        }
                        RegExp regex = new RegExp(numberpattern);
                        if (!regex.hasMatch(_numberCtrl.text)) {
                          return '*';
                        }
                        if (_numberCtrl.text.length > 10 ||
                            _numberCtrl.text.length < 10) {
                          return "*";
                        }

                        return null;
                      },
                      onTap: () {
                        myFocusNode.requestFocus();
                        context.read<CodeProvider>().getdata(null);
                        if (onWeb) {
                          showsub(context);
                        } else {
                          _showbottom();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: onWeb ? 5 : 10.w,
                  ),
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        controller: _numberCtrl,
                        cursorColor: MainTheme.primaryColor,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: onWeb ? inputFont : 40.sp,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w400,
                            color: MainTheme.enterTextColor),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: onWeb
                              ? null
                              : EdgeInsets.only(
                                  left: 18.0.w,
                                  bottom: 12.0.h,
                                  top: 12.0.h,
                                  right: 2.0.w),
                          hintText: 'Mobile number',
                          hintStyle: TextStyle(
                              fontSize: onWeb ? inputFont : 40.sp,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffC4C4C4)),
                          errorStyle: TextStyle(
                            fontSize: onWeb ? inputFont : 40.sp,
                            fontWeight: FontWeight.w400,
                            color: MainTheme.primaryColor,
                          ),
                          errorBorder: OutlineInputBorder(
                            gapPadding: 0,
                            borderSide: BorderSide(
                                color: MainTheme.primaryColor,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MainTheme.primaryColor,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffC4C4C4),
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MainTheme.primaryColor,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "* Required";
                          }
                          if (codecontroller.text.isEmpty) {
                            return "* Please select country code";
                          }
                          RegExp regex = new RegExp(numberpattern);
                          if (!regex.hasMatch(value)) {
                            return 'Please enter only number';
                          }
                          if (value.length > 10 || value.length < 10) {
                            return "Please enter only 10 numbers";
                          }

                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (onWeb)
              SizedBox(
                height: 20,
              ),
            if (onWeb)
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: _width * 0.1,
                  end: _width * 0.1,
                ),
                child: Text(
                  "Once you hit continue, you’ll receive a verification code. The verified number can be used to log in",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff8A8A8F), fontSize: 12, height: 2),
                ),
              ),
            SizedBox(
              height: onWeb ? 20 : 50.h,
            ),
            Align(
              alignment: Alignment.center,
              child: loading
                  ? CircularProgressIndicator()
                  : GradientButton(
                      height: onWeb ? 35 : 110.w,
                      fontSize: onWeb ? inputFont : 40.sp,
                      name: "Next",
                      gradient: MainTheme.loginwithBtnGradient,
                      active: true,
                      color: Colors.white,
                      isLoading: loading,
                      width: onWeb ? 130 : 500.w,
                      borderRadius: BorderRadius.circular(onWeb ? 5 : 20.sp),
                      fontWeight: FontWeight.w500,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          goToOtpPage();
                        }
                        // var dto = {"password": "123456", "email": "asd@mail.com"};
                        // _authStore.onLogin(dto);
                      },
                    ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     GradientButton(
            //       height: onWeb ? 35 : 40,
            //       name: loading ? "Loading.." : "Next",
            //       gradient: MainTheme.loginBtnGradient,
            //       active: true,
            //       color: Colors.white,
            //       isLoading: loading,
            //       width: onWeb ? _width / 6 : ScreenUtil().setWidth(400),
            //       fontWeight: FontWeight.bold,
            //       borderRadius: BorderRadius.circular(5),
            //       fontSize: 14,
            //       onPressed: () {
            //         if (_formKey.currentState.validate()) {

            //         }
            //       },
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  TextEditingController codecontroller = TextEditingController();
  TextEditingController bottomsheetcontroller = TextEditingController();
  showsub(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: 300,
                height: 400,
                child: countryCodesheet(context, true)),
          );
        });
  }

  _showbottom() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              child: countryCodesheet(context, false),
            ),
          );
        });
  }

  Padding countryCodesheet(BuildContext context, onWeb) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            focusNode: myFocusNode,
            controller: bottomsheetcontroller,
            cursorColor: MainTheme.primaryColor,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.number,
            style: TextStyle(
                fontSize: onWeb ? inputFont : 40.sp,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w400,
                color: MainTheme.enterTextColor),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: onWeb
                  ? null
                  : EdgeInsets.only(
                      left: 18.0.w, bottom: 12.0.h, top: 12.0.h, right: 2.0.w),
              hintText: 'Enter your country code',
              hintStyle: TextStyle(
                  fontSize: onWeb ? inputFont : 40.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffC4C4C4)),
              errorStyle: TextStyle(
                fontSize: onWeb ? inputFont : 40.sp,
                fontWeight: FontWeight.w400,
                color: MainTheme.primaryColor,
              ),
              errorBorder: OutlineInputBorder(
                gapPadding: 0,
                borderSide: BorderSide(
                    color: MainTheme.primaryColor,
                    width: 1,
                    style: BorderStyle.solid),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MainTheme.primaryColor,
                    width: 1,
                    style: BorderStyle.solid),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffC4C4C4),
                    width: 1,
                    style: BorderStyle.solid),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MainTheme.primaryColor,
                    width: 1,
                    style: BorderStyle.solid),
              ),
            ),
            onChanged: (value) {
              print(value);
              context.read<CodeProvider>().getdata(value);
            },
            validator: (value) {},
          ),
          Expanded(child: Consumer<CodeProvider>(
            builder: (context, data, child) {
              return data.chatState == ChatState.Error
                  ? ErrorCard(
                      text: data.errorText,
                      ontab: () {
                        context.read<CodeProvider>().getdata("");
                      },
                    )
                  : data.chatState == ChatState.Loading
                      ? LoadingLottie()
                      : data.codeData.length == 0
                          ? Center(
                              child: Text("no data"),
                            )
                          : SingleChildScrollView(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: List.generate(
                                        data.codeData.length,
                                        (index) => InkWell(
                                              onTap: () {
                                                codecontroller.text = data
                                                    .codeData[index]
                                                    .telephonecode;
                                                code = data.codeData[index];
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.centerLeft,
                                                height: 40.h,
                                                child: Text(data.codeData[index]
                                                    .telephonecode),
                                              ),
                                            )),
                                  ),
                                ),
                              ),
                            );
            },
          ))
        ],
      ),
    );
  }

  void getcallback(String data) {
    print("call back funtion la correct a varuthaa");
    setState(() {
      loading = false;
    });
  }

  goToOtpPage() async {
    setState(() {
      loading = true;
    });
    var network = MobileSignUpNetwork();
    try {
      var result = await network.verifyMobileNoForSignup(
          codecontroller.text + _numberCtrl.text, code.id);
      result
          ? registerUser(codecontroller.text + _numberCtrl.text, context, true,
              getcallback)
          : null;
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
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

    var _textStyleforEnterNo =
        TextStyle(color: Colors.black, fontSize: 16, fontFamily: "lato");

    var _textStyleforAlreadyHave =
        TextStyle(color: Colors.black, fontSize: 14, fontFamily: "lato");

    var _textStyleforLogin = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontFamily: "lato");

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
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
              top: 0,
              // bottom: _height / 9,
              end: _width / 30,
              start: _width / 30,
            ),
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff181725),
                      size: 18,
                    ),
                  )),
              body: Column(
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
                          height: _height / 40,
                          width: _width / 20,
                        ),
                        Container(
                            width: _width / 1.5,
                            child: Row(children: [
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
                    height: _height / 8,
                    width: _width,
                  ),
                  _commonBuild(context, onWeb: true),
                  // Container(
                  //   height: 110,
                  //   width: _width,
                  // ),
                ],
              ),
            ))
      ]),
    ));
  }
}
