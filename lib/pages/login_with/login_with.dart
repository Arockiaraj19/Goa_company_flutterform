import 'dart:async';

import 'package:dating_app/models/device_info.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/firebase_auth.dart';
import 'package:dating_app/networks/signin_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/shared/helpers/get_device_info.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/input_field.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes.dart';

class LoginWith extends StatefulWidget {
  final String name;
  LoginWith({Key key, this.name = "MOBILE"}) : super(key: key);

  @override
  _LoginWithState createState() => _LoginWithState();
}

class _LoginWithState extends State<LoginWith> {
  TextEditingController _numberCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();
  bool obscureText = true;
  bool loading =false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.name);
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
                      SizedBox(height: 110,),
                      loginItem(widget.name),
                    ])))));
  }

  Widget loginItem(String item, {double btnWidth}) {
    switch (item) {
      case 'MOBILE':
        return _loginWithNumber(btnWidth: btnWidth);
      case 'EMAIL':
        return _loginWithEmail(btnWidth: btnWidth);
    }
  }

  Widget _loginWithEmail({double btnWidth}) {
    var _passwordTextColor = TextStyle(
        color: MainTheme.forgotPassTextColor,
        fontWeight: FontWeight.w400,
        height: 2,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
        fontFamily: "lato");

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsetsDirectional.only(start: 20,),
                  child: Text(
                    "Enter your email",
                    style: TextStyle(
                        color: MainTheme.enterTextColor,
                        fontSize: 14,
                        fontFamily: "lato",
                        fontWeight: FontWeight.w400),
                  )),
            ],
          ),
          InputField(
            labelBehavior: FloatingLabelBehavior.never,
            gradient: MainTheme.loginwithBtnGradient,
            inputBoxBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            onTap: () {},
            controller: _emailCtrl,
            // inputType: TextInputType.number,
            padding: EdgeInsetsDirectional.only(
                top: 10, bottom: 10, end: 20, start: 20),
            validators: (String value) {
              if (value.isEmpty) return 'Required field';
              return null;
            },
            hintText: 'Enter your email',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsetsDirectional.only(start: 20, top: 20),
                  child: Text(
                    "Enter your password",
                    style: TextStyle(
                        color: MainTheme.enterTextColor,
                        fontSize: 14,
                        fontFamily: "lato",
                        fontWeight: FontWeight.w400),
                  )),
            ],
          ),
          InputField(
            labelBehavior: FloatingLabelBehavior.never,
            gradient: MainTheme.loginwithBtnGradient,
            inputBoxBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            onTap: () {},
            controller: _passCtrl,
            suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    if (obscureText == false) {
                      obscureText = true;
                    } else {
                      obscureText = false;
                    }
                  });
                },
                child: Container(
                    margin: EdgeInsetsDirectional.only(end: 10),
                    child: !obscureText
                        ? Icon(
                            Icons.remove_red_eye_outlined,
                            color: MainTheme.primaryColor,
                            size: 18,
                          )
                        : Icon(
                            Icons.visibility_off_outlined,
                            color: MainTheme.primaryColor,
                            size: 18,
                          ))),
            // inputType: TextInputType.,
            obscureText: obscureText,
            padding: EdgeInsetsDirectional.only(
                top: 10, bottom: 10, end: 20, start: 20),
            validators: (String value) {
              if (value.isEmpty) return 'Required field';
              return null;
            },
            hintText: 'password',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding: EdgeInsetsDirectional.only(end: 20),
                  child: Text("Forgot password ?",
                      style: TextStyle(
                          color: MainTheme.forgotPassTextColor,
                          fontWeight: FontWeight.w400,
                          height: 2,
                          fontSize: 13,
                          fontFamily: "lato")
                      // TextStyle(
                      //     color: Colors.black, fontSize: 14, fontFamily: "lato"),
                      )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                height: 40,
                fontSize: 14,
                name:loading?"Logging In..":"log In",
                gradient: MainTheme.loginwithBtnGradient,
                active: true,
                color: Colors.white,
                isLoading: loading,
                width: btnWidth ?? ScreenUtil().setWidth(480),
                fontWeight: FontWeight.w500,
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    goToFindMatchPage();
                  }
                  // var dto = {"password": "123456", "email": "asd@mail.com"};
                  // _authStore.onLogin(dto);
                },
              ),
            ],
          ),
          // SizedBox(height: ScreenUtil().setHeight(200)),
        ],
      ),
    );
  }

  goToFindMatchPage() async {
    setState(() {
      loading=true;
    });
    var network = SignInNetwork();
    var network1 = UserNetwork();
    Timer(Duration(seconds: 3), ()=>offLoading());
    bool result =await network.signInWithEmail(_emailCtrl.text,_passCtrl.text);
    UserModel userData= result? await network1.getUserData():null;
    userData != null? onboardingCheck(userData):null;
  }

  offLoading(){
    setState(() {
      loading=false;
    });
  }
  goToLoginOtpPage() async{
    setState(() {
      loading=true;
    });
    var network1 = UserNetwork();
    await registerUser(_numberCtrl.text,context,false);
    //Timer(Duration(seconds: 8), ()=>offLoading());
  }

  Widget _loginWithNumber({double btnWidth}) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsetsDirectional.only(start: 20, top: 60),
                  child: Text(
                    "Enter your mobile number",
                    style: TextStyle(
                        color: Colors.black, fontSize: 14, fontFamily: "lato"),
                  )),
            ],
          ),
          InputField(
            labelBehavior: FloatingLabelBehavior.never,
            gradient: MainTheme.loginwithBtnGradient,
            inputBoxBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            onTap: () {},
            controller: _numberCtrl,
            inputType: TextInputType.number,
            padding: EdgeInsetsDirectional.only(
                top: 10, bottom: 10, end: 20, start: 20),
            prefix: Text(
              '+91  ',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            validators: (String value) {
              if (value.isEmpty) return 'Required field';
              return null;
            },
            hintText: 'mobile number',
          ),
          SizedBox(height: 100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                height: 40,
                fontSize: 14,
                name: loading?"Loading..":"Login",
                gradient: MainTheme.loginwithBtnGradient,
                active: true,
                isLoading: loading,
                color: Colors.white,
                width: btnWidth ?? ScreenUtil().setWidth(480),
                fontWeight: FontWeight.w500,
                onPressed: () {
                  if(_formKey.currentState.validate()){
                    goToLoginOtpPage();
                  }
                },
              ),
            ],
          ),
          // SizedBox(height: ScreenUtil().setHeight(400)),
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
                    top: 10,
                    start: 30,
                  ),
                  child: Text("Spark", style: _textStyleforSpark)),
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage(
              //       "assets/images/login pic.png",
              //     )),
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
                SizedBox(height: ScreenUtil().setHeight(100)),
                Container(
                    width: _width / 2,
                    child: loginItem(widget.name, btnWidth: _width / 5)),
              ],
            )))
      ]),
    ));
  }
}

//
// "// headers -Send as stringified JSON
// ""user_device"":{""imei_no"" : ""123456"",""device_model"":""One plus"",""app_type"":""android"",""device_type"":""mobile"",""browser"":""firefox"",""browser_version"":""12.5.6"",""ip_address"":""""}"