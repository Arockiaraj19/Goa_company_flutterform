import 'package:dating_app/models/matchuser_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PerfectMatchPage extends StatefulWidget {
  final UserModel user1;
  final MatchUser user2;
  PerfectMatchPage({this.user1, this.user2});

  @override
  _PerfectMatchPageState createState() => _PerfectMatchPageState();
}

class _PerfectMatchPageState extends State<PerfectMatchPage> {
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 10,
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.black,
                          size: 25,
                        ),
                      ))),
              titleSpacing: 0,
              actions: [
                Container(
                  padding: EdgeInsetsDirectional.only(end: 10),
                  child: Image.asset(
                    'assets/images/3dot.png',
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(top: 20),
                    child: Text(
                      "Congratulations",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: "Nunito"),
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "It’s a perfect ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Nunito"),
                      ),
                    ),
                    Stack(children: [
                      Positioned(
                          child: RotationTransition(
                              turns: new AlwaysStoppedAnimation(165 / 360),
                              child: Container(
                                  height: 30,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    gradient: MainTheme.loginBtnGradient,
                                  )))),
                      Container(
                        child: Text(
                          "match",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Nunito"),
                        ),
                      ),
                    ]),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 15,
                  // color: Colors.amber,
                  width: MediaQuery.of(context).size.width,
                ),
                Stack(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/gif_heart-beat.gif",
                          height: 300,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                              padding: EdgeInsetsDirectional.only(start: 50),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  widget.user1.identificationImage,
                                ),
                                radius: 40,
                              )),
                          Container(
                              child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.user2.user2.identificationImage,
                            ),
                            radius: 40,
                          ))
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(top: 100),
                        child: Text(
                          widget.user2.user2.firstname,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: "Nunito"),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 40, end: 40, top: 220),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Shh! Here’s some sample cheat codes hack your babe’s heart",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "Nunito"),
                            ),
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 40, end: 40, top: 300),
                            child: Text(
                              " Oh, there you are! I’ve been looking for you for years!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontFamily: "Nunito"),
                            )),
                      ),
                    ],
                  ),
                ]),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // GradientButton(
                    //   height: MediaQuery.of(context).size.height / 20,
                    //   name: "Play match",
                    //   gradient: MainTheme.loginBtnGradient,
                    //   active: true,
                    //   color: Colors.white,
                    //   width: ScreenUtil().setWidth(350),
                    //   fontWeight: FontWeight.bold,
                    //   borderRadius: BorderRadius.circular(5),
                    //   onPressed: () {
                    //     goToQuizgamePage();
                    //   },
                    // ),
                    GradientButton(
                      height: MediaQuery.of(context).size.height / 20,
                      name: "Say “Hi”",
                      gradient: MainTheme.loginBtnGradient,
                      active: true,
                      color: Colors.white,
                      width: ScreenUtil().setWidth(400),
                      borderRadius: BorderRadius.circular(5),
                      fontWeight: FontWeight.bold,
                      onPressed: () async {
                        String groupid = await ChatNetwork().createGroup(
                            widget.user2.user2.userid, widget.user1);
                        goToChatPage(
                            groupid,
                            widget.user2.user2.userid,
                            widget.user2.user2.identificationImage,
                            widget.user2.user2.firstname);
                      },
                    ),
                  ],
                ),
              ]),
            )));
  }

  goToChatPage(groupid, id, image, name) {
    Routes.sailor(Routes.chattingPage,
        params: {"groupid": groupid, "id": id, "image": image, "name": name});
  }

  goToQuizgamePage() {
    Routes.sailor(
      Routes.quizGamePage,
    );
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width - 30;
    return Scaffold(
        body: BaseLayout(
            navigationRail: NavigationMenu(
              currentTabIndex: 1,
            ),
            body: Container(
                color: Colors.grey[200],
                padding: EdgeInsetsDirectional.only(start: 2),
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    actions: [
                      Container(
                          margin: EdgeInsetsDirectional.only(
                              top: 5, end: 20, bottom: 5),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications_outlined,
                                color: Colors.grey,
                                size: 20,
                              )))
                    ],
                    elevation: 0,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsetsDirectional.only(top: 20),
                                child: Text(
                                  "Congratulations",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      fontFamily: "Nunito"),
                                ),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "It’s a perfect ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: "Nunito"),
                              ),
                            ),
                            Stack(children: [
                              Positioned(
                                  child: RotationTransition(
                                      turns:
                                          new AlwaysStoppedAnimation(165 / 360),
                                      child: Container(
                                          height: 30,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            gradient:
                                                MainTheme.loginBtnGradient,
                                          )))),
                              Container(
                                child: Text(
                                  "match",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Nunito"),
                                ),
                              ),
                            ]),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 15,
                          // color: Colors.amber,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Stack(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/images/gif_heart-beat.gif",
                                  height: _height / 2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsetsDirectional.only(start: 50),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                                        ),
                                        radius: 40,
                                      )),
                                  Container(
                                      child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      "https://us.123rf.com/450wm/vadymvdrobot/vadymvdrobot1803/vadymvdrobot180303570/97983244-happy-asian-woman-in-t-shirt-bites-eyeglasses-and-looking-at-the-camera-over-grey-background.jpg?ver=6",
                                    ),
                                    radius: 40,
                                  ))
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsetsDirectional.only(top: 100),
                                child: Text(
                                  "Adrianne Rico, 22",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: "Nunito"),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              padding: EdgeInsetsDirectional.only(
                                  start: 40, end: 40, top: 220),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Shh! Here’s some sample cheat codes hack your babe’s heart",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: "Nunito"),
                                    ),
                                  ),
                                ],
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsetsDirectional.only(
                                        start: 40, end: 40, top: 300),
                                    child: Text(
                                      " Oh, there you are! I’ve been looking for you for years!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontFamily: "Nunito"),
                                    )),
                              ),
                            ],
                          ),
                          // Container(
                          //   height: MediaQuery.of(context).size.height / 9,
                          //   // color: Colors.amber,
                          //   width: MediaQuery.of(context).size.width,
                          // ),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GradientButton(
                              height: 40,
                              name: "Play match",
                              gradient: MainTheme.loginBtnGradient,
                              active: true,
                              color: Colors.white,
                              width: _width / 8,
                              fontWeight: FontWeight.w600,
                              borderRadius: BorderRadius.circular(5),
                              fontSize: 12,
                              onPressed: () {
                                goToQuizgamePage();
                              },
                            ),
                            GradientButton(
                              height: 40,
                              name: "Say “Hi”",
                              gradient: MainTheme.loginBtnGradient,
                              fontSize: 12,
                              active: true,
                              color: Colors.white,
                              width: _width / 8,
                              borderRadius: BorderRadius.circular(5),
                              fontWeight: FontWeight.w600,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
