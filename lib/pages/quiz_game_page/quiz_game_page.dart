import 'package:dating_app/providers/game_provider.dart';
import 'package:dating_app/shared/helpers/loadingLottie.dart';
import 'package:dating_app/shared/helpers/websize.dart';
import 'package:dating_app/shared/widgets/error_card.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:dating_app/models/question_model.dart';
import 'package:dating_app/networks/games_network.dart';
import 'package:dating_app/pages/quiz_game_page/widgets/hart_view_icons.dart';
import 'package:dating_app/pages/quiz_game_page/widgets/question_box.dart';
import 'package:dating_app/pages/quiz_game_page/widgets/question_icons.dart';
import 'package:dating_app/pages/quiz_game_page/widgets/quiz_app_bar.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class FuntionModel {
  String game;
  String id;
  String index;
  String type;
  String playid;
  FuntionModel(
    this.game,
    this.id,
    this.index,
    this.type,
    this.playid,
  );
}

class QuizGamePage extends StatefulWidget {
  String questionid;
  String playid;
  String user1;
  String user2;
  bool istrue;
  String user1name;
  String user2name;
  QuizGamePage(
      {this.questionid,
      this.playid,
      this.user1,
      this.user2,
      this.istrue,
      this.user1name,
      this.user2name});

  @override
  _QuizGamePageState createState() => _QuizGamePageState();
}

class _QuizGamePageState extends State<QuizGamePage> {
  @override
  void initState() {
    super.initState();
    getdata();
    fill();
  }

  List<bool> heartbool = [];
  List<Getquestion> questions;
  fill() async {
    await context
        .read<GameProvider>()
        .getQuestions(widget.questionid, widget.playid);
    questions = context.read<GameProvider>().gameData;
    heartbool = [];
    for (var i = 0; i < questions.length; i++) {
      heartbool.add(false);
    }
    playid = widget.playid;
  }

