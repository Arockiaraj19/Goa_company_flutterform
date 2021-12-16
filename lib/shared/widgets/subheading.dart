import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubHeading extends StatefulWidget {
  final String name;
  SubHeading({Key key, this.name}) : super(key: key);

  @override
  _SubHeadingState createState() => _SubHeadingState();
}

class _SubHeadingState extends State<SubHeading> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: EdgeInsetsDirectional.only(top: 10, bottom: 10),
            child: Text(widget.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  fontSize: 12,
                )))
      ],
    );
  }
}
