import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/providers/match_provider.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40.h,
              child: TextFormField(
                onChanged: (val) {
                  print(val);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xff8F96AD),
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  hintText: "Search match users",
                  hintStyle: TextStyle(
                      fontSize: 35.sp,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff666666)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80.w),
                    borderSide: BorderSide(
                        color: Color(0xffEFEBEB),
                        width: 0,
                        style: BorderStyle.solid),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80.w),
                    borderSide: BorderSide(
                        color: Color(0xffEFEBEB),
                        width: 0,
                        style: BorderStyle.solid),
                  ),
                ),
                enableInteractiveSelection: true,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Container(
              child: Consumer<MatchProvider>(builder: (context, data, child) {
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
            ),
          ),
        ],
      ),
    );
  }
}
