import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class HartViewicons extends StatefulWidget {
  final bool istrue;
  final int len;
  final Function onTap;
  final PageController controller;
  final int index;
  final int position;
  final bool onweb;

  HartViewicons(
      {Key key,
      this.istrue,
      this.len,
      this.onTap,
      this.controller,
      this.index,
      this.position,
      this.onweb = false})
      : super(key: key);

  @override
  _HartViewiconsState createState() => _HartViewiconsState();
}

class _HartViewiconsState extends State<HartViewicons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: Column(
          children: [
            Container(
                margin: EdgeInsetsDirectional.only(end: 5, start: 5),
                child: Icon(
                  widget.istrue ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                )),
            if (widget.position == widget.index)
              Container(
                width: 20,
                height: 2,
                decoration:
                    BoxDecoration(gradient: MainTheme.backgroundGradient),
              )
          ],
        ));
  }
}
