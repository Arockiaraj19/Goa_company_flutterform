import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingBox extends StatefulWidget {
  final String name;
  final double width;
  final bool activeIcon;
  final double fontSize;
  SettingBox(
      {Key key, this.name, this.activeIcon = false, this.width, this.fontSize})
      : super(key: key);

  @override
  _SettingBoxState createState() => _SettingBoxState();
}

class _SettingBoxState extends State<SettingBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsetsDirectional.only(start: 20),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "OpenSans",
                      fontSize: 38.sp,
                    ),
                  )),
              !widget.activeIcon
                  ? Container(
                      child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 60.sp,
                    ))
                  : Container()
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Divider()
      ],
    );
  }
}
