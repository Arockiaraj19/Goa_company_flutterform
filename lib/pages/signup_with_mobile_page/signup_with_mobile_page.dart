import 'package:dating_app/models/country_code_model.dart';
import 'package:dating_app/networks/countrycode_network.dart';
import 'package:dating_app/networks/firebase_auth.dart';
import 'package:dating_app/networks/signup_network.dart';
import 'package:dating_app/shared/helpers/regex_pattern.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/input_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: onWeb
                  ? EdgeInsetsDirectional.only(
                      top: _height / 18,
                      bottom: _height / 25,
                      start: _width * 0.19,
                    )
                  : null,
              child: Text(
                "Enter your mobile number",
                style: onWeb ? _textStyleforEnterNo : _textForEnterMobile,
              )),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Container(
                width: 180.w,
                child: DropdownSearch<CountryCode>(
                  searchDelay: Duration(seconds: 0),
                  focusNode: myFocusNode,
                  mode: Mode.BOTTOM_SHEET,
                  dropdownButtonBuilder: (context) {
                    return Container();
                  },
                  dropdownBuilderSupportsNullItem: true,
                  dropDownButton: Icon(
                    Icons.arrow_back,
                    size: 0,
                  ),
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 18.0.w, bottom: 0.0.h, top: 0.0.h, right: 2.0.w),
                    hintText: "+91",
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
                          color: Colors.pink,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.pink,
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
                          color: Colors.pink,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value == null) {
                  //     return "* Required";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  showSearchBox: true,
                  isFilteredOnline: true,
                  itemAsString: (CountryCode u) => u.telephonecode,
                  onFind: (String filter) async {
                    myFocusNode.requestFocus();
                    List<CountryCode> response =
                        await CountryCodeNetwork().getcountrycode(filter);

                    return response;
                  },
                  onChanged: (CountryCode data) {},
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Container(
                  child: TextFormField(
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
                      contentPadding: EdgeInsets.only(
                          left: 18.0.w,
                          bottom: 12.0.h,
                          top: 12.0.h,
                          right: 2.0.w),
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
                            color: Colors.pink,
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.pink,
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
                            color: Colors.pink,
                            width: 1,
                            style: BorderStyle.solid),
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
                ),
              ),
            ],
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
    );
  }

  goToOtpPage() async {
    setState(() {
      loading = true;
    });
    var network = MobileSignUpNetwork();
    print(_numberCtrl.text);
    var result = await network.verifyMobileNoForSignup(_numberCtrl.text);
    result ? registerUser(_numberCtrl.text, context, true) : null;
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
              top: _height / 9,
              // bottom: _height / 9,
              end: _width / 30,
              start: _width / 30,
            ),
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

                Container(
                  height: _height / 8,
                  width: _width,
                ),
                _commonBuild(context, onWeb: true),
                Container(
                  height: 110,
                  width: _width,
                ),
              ],
            ))
      ]),
    ));
  }
}
