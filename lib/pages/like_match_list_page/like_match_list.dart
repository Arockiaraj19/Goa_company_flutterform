import 'package:dating_app/models/user.dart';
import 'package:dating_app/pages/like_match_list_page/widgets/like_list.dart';
import 'package:dating_app/pages/like_match_list_page/widgets/match_list.dart';
import 'package:dating_app/pages/matches_page/widgets/matches_card_list.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/match_provider.dart';
import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/error_card.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:dating_app/shared/widgets/subscription_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class LikeMatchListPage extends StatefulWidget {
  final int index;
  LikeMatchListPage({Key key, this.index}) : super(key: key);

  @override
  _LikeMatchListPageState createState() => _LikeMatchListPageState();
}

class _LikeMatchListPageState extends State<LikeMatchListPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.index);
    context.read<MatchProvider>().getMatchLikeData();
    Future.delayed(Duration(milliseconds: 500), () {
      _checkSub();
    });
  }

  _checkSub() async {
    if (context.read<SubscriptionProvider>().plan == null) {
      if (context.read<SubscriptionProvider>().subscriptionData.length == 0) {
        context.read<SubscriptionProvider>().getdata();
        _showplans();
      } else {
        _showplans();
      }
    }
  }

  _showplans() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                Navigator.pop(context);
                Navigator.pop(context);
                return true;
              },
              child: BottomsheetWidget());
        });
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
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Column(children: [
                    TabBar(
                      controller: _tabController,
                      indicatorColor: MainTheme.primaryColor,
                      indicatorPadding:
                          const EdgeInsets.only(left: 25, right: 25, top: 10),
                      labelColor: MainTheme.primaryColor,
                      unselectedLabelColor: Colors.black,
                      labelStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(fontSize: 14),
                      indicatorWeight: 2,
                      tabs: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Likes",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Matches",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Divider(),
                  ])))),
      body: Consumer<MatchProvider>(builder: (context, data, child) {
        if (data.matchState == MatchState.Loading) {
          return LinearProgressIndicator();
        } else if (data.matchState == MatchState.Loaded) {
          return TabBarView(
              controller: _tabController,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                    child: LikeList(
                  likeList: data.likeListData,
                )),
                Container(
                    child: MatchList(
                  matchList: data.matchListData,
                )),
              ]);
        } else {
          return ErrorCard(text: data.errorText, ontab: () {});
        }
      }),
    ));
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width - 30;

    return Scaffold(
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
                body: Consumer<MatchProvider>(builder: (context, data, child) {
                  if (data.matchState == MatchState.Loading) {
                    return LinearProgressIndicator();
                  } else if (data.matchState == MatchState.Loaded) {
                    return TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          Container(
                              child: LikeList(
                            likeList: data.likeListData,
                          )),
                          Container(
                              child: MatchList(
                            matchList: data.matchListData,
                          )),
                        ]);
                  } else {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: double.infinity,
                              height: 300,
                              child:
                                  Lottie.asset('assets/lottie/no_data.json')),
                          Text(
                            "No results found !",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ]);
                  }
                }))));
  }
}
