import 'package:dating_app/pages/chatting_page/chatting_page.dart';
import 'package:dating_app/pages/matches_page/widgets/blinds_card_list.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/alert_widget.dart';
import 'package:dating_app/shared/widgets/bottom_bar.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/matches_card_list.dart';

class MatchesPage extends StatefulWidget {
  MatchesPage({Key key}) : super(key: key);

  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    return WillPopScope(
       onWillPop: (){
         Alert().showAlertDialog(context);
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomTabBar(
            currentIndex: 2,
          ),
          appBar: AppBar(
              backgroundColor: MainTheme.appBarColor,
              elevation: 0,
              actions: [],
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight * 1.3),
                  child: PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight),
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
                        ]),
                        TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.transparent,
                          indicatorPadding:
                              const EdgeInsets.only(left: 25, right: 25, top: 10),
                          labelColor: MainTheme.primaryColor,
                          unselectedLabelColor: Colors.black,
                          labelStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(fontSize: 14),
                          indicatorWeight: 2,
                          tabs: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Matches",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Blind",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ])))),
          body: TabBarView(
              controller: _tabController,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(child: MatchesCardList()),
                Container(child: BlindsCardList()),
              ]),
        ),
      ),
    );
  }

  goToChattingPage() {
    Routes.sailor(Routes.chattingPage);
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      body: BaseLayout(
          navigationRail: NavigationMenu(
            currentTabIndex: 2,
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
                                        fontSize: 14,
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
                                            "Blinds",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Container(
                                            color: Colors.grey[300],
                                            width: 1,
                                            height: 20,
                                          ),
                                        ],
                                      )),
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
                          child: MatchesCardList(
                            onWeb: true,
                            datesCardHeight: 60,
                            datesCardWidth: _width / 5.5,
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
                          child: BlindsCardList(
                            onWeb: true,
                          ))
                    ],
                  )),
                ]),
              ))),
    );
  }
}
