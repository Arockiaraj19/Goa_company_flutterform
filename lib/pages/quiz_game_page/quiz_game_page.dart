import 'package:dating_app/pages/quiz_game_page/widgets/hart_view_icons.dart';
import 'package:dating_app/pages/quiz_game_page/widgets/question_box.dart';
import 'package:dating_app/pages/quiz_game_page/widgets/question_icons.dart';
import 'package:dating_app/pages/quiz_game_page/widgets/quiz_app_bar.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuizGamePage extends StatefulWidget {
  QuizGamePage({Key key}) : super(key: key);

  @override
  _QuizGamePageState createState() => _QuizGamePageState();
}

class _QuizGamePageState extends State<QuizGamePage> {
  TabController _controller;
  int _selectedIndex = 0;
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
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: MainTheme.backgroundGradient),
            child: Column(children: [
              QuizAppBar(),
              Container(
                margin: EdgeInsetsDirectional.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                ),
                height:
                    MediaQuery.of(context).size.height - (kToolbarHeight) - 57,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      child: Container(
                          margin: EdgeInsetsDirectional.only(
                            top: 20,
                          ),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width - 70,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 7,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return HartViewicons(
                                            onTap: () {},
                                          );
                                        })),
                                Container(
                                    child: CircularPercentIndicator(
                                        linearGradient:
                                            MainTheme.backgroundGradient,
                                        animation: true,
                                        backgroundColor: Colors.grey[50],
                                        animationDuration: 1200,
                                        radius: 40.0,
                                        lineWidth: 6,
                                        percent: 1,
                                        center: Container(child: Text('50'))))
                              ]))),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              QuestionBox(),
                              Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 3,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Questionicons();
                                      }))
                            ],
                          );
                        }),
                  )
                ])),
              )
            ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            padding: EdgeInsetsDirectional.only(end: 20, start: 20, bottom: 10),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: CircleAvatar(
                        backgroundColor: MainTheme.primaryColor,
                        radius: 20,
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                        ))),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 1, color: MainTheme.primaryColor),
                  ),
                  child: MaterialButton(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: Text(
                      'Submit',
                      style:
                          TextStyle(height: 2, color: MainTheme.primaryColor),
                    ),
                    textColor: Colors.red,
                    onPressed: () {
                      goToQuizgamePage();
                    },
                  ),
                ),
                Container(
                    child: CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        radius: 20,
                        child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            )))),
              ],
            )),
      ),
    );
  }

  goToQuizgamePage() {
    Routes.sailor(
      Routes.quizSucessPage,
    );
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height - (kToolbarHeight);
    var _width = MediaQuery.of(context).size.width - 30;

    return Scaffold(
        body: BaseLayout(
            navigationRail: NavigationMenu(
              currentTabIndex: 0,
            ),
            body: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  color: Colors.grey[50],
                ),
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: MainTheme.appBarColor,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    actions: [
                      Container(
                          margin: EdgeInsetsDirectional.only(
                            end: 20,
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications_outlined,
                                color: Colors.grey,
                                // size: 20,
                              )))
                    ],
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight - 50),
                        child: PreferredSize(
                            preferredSize:
                                const Size.fromHeight(kToolbarHeight),
                            child: Row(children: [
                              Container(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 10, bottom: 10),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    radius: 10,
                                    child: Icon(
                                      Icons.keyboard_arrow_left,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  )),
                              Container(
                                  padding: EdgeInsetsDirectional.only(
                                      start: _width / 7, bottom: 10),
                                  child: Text(
                                    "Matching Buddy",
                                    style: MainTheme.secondaryHeading,
                                  )),
                            ]))),
                  ),
                  body: SingleChildScrollView(
                      child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 1.0,
                            offset: Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                  // width: MediaQuery.of(context).size.width - 70,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 7,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return HartViewicons(
                                          onTap: () {},
                                        );
                                      })),
                              Container(
                                width: _width / 30,
                                height: _height / 20,
                              ),
                              Container(
                                  child: CircularPercentIndicator(
                                      linearGradient:
                                          MainTheme.backgroundGradient,
                                      animation: true,
                                      backgroundColor: Colors.grey[50],
                                      animationDuration: 1200,
                                      radius: 40.0,
                                      lineWidth: 6,
                                      percent: 1,
                                      center: Container(child: Text('50')))),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsetsDirectional.only(
                                      end: 5, start: 5),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                                    ),
                                  )),
                              CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                radius: 10,
                                child: Icon(
                                  Icons.forward,
                                  color: MainTheme.primaryColor,
                                  size: 12,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      margin: EdgeInsetsDirectional.only(
                                          end: 10, start: 5),
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: NetworkImage(
                                          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                                        ),
                                      )),
                                  Container(
                                    margin: EdgeInsetsDirectional.only(
                                        top: 2, bottom: 2),
                                    child: Text(
                                      "Adrianne Rico",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                QuestionBox(),
                                Container(
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 3,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Questionicons();
                                        }))
                              ],
                            );
                          }),
                    )
                  ])),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Container(
                      padding: EdgeInsetsDirectional.only(
                          end: 20, start: 20, bottom: 10),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              child: CircleAvatar(
                                  backgroundColor: MainTheme.primaryColor,
                                  radius: 20,
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Colors.white,
                                  ))),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  width: 1, color: MainTheme.primaryColor),
                            ),
                            child: MaterialButton(
                              padding: EdgeInsets.only(left: 50, right: 50),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    height: 2, color: MainTheme.primaryColor),
                              ),
                              textColor: Colors.red,
                              onPressed: () {
                                goToQuizgamePage();
                              },
                            ),
                          ),
                          Container(
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  radius: 20,
                                  child: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.white,
                                      )))),
                        ],
                      )),
                ))));
  }
}
