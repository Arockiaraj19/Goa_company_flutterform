import 'package:flutter/material.dart';

class HartViewicons extends StatefulWidget {
  final Function onTap;

  HartViewicons({Key key, this.onTap}) : super(key: key);

  @override
  _HartViewiconsState createState() => _HartViewiconsState();
}

class _HartViewiconsState extends State<HartViewicons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: Container(
            margin: EdgeInsetsDirectional.only(end: 5, start: 5),
            child: Icon(
              Icons.favorite_border,
              color: Colors.red,
            )));
  }
}
