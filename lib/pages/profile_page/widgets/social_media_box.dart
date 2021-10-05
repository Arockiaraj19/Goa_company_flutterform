import 'package:flutter/material.dart';

class SocialMediaBox extends StatefulWidget {
  final String name;
  final String image;
  final double fontSize;
  final TextStyle style;

  SocialMediaBox({Key key, this.image, this.name, this.fontSize, this.style})
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
              width: 20,
              height: 20,
            )),
        Container(
            margin: EdgeInsetsDirectional.only(top: 5),
            child: Text(
              widget.name,
              style: widget.style ??
                  TextStyle(
                      color: Colors.black, fontSize: 12, fontFamily: "Nunito"),
            )),
      ],
    ));
  }
}
