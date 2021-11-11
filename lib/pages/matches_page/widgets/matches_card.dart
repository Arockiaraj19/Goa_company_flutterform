import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MatchesCard extends StatefulWidget {
  final bool onWeb;
  final double width;
  final double height;
  final double testWidth;
  final MatchListModel userData;
  MatchesCard(
      {Key key,
      this.onWeb = false,
      this.height,
      this.width,
      this.testWidth,
      this.userData})
      : super(key: key);

  @override
  _MatchesCardState createState() => _MatchesCardState();
}

class _MatchesCardState extends State<MatchesCard> {
  Future<String> getimage() async {
    String userid = await getUserId();
    if (widget.userData.user1[0].userId != userid) {
      return widget.userData.user1[0].identificationImage;
    } else {
      return widget.userData.user2[0].identificationImage;
    }
  }

  Future<String> getname() async {
    String userid = await getUserId();
    if (widget.userData.user1[0].userId != userid) {
      return widget.userData.user1[0].firstName;
    } else {
      return widget.userData.user2[0].firstName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.onWeb
        ? Container(
            margin: EdgeInsets.all(7),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin:
                              EdgeInsetsDirectional.only(end: 10, start: 10),
                          child: SizedBox(
                            width: 80.r,
                            height: 80.r,
                            child: FutureBuilder(
                              future: getimage(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: imageViewer(snapshot.data));
                                } else {
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                          "assets/images/placeholder.png"));
                                }
                              },
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(bottom: 5),
                              child: FutureBuilder(
                                future: getname(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp,
                                          fontFamily: "Nunito"),
                                    );
                                  } else {
                                    return Text(
                                      " ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: "Nunito"),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 9.0,
                              offset: Offset(0, 5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(360),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 22,
                              child: Icon(
                                FontAwesomeIcons.solidPaperPlane,
                                color: MainTheme.primaryColor,
                                size: 17,
                              )),
                        )),
                    Container(
                      width: widget.width / 2,
                      height: 4,
                    )
                  ],
                ),
                Divider()
              ],
            ))
        : Container(
            margin: EdgeInsets.all(7),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 10, start: 10),
                      child: SizedBox(
                        width: 180.r,
                        height: 180.r,
                        child: FutureBuilder(
                          future: getimage(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: imageViewer(snapshot.data));
                            } else {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                      "assets/images/placeholder.png"));
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsetsDirectional.only(bottom: 5),
                          child: FutureBuilder(
                            future: getname(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50.sp,
                                      fontFamily: "Nunito"),
                                );
                              } else {
                                return Text(
                                  " ",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: "Nunito"),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Divider()
              ],
            ));
  }
}
