import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class BlindsCard extends StatefulWidget {
  final bool onWeb;
  final double width;
  final double height;
  final double testWidth;
  final ResponseData data;
  BlindsCard(
      {Key key,
      this.onWeb = false,
      this.height,
      this.width,
      this.testWidth,
      this.data})
      : super(key: key);

  @override
  _BlindsCardState createState() => _BlindsCardState();
}

class _BlindsCardState extends State<BlindsCard> {
  String convertime(now) {
    return DateFormat('dd-MM-yyyy').format(now);
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
                            child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  size: 50,
                                  color: MainTheme.primaryColor,
                                ))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(bottom: 5),
                              child: Text(
                                convertime(widget.data.date) ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "Nunito"),
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
                        child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.account_circle_outlined,
                              size: 50,
                              color: MainTheme.primaryColor,
                            ))),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsetsDirectional.only(bottom: 5),
                          child: Text(
                            convertime(widget.data.date) ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(32),
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
