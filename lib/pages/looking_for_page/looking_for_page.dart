import 'dart:async';

import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/pages/create_profile_page/widget/gender_card.dart';
import 'package:dating_app/pages/looking_for_page/widgets/gender_list.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes.dart';

class LookingForPage extends StatefulWidget {
  LookingForPage({Key key}) : super(key: key);

  @override
  _LookingForPageState createState() => _LookingForPageState();
}

class _LookingForPageState extends State<LookingForPage> {
  bool loading = false;
  int selectedMenuIndex = 0;

  List<Map<String, dynamic>> itemGender = [
    {
      "gender": "Male",
      "image": "assets/icons/male.png",
      'isActive': true,
    },
    {
      "gender": "Female",
      "image": "assets/icons/female.png",
      'isActive': false,
    },
    {
      "gender": "More",
      "image": "null",
      'isActive': false,
    }
  ];

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

    var _textStyleforLookingFor = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w500,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    return SafeArea(
        child: Scaffold(
            bottomSheet: Container(
              height: 100,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientButton(
                      height: 110.w,
                      fontSize: 40.sp,
                      width: 500.w,
                      name: loading ? "Saving.." : "Continue",
                      gradient: MainTheme.loginBtnGradient,
                      active: true,
                      isLoading: loading,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      onPressed: () {
                        goToParterTypePage();
                      }),
                ],
              ),
            ),
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
                  child: Text("Looking for", style: _textStyleforHeading)),
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 10, end: 10),
                    width: 250,
                    color: MainTheme.primaryColor,
                    height: 2,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 10, end: 10),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade300,
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsetsDirectional.only(top: 40, bottom: 30),
                      child: Text("Who are you looking for?",
                          style: _textStyleforLookingFor)),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(60)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.588,
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: itemGender.length,
                      itemBuilder: (BuildContext context, int index) {
                        dynamic item = itemGender[index];
                        return Container(
                            height: 80,
                            width: 60,
                            child: GenderCard(
                              name: item["gender"],
                              image: item["image"],
                              isActive: item["isActive"],
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    selectedMenuIndex = index;
                                    itemGender = itemGender
                                        .map<Map<String, dynamic>>(
                                            (Map<String, dynamic> item) {
                                      item['isActive'] = false;
                                      return item;
                                    }).toList();
                                    itemGender[index]['isActive'] = true;
                                  });
                                }
                              },
                            ));
                      })),
            ]))));
  }

  goToParterTypePage() async {
    setState(() {
      loading = true;
    });
    try {
      var network = UserNetwork();
      var userData = {"sexual_orientation": selectedMenuIndex.toString()};

      UserModel result = await network.patchUserData(userData);
      result != null ? onboardingCheck(result) : null;
    } catch (e) {
      offLoading();
    }
  }

  offLoading() {
    setState(() {
      loading = false;
    });
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width / 2;

    var _textStyleforSpark = TextStyle(
        color: MainTheme.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 28,
        fontFamily: "lato");

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
              end: _width / 30,
              start: _width / 30,
            ),
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.black,
                        size: ScreenUtil().setWidth(20),
                      )),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                    padding: EdgeInsetsDirectional.only(
                      end: _width / 6,
                      start: _width / 6,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Looking for",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: MainTheme.leadingHeadings,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: "Inter"),
                            )),
                          ],
                        ),
                        Container(
                          height: _height / 45,
                          width: _width,
                        ),
                        Row(
                          children: [
                            Container(
                              width: _width / 2,
                              color: MainTheme.primaryColor,
                              height: 2,
                            ),
                          ],
                        ),
                        Container(
                          width: _width,
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        Container(
                          height: _height / 18,
                          width: _width,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              "Who are you looking for?",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MainTheme.leadingHeadings,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  fontFamily: "Inter"),
                            )),
                          ],
                        ),
                        Container(
                          height: _height / 15,
                          width: _width,
                        ),
                        Container(
                          width: _width / 2.5,
                          child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemGender.length,
                              itemBuilder: (BuildContext context, int index) {
                                dynamic item = itemGender[index];
                                return Container(
                                    height: 80,
                                    width: 60,
                                    child: GenderCard(
                                      name: item["gender"],
                                      image: item["image"],
                                      isActive: item["isActive"],
                                      onTap: () {
                                        if (mounted) {
                                          setState(() {
                                            selectedMenuIndex = index;
                                            itemGender = itemGender.map<
                                                    Map<String, dynamic>>(
                                                (Map<String, dynamic> item) {
                                              item['isActive'] = false;
                                              return item;
                                            }).toList();
                                            itemGender[index]['isActive'] =
                                                true;
                                          });
                                        }
                                      },
                                    ));
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientButton(
                              name: loading ? "Saving.." : "Continue",
                              gradient: MainTheme.loginBtnGradient,
                              height: 35,
                              fontSize: 14,
                              isLoading: loading,
                              width: _width / 6,
                              active: true,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              onPressed: () {
                                goToParterTypePage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ))))
      ]),
    ));
  }
}
