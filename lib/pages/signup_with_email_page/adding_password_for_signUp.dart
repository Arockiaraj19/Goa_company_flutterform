import 'package:dating_app/models/forgetresponse_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/forgetpassword_network.dart';
import 'package:dating_app/networks/signup_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/regex_pattern.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/input_field.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddingPasswordForSignUp extends StatefulWidget {
  final String email;
  final ResponseSubmitOtp otpdata;
  final bool isforget;
  AddingPasswordForSignUp({Key key, this.email, this.otpdata, this.isforget})
      : super(key: key);

  @override
  _AddingPasswordForSignUpState createState() =>
      _AddingPasswordForSignUpState();
}

class _AddingPasswordForSignUpState extends State<AddingPasswordForSignUp> {
  TextEditingController _password1Ctrl = TextEditingController();
  TextEditingController _password2Ctrl = TextEditingController();
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool obscureText1 = true;
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

  @override
  void initState() {
    super.initState();
    print("otp data correct a varuthaaaa");
    print(widget.otpdata);
    print("boolean enna varuthu");
    print(widget.isforget);
  }

  Widget _buildPhone() {
    var _textStyleforHeading = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    var _textForEnterMobile = TextStyle(
        color: MainTheme.enterTextColor,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              child: Text("Create the password", style: _textStyleforHeading)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.r, vertical: 0),
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(150),
              ),
              commonPart(context, onWeb: false)
            ],
          ),
        ),
      ),
    );
  }

  goToCreateProfilePage() async {
    setState(() {
      loading = true;
    });
    var network = EmailSignUpNetwork();
    bool result =
        await network.signUpWithEmail(widget.email, _password1Ctrl.text);
    var network1 = UserNetwork();
    UserModel userData = result ? await network1.getUserData() : null;
    userData != null ? onboardingCheck(userData) : null;
  }

  forgetresetpassword() async {
    setState(() {
      loading = true;
    });
    var result = await ForgetPassword().forgetResetPassword(
        widget.otpdata.otp_id, widget.otpdata.user_id, _password1Ctrl.text);
    Routes.sailor(Routes.success);
  }

  Widget commonPart(BuildContext context, {bool onWeb = false}) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width / 2;

    var _textStyleforEnterNo =
        TextStyle(color: Colors.black, fontSize: 16, fontFamily: "lato");
    var _textForEnterMobile = TextStyle(
        color: MainTheme.enterTextColor,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");
    var _textStyleforAlreadyHave =
        TextStyle(color: Colors.black, fontSize: 14, fontFamily: "lato");

    var _textStyleforLogin = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontFamily: "lato");

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter your New Password",
            style: onWeb ? _textStyleforEnterNo : _textForEnterMobile,
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _password1Ctrl,
            cursorColor: Colors.pink,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.emailAddress,
            obscureText: obscureText,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () {
                    print("you clicked");
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
              hintText: 'New password',
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
                    color: Color(0xffC4C4C4),
                    width: 1,
                    style: BorderStyle.solid),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pink, width: 1, style: BorderStyle.solid),
              ),
            ),
            validator: (val) {
              if (val.isEmpty) {
                return "Please enter password";
              }
              RegExp regex = new RegExp(passwordpattern.toString());
              if (!regex.hasMatch(val)) {
                return 'password must be have at least 8 characters \nlong 1 uppercase & 1 lowercase character\n1 number';
              }
              return null;
            },
          ),
          SizedBox(height: 25.h),

          Text(
            "Re-enter your New Password",
            style: onWeb ? _textStyleforEnterNo : _textForEnterMobile,
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _password2Ctrl,
            cursorColor: Colors.pink,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.emailAddress,
            obscureText: obscureText1,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      if (obscureText1 == false) {
                        obscureText1 = true;
                      } else {
                        obscureText1 = false;
                      }
                    });
                  },
                  child: Container(
                      margin: EdgeInsetsDirectional.only(end: 10),
                      child: !obscureText1
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
              hintText: 'Re-enter the new password',
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
                    color: Color(0xffC4C4C4),
                    width: 1,
                    style: BorderStyle.solid),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pink, width: 1, style: BorderStyle.solid),
              ),
            ),
            validator: (val) {
              if (val.isEmpty) {
                return "Please enter password";
              }
              if (val != _password1Ctrl.text) {
                return 'Password does not match';
              }

              RegExp regex = new RegExp(passwordpattern.toString());
              if (!regex.hasMatch(val)) {
                return 'password must be have at least 8 characters \nlong 1 uppercase & 1 lowercase character\n1 number';
              }
              return null;
            },
          ),
          SizedBox(height: 50.h),

          // Container(
          //   padding: EdgeInsetsDirectional.only(
          //     top: _height / 18,
          //     end: _width * 0.12,
          //     start: _width * 0.12,
          //   ),
          //   child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Expanded(
          //             child: Text(
          //               "Once you hit continue, you’ll receive a verification code. The verified email can be used to log in",
          //               style: TextStyle(
          //                   color: Colors.grey,
          //                   fontSize: 14,
          //                   fontFamily: "lato"),
          //               textAlign: TextAlign.center,
          //               maxLines: 2,
          //               overflow: TextOverflow.ellipsis,
          //             )),
          //       ]),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                name: loading ? "Loading.." : "Next",
                gradient: MainTheme.loginBtnGradient,
                height: 35,
                fontSize: 14,
                width: 150,
                active: true,
                isLoading: loading,
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (widget.isforget) {
                      forgetresetpassword();
                    } else {
                      goToCreateProfilePage();
                    }
                  }
                },
              ),
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
                      child: Text("Create the password",
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
                      // Container(
                      //     width: _width / 1.5,
                      //     child: Row(children: [
                      //       Expanded(
                      //         child: Text(
                      //           "Spark is the only dating app that connects people based on interests, beliefs and profession.",
                      //           style: _textStyleforSentence,
                      //           textAlign: TextAlign.start,
                      //         ),
                      //       )
                      //     ])),
                    ]),
                commonPart(context, onWeb: true),
                Container(
                  height: 110,
                  width: _width,
                ),
                // Container(
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //       Container(
                //           child: Text("Already have account?",
                //               style: _textStyleforAlreadyHave)),
                //       Text("Log In", style: _textStyleforLogin),
                //     ])),
              ],
            )))
      ]),
    ));
  }
}
