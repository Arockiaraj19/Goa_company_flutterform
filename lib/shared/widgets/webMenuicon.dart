import 'package:flutter/material.dart';

class WebmenuIcon extends StatefulWidget {
  final String name;
  final Function onTap;
  WebmenuIcon({Key key, this.name, this.onTap}) : super(key: key);

  @override
  _WebmenuIconState createState() => _WebmenuIconState();
}

class _WebmenuIconState extends State<WebmenuIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Center(
      child: Image.asset(widget.name),
    ));
  }
}
