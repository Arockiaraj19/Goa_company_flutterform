import 'package:dating_app/pages/chatting_page/chatting_page.dart';

import 'package:dating_app/pages/comment_page/widgets/dates_card_list.dart';

import 'package:dating_app/pages/comment_page/widgets/massage_card_list.dart';

import 'package:dating_app/pages/comment_page/widgets/request_card_list.dart';

import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/alert_widget.dart';
import 'package:dating_app/shared/widgets/bottom_bar.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    print("init socket state");
  }

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
    return WillPopScope(
      onWillPop: () {
        Alert().showAlertDialog(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MainTheme.appBarColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Matches",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.sp,
                  fontFamily: "Nunito"),
            ),
            actions: [],
          ),
          body: Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                // indicatorPadding:
                //     const EdgeInsets.only(left: 25, right: 25, top: 10),
                labelColor: MainTheme.primaryColor,
                unselectedLabelColor: Colors.black,
                labelStyle:
                    TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 14),
                indicatorWeight: 3,
                tabs: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Message",
                      style: TextStyle(
                        fontSize: 45.sp,
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 1,
                            color: Colors.grey[300],
                            height: 20,
                          ),
                          Text(
                            "Dates",
                            style: TextStyle(
                              fontSize: 45.sp,
                            ),
                          ),
                          Container(
                            color: Colors.grey[300],
                            width: 1,
                            height: 20,
                          ),
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Request",
                      style: TextStyle(
                        fontSize: 45.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      Container(child: MassageCardList()),
                      Container(child: DatesCardList()),
                      Container(child: RequestCardList())
                    ]),
              ),
            ],
          ),
          bottomNavigationBar: BottomTabBar(
            currentIndex: 1,
          ),
        ),
      ),
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
                // backgroundColor: Colors.grey[200],
                appBar: AppBar(
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
                    backgroundColor: MainTheme.appBarColor,
                    elevation: 0,
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight),
                        child: PreferredSize(
                            preferredSize:
                                const Size.fromHeight(kToolbarHeight),
                            child: Column(children: [
                              Stack(children: [
                                Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      child: Text(
                                        "Matches",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: "Nunito"),
                                      ),
                                    ),
                                  ],
                                )),
                                Positioned(
                                    right: 30,
                                    top: 0,
                                    child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.black,
                                          ),
                                        )))
                              ]),
                              TabBar(
                                controller: _tabController,
                                indicatorColor: MainTheme.primaryColor,
                                indicatorPadding: const EdgeInsets.all(
                                  0,
                                ),
                                labelColor: MainTheme.primaryColor,
                                unselectedLabelColor: Colors.grey,
                                labelStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                unselectedLabelStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                indicatorWeight: 2,
                                tabs: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Message",
                                      style: TextStyle(
                                        fontSize: 45.sp,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 1,
                                            color: Colors.grey[300],
                                            height: 20,
                                          ),
                                          Text(
                                            "Dates",
                                            style: TextStyle(
                                              fontSize: 45.sp,
                                            ),
                                          ),
                                          Container(
                                            color: Colors.grey[300],
                                            width: 1,
                                            height: 20,
                                          ),
                                        ],
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Request",
                                      style: TextStyle(
                                        fontSize: 45.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Divider(),
                            ])))),
                body: TabBarView(controller: _tabController, children: <Widget>[
                  Container(
                      child: Row(
                    children: [
                      Container(
                          color: Colors.white,
                          height: _height,
                          width: _width * 0.333,
                          padding: EdgeInsetsDirectional.only(top: 30),
                          child: MassageCardList(
                            onWeb: true,
                            mcardHeight: 60,
                            mCardWidth: _width / 5.5,
                          )),
                      Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                width: 1,
                                color: Colors.grey[300],
                              ),
                              top: BorderSide(
                                width: 1,
                                color: Colors.grey[300],
                              ),
                            ),
                            color: Colors.grey[50],
                          ),
                          height: _height,
                          width: _width * 0.570,
                          child: ChattingPage(
                            chatBoxWidth: _width / 3.8,
                            floatingActionButtonWidth: _width * 0.500,
                            onWeb: true,
                          ))
                    ],
                  )),
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      child: DatesCardList(
                        onWeb: true,
                        datesCardHeight: 35,
                        testWidth: _width / 3,
                        datesCardWidth: _width / 8,
                      )),
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      child: RequestCardList(
                        onWeb: true,
                        requestCardHeight: 35,
                        requestCardWidth: _width / 8,
                        testWidth: _width / 3,
                      ))
                ]),
              ))),
    );
  }
}
