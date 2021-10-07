import 'package:dating_app/models/otp_model.dart';
import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/networks/signup_network.dart';
import 'package:dating_app/pages/otp_page/otp_page.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/input_field.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routes.dart';

class SignUpWithEmailPage extends StatefulWidget {
  SignUpWithEmailPage({Key key}) : super(key: key);

  @override
  _SignUpWithEmailPageState createState() => _SignUpWithEmailPageState();
}

class _SignUpWithEmailPageState extends State<SignUpWithEmailPage> {
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
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsetsDirectional.only(top: 40),
                    child: Text("Continue with Email",
                        style: _textStyleforHeading)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsetsDirectional.only(top: 20),
                    height: ScreenUtil().setHeight(100),
                    width: ScreenUtil().setWidth(180),
                    child: Image.asset(
                      "assets/images/mobileImage.png",
                      fit: BoxFit.fill,
                    ))
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(70),
            ),
            commonPart(context, onWeb: false)
          ],
        )),
      ),
    );
  }

  goToOtpPage() async {
    // setState(() {
    //   loading=true;
    // });
    var network = EmailSignUpNetwork();
    ResponseData result = await network.verifyEmailForSignup(_emailCtrl.text);
    showtoast(result.msg.toString());
    OtpModel data = OtpModel.fromJson(
        {"value": _emailCtrl.text, "isMob": false, "isSignUp": true});
    result.statusDetails == 1
        ? Routes.sailor(Routes.otpPage, params: {"otpData": data})
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsetsDirectional.only(
                    top: _height / 18,
                    bottom: _height / 50,
                    // end: _width * 0.19,
                    start: _width * 0.12,
                  ),
                  child: Text(
                    "Enter your Email id",
                    style: onWeb ? _textStyleforEnterNo : _textForEnterMobile,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ),
          Container(
            child: InputField(
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
              padding: onWeb
                  ? EdgeInsetsDirectional.only(
                      end: _width * 0.19,
                      start: _width * 0.19,
                    )
                  : EdgeInsetsDirectional.only(bottom: 10, end: 20, start: 20),
              validators: (String value) {
                if (value.isEmpty) return 'Required field';
                return null;
              },
              hintText: 'Enter your email',
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.only(
              top: _height / 18,
              end: _width * 0.12,
              start: _width * 0.12,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: Text(
                "Once you hit continue, you’ll receive a verification code. The verified email can be used to log in",
                style: TextStyle(
                    color: Colors.grey, fontSize: 14, fontFamily: "lato"),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
            ]),
          ),
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
                    goToOtpPage();
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
