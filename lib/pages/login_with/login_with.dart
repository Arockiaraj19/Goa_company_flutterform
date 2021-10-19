import 'dart:async';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/firebase_auth.dart';
import 'package:dating_app/networks/signin_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/regex_pattern.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/Forminput.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';

import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.name);
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          "assets/images/login pic.png",
                        ))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.r, vertical: 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35.h,
                        ),
                        Text("Sparks", style: _textStyleforSpark),
                        SizedBox(
                          height: 50.h,
                        ),
                        Text(
                          "Welcome Back !!",
                          style: _textStyleforWelcomBack,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text("Hey! Good to see you again",
                            style: _goodToSeeTextColor),
                        SizedBox(
                          height: 110.h,
                        ),
                        loginItem(widget.name),
                      ]),
                ))));
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter your email",
            style: TextStyle(
                color: MainTheme.enterTextColor,
                fontSize: 40.sp,
                fontFamily: "lato",
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 8.h,
          ),
          Forminput(
            emailController: _emailCtrl,
            placeholder: "Email",
            validation: (val) {
              if (val.isEmpty) {
                return "Please enter email id";
              }
              RegExp regex = new RegExp(emailpatttern.toString());
              if (!regex.hasMatch(val)) {
                return 'Please enter valid email id';
              }
              if (val.length > 50) {
                return "Please enter less than 50 letters";
              }
              // return null;
            },
          ),

          SizedBox(
            height: 20.h,
          ),

          Text(
            "Enter your password",
            style: TextStyle(
                color: MainTheme.enterTextColor,
                fontSize: 40.sp,
                fontFamily: "lato",
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: _passCtrl,
            cursorColor: Colors.pink,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.emailAddress,
            obscureText: obscureText,
            decoration: InputDecoration(
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
                              color: Color(0xffC4C4C4),
                              size: 45.sp,
                            )
                          : Icon(
                              Icons.visibility_off_outlined,
                              color: Color(0xffC4C4C4),
                              size: 45.sp,
                            ))),
              contentPadding: EdgeInsets.only(
                  left: 18.0.w, bottom: 12.0.h, top: 12.0.h, right: 2.0.w),
              hintText: "Password",
              hintStyle: TextStyle(
                  fontSize: 40.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffC4C4C4)),
              errorStyle: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w400,
                color: Colors.pink,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pink, width: 1, style: BorderStyle.solid),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pink, width: 1, style: BorderStyle.solid),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffEFEBEB),
                    width: 1,
                    style: BorderStyle.solid),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pink, width: 1, style: BorderStyle.solid),
              ),
            ),
            // validator: (val) {
            //   if (val.isEmpty) {
            //     return "Please enter password";
            //   }
            //   RegExp regex = new RegExp(passwordpattern.toString());
            //   if (!regex.hasMatch(val)) {
            //     return 'password must be have at least 8 characters \nlong 1 uppercase & 1 lowercase character\n1 number';
            //   }
            //   return null;
            // },
          ),
          SizedBox(
            height: 3.h,
          ),
          InkWell(
            onTap: () => goToforgetEmail(),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot password ?",
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 40.sp,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffC4C4C4)),
                // TextStyle(
                //     color: Colors.black, fontSize: 14, fontFamily: "lato"),
              ),
            ),
          ),

          SizedBox(
            height: 30.h,
          ),
          Align(
            alignment: Alignment.center,
            child: GradientButton(
              height: 110.w,
              fontSize: 40.sp,
              name: loading ? "Logging In.." : "Log In",
              gradient: MainTheme.loginwithBtnGradient,
              active: true,
              color: Colors.white,
              isLoading: loading,
              width: 500.w,
              borderRadius: BorderRadius.circular(20.sp),
              fontWeight: FontWeight.w500,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  goToFindMatchPage();
                }
                // var dto = {"password": "123456", "email": "asd@mail.com"};
                // _authStore.onLogin(dto);
              },
            ),
          ),
          // SizedBox(height: ScreenUtil().setHeight(200)),
        ],
      ),
    );
  }

  goToforgetEmail() {
    Routes.sailor(Routes.signUpWithEmailPage, params: {"isforget": true});
  }

  goToFindMatchPage() async {
    setState(() {
      loading = true;
    });
    var network = SignInNetwork();
    var network1 = UserNetwork();
    Timer(Duration(seconds: 3), () => offLoading());
    print("before login");
    bool result = await network.signInWithEmail(
        _emailCtrl.text.trim(), _passCtrl.text.trim());
    print("after login login");
    UserModel userData = result ? await network1.getUserData() : null;
    userData != null ? onboardingCheck(userData) : null;
  }

  offLoading() {
    setState(() {
      loading = false;
    });
  }

  goToLoginOtpPage() async {
    setState(() {
      loading = true;
    });
    var network1 = UserNetwork();
    await registerUser(_numberCtrl.text, context, false);
    //Timer(Duration(seconds: 8), ()=>offLoading());
  }

  Widget _loginWithNumber({double btnWidth}) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80.h,
          ),
          Text(
            "Enter your mobile number",
            style: TextStyle(
                color: MainTheme.enterTextColor,
                fontSize: 40.sp,
                fontFamily: "lato",
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            controller: _numberCtrl,
            cursorColor: Colors.pink,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.number,
            style: TextStyle(
                fontSize: 40.sp,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w400,
                color: MainTheme.enterTextColor),
            decoration: InputDecoration(
              isDense: true,
              prefixText: "+91",
              prefixStyle: TextStyle(
                  color: MainTheme.enterTextColor,
                  fontSize: 40.sp,
                  fontFamily: "lato",
                  fontWeight: FontWeight.w400),
              contentPadding: EdgeInsets.only(
                  left: 18.0.w, bottom: 12.0.h, top: 12.0.h, right: 2.0.w),
              hintText: 'Mobile number',
              hintStyle: TextStyle(
                  fontSize: 40.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffC4C4C4)),
              errorStyle: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w400,
                color: Colors.pink,
              ),
              errorBorder: OutlineInputBorder(
                gapPadding: 0,
                borderSide: BorderSide(
                    color: Colors.pink, width: 1, style: BorderStyle.solid),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pink, width: 1, style: BorderStyle.solid),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffC4C4C4),
                    width: 1,
                    style: BorderStyle.solid),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pink, width: 1, style: BorderStyle.solid),
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "* Required";
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
          SizedBox(
            height: 50.h,
          ),
          Align(
            alignment: Alignment.center,
            child: GradientButton(
              height: 110.w,
              fontSize: 40.sp,
              name: loading ? "Logging In.." : "Log In",
              gradient: MainTheme.loginwithBtnGradient,
              active: true,
              color: Colors.white,
              isLoading: loading,
              width: 500.w,
              borderRadius: BorderRadius.circular(20.sp),
              fontWeight: FontWeight.w500,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  goToLoginOtpPage();
                }
                // var dto = {"password": "123456", "email": "asd@mail.com"};
                // _authStore.onLogin(dto);
              },
            ),
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