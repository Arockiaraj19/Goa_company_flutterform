import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/providers/match_provider.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'matches_card.dart';

class MatchesCardList extends StatefulWidget {
  final bool onWeb;
  final double datesCardHeight;
  final double datesCardWidth;
  final double testWidth;

  MatchesCardList(
      {Key key,
      this.datesCardHeight,
      this.datesCardWidth,
      this.testWidth,
      this.onWeb = false})
      : super(key: key);

  @override
  _MatchesCardListState createState() => _MatchesCardListState();
}

class _MatchesCardListState extends State<MatchesCardList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MatchProvider>().getMatchData();
  }

  Future getdata(MatchListModel data) async {
    String userid = await getUserId();
    if (data.user1[0].userId != userid) {
      return UserNetwork().getMatchedprofiledata(data.user1[0].userId);
    } else {
      return UserNetwork().getMatchedprofiledata(data.user2[0].userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MatchProvider>(builder: (context, data, child) {
        if (data.homeState == HomeState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (data.homeState == HomeState.Loaded) {
          return data.matchListData.length == 0
              ? noResult()
              : ListView.builder(
                  itemCount: data.matchListData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        getdata(data.matchListData[index]);
                      },
                      child: MatchesCard(
                        onWeb: widget.onWeb,
                        height: widget.datesCardHeight,
                        width: widget.datesCardWidth,
                        testWidth: widget.testWidth,
                        userData: data.matchListData[index],
                      ),
                    );
                  },
                );
        }
      }),
    );
  }
}
