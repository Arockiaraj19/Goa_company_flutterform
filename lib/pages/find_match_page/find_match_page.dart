import 'dart:async';

import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/shared/helpers/google_map.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes.dart';

class FindMatchPage extends StatefulWidget {
  FindMatchPage({Key key}) : super(key: key);

  @override
  _FindMatchPageState createState() => _FindMatchPageState();
}

class _FindMatchPageState extends State<FindMatchPage> {
  List<dynamic> location = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveLoginStatus(2);
    getLoc();
  }

  getLoc() async {
    try {
      location = await GoogleMapDisplay().createState().currentLocation();
    } catch (e) {
      print(e);
    }

    var network = UserNetwork();
    var userData = {
      "latitude": location[0] == null ? 0.toString() : location[0].toString(),
      "longitude": location[1] == null ? 0.toString() : location[1].toString(),
    };
    print("patch user data");
    print(userData);

    UserModel result = await network.patchUserData(userData);
    goToHomePage();
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Text(""),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey[50],
          ),
          body: InkWell(
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                margin: EdgeInsetsDirectional.only(start: 10, end: 10),
                width: MediaQuery.of(context).size.width,
                color: MainTheme.primaryColor,
                height: 2,
              ),
              Container(
                  margin:
                      EdgeInsetsDirectional.only(start: 60, end: 60, top: 20),
                  child: Row(children: [
                    Expanded(
                        child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Now",
                          style: TextStyle(
                              color: MainTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(45),
                              fontFamily: "Inter"),
                          children: [
                            TextSpan(
                              text: " let’s perfect that profile ",
                              style: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(45),
                                  fontFamily: "Inter"),
                            ),
                            TextSpan(
                              text: "of yours!",
                              style: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(45),
                                  fontFamily: "Inter"),
                            )
                          ]),
                    )),
                  ])),
              SizedBox(height: ScreenUtil().setHeight(40)),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    child: Image.asset("assets/images/searching-radius.gif",
                        height: MediaQuery.of(context).size.height / 2.3,
                        width: MediaQuery.of(context).size.width)),
              ]),
              SizedBox(height: ScreenUtil().setHeight(40)),
              Container(
                  margin:
                      EdgeInsetsDirectional.only(start: 90, end: 90, top: 20),
                  child: Row(children: [
                    Expanded(
                        child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Find Your",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(45),
                              fontFamily: "Inter"),
                          children: [
                            TextSpan(
                              text: " Parnter ",
                              style: TextStyle(
                                  color: MainTheme.primaryColor,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(45),
                                  fontFamily: "Inter"),
                            ),
                            TextSpan(
                              text: "With Us",
                              style: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(45),
                                  fontFamily: "Inter"),
                            )
                          ]),
                    )),
                  ])),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Container(
                        margin: EdgeInsetsDirectional.only(top: 20),
                        child: Text(
                          "Join us and socialize with million of people",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil().setSp(28),
                              fontFamily: "lato"),
                        ))
                  ])),
              SizedBox(height: ScreenUtil().setHeight(30)),
            ])),
          )),
    );
  }

  goToHomePage() {
    Routes.sailor(Routes.homePage);
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    var _textStyleforSpark = TextStyle(
        color: MainTheme.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil().setSp(30),
        fontFamily: "lato");

    var _textStyleforMatchText = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil().setSp(15),
        fontFamily: "lato");

    var _textStyleforSentence = TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        height: 2,
        fontSize: ScreenUtil().setSp(10),
        fontFamily: "lato");

    var _textStyleSubHeading = TextStyle(
        color: Colors.black,
        fontSize: ScreenUtil().setSp(12),
        fontFamily: "lato");

    var _textStyleContent = TextStyle(
        color: Colors.black,
        fontSize: ScreenUtil().setSp(7),
        fontFamily: "lato");

    var _textStyleforAlreadyHave = TextStyle(
        color: Colors.black,
        fontSize: ScreenUtil().setSp(10),
        fontFamily: "lato");

    var _textStyleforLogin = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: ScreenUtil().setSp(10),
        fontFamily: "lato");

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: _height / 39,
            width: _width,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                child: Image.asset(
              "assets/images/searching-radius.gif",
              height: _height / 1.5,
              width: _width,
            )),
          ]),
          Container(
            height: _height / 39,
            width: _width,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text("Find Your",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(13),
                              fontFamily: "Inter")),
                      Text(
                        " Parnter ",
                        style: TextStyle(
                            color: MainTheme.primaryColor,
                            // fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(13),
                            fontFamily: "Inter"),
                      ),
                    ],
                  ),
                  Text(
                    "With Us",
                    style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(13),
                        fontFamily: "Inter"),
                  )
                ],
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                margin: EdgeInsetsDirectional.all(10),
                child: Text(
                  "Join us and socialize with million of people",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(8),
                      fontFamily: "lato"),
                ))
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                name: "Find Your Match",
                gradient: MainTheme.loginBtnGradient,
                fontSize: ScreenUtil().setSp(10),
                height: 35,
                borderRadius: BorderRadius.circular(5),
                width: _width / 8,
                active: true,
                color: Colors.white,
              ),
            ],
          ),
        ]),
      ),
    ));
  }
}
