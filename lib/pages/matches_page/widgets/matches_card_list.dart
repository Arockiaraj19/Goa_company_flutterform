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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MatchProvider>(builder: (context, data, child) {
        if(data.homeState == HomeState.Loading){
          return Center(child: CircularProgressIndicator());
        }else if(data.homeState == HomeState.Loaded){
          return data.matchListData.length==0? noResult():
          ListView.builder(
            itemCount: data.matchListData.length,
            itemBuilder: (context, index) {
              return MatchesCard(
                onWeb: widget.onWeb,
                height: widget.datesCardHeight,
                width: widget.datesCardWidth,
                testWidth: widget.testWidth,
                userData: data.matchListData[index],
              );
            },);
        }
      }),
    );
  }
}
