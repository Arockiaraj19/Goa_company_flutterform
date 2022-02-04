import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/providers/match_provider.dart';
import 'package:dating_app/shared/helpers/loadingLottie.dart';
import 'package:dating_app/shared/helpers/websize.dart';
import 'package:dating_app/shared/widgets/error_card.dart';
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
    skip = 0;
    context.read<MatchProvider>().getMatchData(value, skip);
    controller.addListener(_scrollListener);
  }

  int skip = 0;
  int limit = 5;
  ScrollController controller = ScrollController();

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
      skip += 1;
      print(skip);
      // if (value.isNotEmpty) {
      //   skip = 1;
      //   limit = 40;
      // }
      context.read<MatchProvider>().getMatchData(value, skip);
      // setState(() {

      // });
    }
  }

  String value = '';
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
          TextFormField(
            onChanged: (val) {
               skip = 0;
                  value = val;
                  context.read<MatchProvider>().getMatchData(val, skip);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  left: widget.onWeb ? 5 : 15.0.w,
                ),
                child: Icon(
                  Icons.search,
                  color: Color(0xff8F96AD),
                  size: widget.onWeb ? 20 : 60.sp,
                ),
              ),
              contentPadding: widget.onWeb
                  ? null
                  : EdgeInsets.only(
                      left: 18.0.w, bottom: 12.0.h, top: 12.0.h, right: 2.0.w),
              hintText: "Search match users",
              hintStyle: TextStyle(
                  fontSize: widget.onWeb ? inputFont : 35.sp,
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
          SizedBox(height: 10.h),
          Expanded(
            child: Container(
              child: Consumer<MatchProvider>(builder: (context, data, child) {
                if (data.matchState == MatchState.Error) {
                  return ErrorCard(
                    text: data.errorText,
                    ontab: () {
                      context.read<MatchProvider>().getMatchData("",0);
                    },
                  );
                } else if (data.matchState == MatchState.Loading) {
                  return LoadingLottie();
                } else if (data.matchState == MatchState.Loaded) {
                  return data.matchListData.length == 0
                      ? noResult()
                      : ListView.builder(
                           controller: controller,
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