  getdata() {
    Games().getallgames();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, data, child) {
      return data.gameState == GameState.Loaded
          ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 769) {
                return _buildPhone(false);
              } else {
                return _buildWeb();
              }
            })
          : data.gameState == GameState.Error
              ? ErrorCard(
                  text: data.errorText,
                  ontab: () => NavigateFunction()
                      .withqueryReplace(Navigate.quizGamePage))
              : LoadingLottie();
    });
  }

  PageController controller = PageController();
  int position = 0;
  Map clikeddata = {};
  String option;
  FuntionModel answer;
  String playid;
  Widget _buildPhone(onweb) {
    return WillPopScope(
      onWillPop: () async {
        try {
          bool istrue = await Games().leavegame(widget.playid);
          if (istrue) {
            Navigator.pop(context);
          }
        } catch (e) {
          print(e);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(gradient: MainTheme.backgroundGradient),
              child: Column(children: [
                QuizAppBar(widget.user1, widget.user2, onweb, widget.playid),
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
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: questions.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return HartViewicons(
                                                    onweb: onweb,
                                                    istrue: heartbool[index],
                                                    len: questions.length,
                                                    onTap: () {},
                                                    controller: controller,
                                                    index: index,
                                                    position: position,
                                                  );
                                                })),
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
                                              percent:
                                                  ((100 / questions.length) *
                                                          position) /
                                                      100.round(),
                                              center: Container(
                                                  child: Text(((100 /
                                                              questions
                                                                  .length) *
                                                          position)
                                                      .round()
                                                      .toString()))))
                                    ]))),
                        Container(
                          height: onweb ? 300 : 450,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                width: 1,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                          width: double.infinity,
                          child: PageView.builder(
                              allowImplicitScrolling: false,
                              physics: new NeverScrollableScrollPhysics(),
                              controller: controller,
                              scrollDirection: Axis.horizontal,
                              itemCount: questions.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    QuestionBox(
                                      question: questions[index].question,
                                      onWeb: onweb,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            answer = FuntionModel(
                                                questions[index].game,
                                                questions[index].id,
                                                1.toString(),
                                                questions[index]
                                                    .type
                                                    .toString(),
                                                widget.playid);
                                            setState(() {
                                              option = questions[index].option1;
                                              playid = widget.playid;
                                            });
                                          },
                                          child: Questionicons(
                                            option: option,
                                            answer: questions[index].option1,
                                            index: "A",
                                            onWeb: onweb,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            answer = FuntionModel(
                                                questions[index].game,
                                                questions[index].id,
                                                2.toString(),
                                                questions[index]
                                                    .type
                                                    .toString(),
                                                widget.playid);
                                            setState(() {
                                              option = questions[index].option2;
                                              playid = widget.playid;
                                            });
                                            // Games().answerquestion(
                                            //     questions[index].game,
                                            //     questions[index].id,
                                            //     2.toString(),
                                            //     questions[index].type
                                            //         .toString(),
                                            //     widget.playid);
                                          },
                                          child: Questionicons(
                                            option: option,
                                            answer: questions[index].option2,
                                            index: "B",
                                            onWeb: onweb,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            answer = FuntionModel(
                                                questions[index].game,
                                                questions[index].id,
                                                3.toString(),
                                                questions[index]
                                                    .type
                                                    .toString(),
                                                widget.playid);
                                            setState(() {
                                              option = questions[index].option3;
                                              playid = widget.playid;
                                            });
                                          },
                                          child: Questionicons(
                                            option: option,
                                            answer: questions[index].option3,
                                            index: "C",
                                            onWeb: onweb,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            answer = FuntionModel(
                                                questions[index].game,
                                                questions[index].id,
                                                4.toString(),
                                                questions[index]
                                                    .type
                                                    .toString(),
                                                widget.playid);
                                            setState(() {
                                              option = questions[index].option4;
                                              playid = widget.playid;
                                            });
                                          },
                                          child: Questionicons(
                                            option: option,
                                            answer: questions[index].option4,
                                            index: "D",
                                            onWeb: onweb,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              }),
                        )
                      ]),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding:
                          onweb ? EdgeInsets.all(10) : EdgeInsets.all(40.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (answer == null) {
                                showtoast("please select answer");
                              } else {
                                try {
                                  bool result = await Games().answerquestion(
                                      answer.game,
                                      answer.id,
                                      answer.index,
                                      answer.type,
                                      answer.playid);
                                  if (result) {
                                    answer = null;
                                    option = null;

                                    setState(() {
                                      controller.nextPage(
                                          duration: Duration(milliseconds: 100),
                                          curve: Curves.easeIn);
                                      heartbool[position] = true;
                                      position += 1;
                                    });
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                              if (position == questions.length) {
                                if (widget.istrue) {
                                  showAlertDialog(context);
                                  await Future.delayed(Duration(seconds: 1));
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else {
                                  int score = await Games().getscrore(playid);
                                  NavigateFunction().withquery(
                                    Navigate.quizSucessPage +
                                        "?user1image=${widget.user1}&user2image=${widget.user2}&user1name=${widget.user1name}&user2name=${widget.user2name}&score=${score}&length=${questions.length}",
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: onweb ? 180 : 450.r,
                              height: onweb ? 45 : 150.r,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  gradient: option == null
                                      ? null
                                      : MainTheme.backgroundGradient,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: MainTheme.primaryColor)),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: option == null
                                      ? MainTheme.primaryColor
                                      : Colors.white,
                                  fontSize: onweb ? inputFont : 45.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       controller.nextPage(
                          //           duration: Duration(milliseconds: 1000),
                          //           curve: Curves.easeIn);
                          //       heartbool[position] = true;
                          //       position += 1;
                          //     });
                          //     print("initial page");
                          //     print(controller.initialPage);
                          //     print(controller.page);
                          //     print(controller.offset);
                          //   },
                          //   child: Container(
                          //     height: 150.r,
                          //     width: 150.r,
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: Colors.grey[400],
                          //     ),
                          //     child: Icon(
                          //       Icons.arrow_forward_ios,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                )
              ])),
        ),
      ),
    );
  }

  goToQuizgamePage() {
    NavigateFunction().withquery(Navigate.quizSucessPage);
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      title: Text(
        "Success",
        style: TextStyle(
          color: MainTheme.primaryColor,
        ),
      ),
      content: Text("Game play requested"),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height - (kToolbarHeight);
    var _width = MediaQuery.of(context).size.width - 30;

    return Scaffold(
        body: BaseLayout(
            navigationRail: NavigationMenu(
              currentTabIndex: 1,
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
                child: _buildPhone(true))));
  }

  Scaffold webpart(double _width, double _height) {
    return Scaffold(
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
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Row(children: [
                  Container(
                      padding:
                          EdgeInsetsDirectional.only(start: 10, bottom: 10),
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
                          itemBuilder: (BuildContext context, int index) {
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
                          linearGradient: MainTheme.backgroundGradient,
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
                      margin: EdgeInsetsDirectional.only(end: 5, start: 5),
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
                          margin: EdgeInsetsDirectional.only(end: 10, start: 5),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                            ),
                          )),
                      Container(
                        margin: EdgeInsetsDirectional.only(top: 2, bottom: 2),
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
                            itemBuilder: (BuildContext context, int index) {
                              return Questionicons();
                            }))
                  ],
                );
              }),
        )
      ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          padding: EdgeInsetsDirectional.only(end: 20, start: 20, bottom: 10),
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
                  border: Border.all(width: 1, color: MainTheme.primaryColor),
                ),
                child: MaterialButton(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: Text(
                    'Submit',
                    style: TextStyle(height: 2, color: MainTheme.primaryColor),
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
    );
  }
}
