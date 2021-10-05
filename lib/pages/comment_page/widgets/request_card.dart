import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestCard extends StatefulWidget {
  final bool onWeb;
  final double width;
  final double height;
  final double testWidth;

  RequestCard(
      {Key key, this.onWeb = false, this.height, this.width, this.testWidth})
      : super(key: key);

  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    return widget.onWeb
        ? Container(
            child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                    width: widget.testWidth,
                    child: Row(children: [
                      Container(
                          margin:
                              EdgeInsetsDirectional.only(end: 10, start: 10),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                            ),
                          )),
                      Expanded(
                          child: RichText(
                        text: TextSpan(
                            text: "Fadlan Yusuf ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: "Inter"),
                            children: [
                              TextSpan(
                                text:
                                    "request Meet Up at Sejiwa Coffe on Saturday, July 27th 2020",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    fontFamily: "Inter"),
                              ),
                            ]),
                      )),
                    ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GradientButton(
                      height: widget.height ??
                          MediaQuery.of(context).size.height / 20,
                      name: "Delete",
                      buttonColor: Colors.grey[300],
                      active: true,
                      color: Colors.black,
                      width: widget.width ?? ScreenUtil().setWidth(300),
                      fontSize: 14,
                      borderRadius: BorderRadius.circular(3),
                      fontWeight: FontWeight.bold,
                      onPressed: () {},
                    ),
                    GradientButton(
                      height: widget.height ??
                          MediaQuery.of(context).size.height / 20,
                      name: "Continue",
                      gradient: MainTheme.loginBtnGradient,
                      active: true,
                      color: Colors.white,
                      width: widget.width ?? ScreenUtil().setWidth(300),
                      fontWeight: FontWeight.bold,
                      borderRadius: BorderRadius.circular(3),
                      fontSize: 14,
                      onPressed: () {},
                    ),
                  ],
                ),
                Container(
                  width: widget.width / 2,
                  height: 4,
                )
              ]),
              Divider()
            ],
          ))
        : Container(
            margin: EdgeInsets.all(7),
            child: Column(
              children: [
                Row(children: [
                  Container(
                      margin: EdgeInsetsDirectional.only(end: 10, start: 10),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                        ),
                      )),
                  Expanded(
                      child: RichText(
                    text: TextSpan(
                        text: "Fadlan Yusuf ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(37),
                            fontFamily: "Inter"),
                        children: [
                          TextSpan(
                            text:
                                "request Meet Up at Sejiwa Coffe on Saturday, July 27th 2020",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: ScreenUtil().setSp(37),
                                fontFamily: "Inter"),
                          ),
                        ]),
                  )),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GradientButton(
                      height: MediaQuery.of(context).size.height / 25,
                      name: "Delete",
                      gradient: MainTheme.loginBtnGradient,
                      active: true,
                      color: Colors.white,
                      width: ScreenUtil().setWidth(250),
                      fontWeight: FontWeight.bold,
                      borderRadius: BorderRadius.circular(5),
                      onPressed: () {},
                    ),
                    GradientButton(
                      height: MediaQuery.of(context).size.height / 25,
                      name: "Continue",
                      buttonColor: Colors.grey[300],
                      active: true,
                      color: Colors.black,
                      width: ScreenUtil().setWidth(250),
                      borderRadius: BorderRadius.circular(5),
                      fontWeight: FontWeight.bold,
                      onPressed: () {},
                    ),
                  ],
                ),
                Divider()
              ],
            ));
  }
}
