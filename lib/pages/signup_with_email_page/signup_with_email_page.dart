import 'package:dating_app/models/forgetresponse_model.dart';
import 'package:dating_app/models/otp_model.dart';
import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/networks/forgetpassword_network.dart';
import 'package:dating_app/networks/signup_network.dart';
import 'package:dating_app/shared/helpers/regex_pattern.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/Forminput.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routes.dart';

class SignUpWithEmailPage extends StatefulWidget {
  final bool isforget;
  SignUpWithEmailPage({this.isforget});

  @override
  _SignUpWithEmailPageState createState() => _SignUpWithEmailPageState();
}

class _SignUpWithEmailPageState extends State<SignUpWithEmailPage> {
  @override
  void initState() {
    super.initState();
    print("sign up page kkulla enter aana enna boolean varuthu");
    print(widget.isforget);
  }

  TextEditingController _emailCtrl = TextEditingController();
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.r, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text("Continue with Email", style: _textStyleforHeading),
              SizedBox(
                height: 20.h,
              ),
              Container(
                  height: 700.r,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/signupWithEmail.png",
                    fit: BoxFit.fill,
                  )),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              commonPart(context, onWeb: false)
            ],
          ),
        ),
      ),
    ));
  }

  gotoForgetOtpPage() async {
    setState(() {
      loading = true;
    });

    var network = ForgetPassword();

    ResponseForgetOtp result = await network.forgetGetOtp(_emailCtrl.text);
    showtoast(result.msg.toString());
    OtpModel data = OtpModel.fromJson({
      "value": _emailCtrl.text,
      "id": result.user_id,
      "isMob": false,
      "isSignUp": true
    });
    Routes.sailor(Routes.otpPage, params: {"otpData": data, "isforget": true});
  }

  goToOtpPage() async {
    setState(() {
      loading = true;
    });
    var network = EmailSignUpNetwork();
    ResponseData result = await network.verifyEmailForSignup(_emailCtrl.text);
    showtoast(result.msg.toString());
    OtpModel data = OtpModel.fromJson(
        {"value": _emailCtrl.text, "isMob": false, "isSignUp": true});
    result.statusDetails == 1
        ? Routes.sailor(Routes.otpPage,
            params: {"otpData": data, "isforget": false})
        : result.statusDetails == 2
            ? Routes.sailor(Routes.addingPasswordPage,
                params: {"email": _emailCtrl.text})
            : Routes.sailor(Routes.loginPage);
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
            height: 50.h,
          ),
          Align(
            alignment: Alignment.center,
            child: loading
                ? CircularProgressIndicator()
                : GradientButton(
                    height: 110.w,
                    fontSize: 40.sp,
                    name: "Next",
                    gradient: MainTheme.loginwithBtnGradient,
                    active: true,
                    color: Colors.white,
                    isLoading: loading,
                    width: 500.w,
                    borderRadius: BorderRadius.circular(20.sp),
                    fontWeight: FontWeight.w500,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (widget.isforget) {
                          gotoForgetOtpPage();
                        } else {
                          goToOtpPage();
                        }
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
