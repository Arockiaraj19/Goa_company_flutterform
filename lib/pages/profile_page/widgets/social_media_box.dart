import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class SocialMediaBox extends StatefulWidget {
  final String name;
  final String image;
  final double fontSize;
  final TextStyle style;
  final String checkname;
  final String data;

  SocialMediaBox(
      {Key key,
      this.image,
      this.name,
      this.fontSize,
      this.style,
      this.checkname,
      this.data})
      : super(key: key);

  @override
  _SocialMediaBoxState createState() => _SocialMediaBoxState();
}

class _SocialMediaBoxState extends State<SocialMediaBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
            margin: EdgeInsetsDirectional.only(top: 10),
            child: Image.asset(
              widget.image,
              width: 30,
              height: 20,
            )),
        Container(
            margin: EdgeInsetsDirectional.only(top: 5),
            child: Text(
              widget.name,
              style: widget.style ??
                  TextStyle(
                      color:
                          widget.data == null ? Colors.grey[300] : Colors.black,
                      fontSize: 12,
                      fontFamily: "Nunito"),
            )),
      ],
    ));
  }
}
