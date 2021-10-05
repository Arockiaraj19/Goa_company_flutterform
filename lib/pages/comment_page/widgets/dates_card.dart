import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DatesCard extends StatefulWidget {
  final bool onWeb;
  final double width;
  final double height;
  final double testWidth;
  DatesCard(
      {Key key, this.onWeb = false, this.height, this.width, this.testWidth})
      : super(key: key);

  @override
  _DatesCardState createState() => _DatesCardState();
}

class _DatesCardState extends State<DatesCard> {
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
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                              ),
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(bottom: 5),
                              child: Text(
                                "Tomorrow",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: MainTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: "Nunito"),
                              ),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(bottom: 5),
                              child: Text(
                                "Alyssa Putri",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: "Nunito"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsetsDirectional.only(end: 10),
                            child: Icon(Icons.location_on_outlined,
                                color: MainTheme.primaryColor)),
                        Container(
                          child: Text(
                            "One Eighty Coffee & Music",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: "Nunito"),
                          ),
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
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                          ),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsetsDirectional.only(bottom: 5),
                          child: Text(
                            "Tomorrow",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: MainTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(35),
                                fontFamily: "Nunito"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(bottom: 5),
                          child: Text(
                            "Alyssa Putri",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(40),
                                fontFamily: "Nunito"),
                          ),
                        ),
                        Container(
                          child: Text(
                            "One Eighty Coffee & Music",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(34),
                                fontFamily: "Nunito"),
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
