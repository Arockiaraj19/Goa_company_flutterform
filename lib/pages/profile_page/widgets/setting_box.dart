import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:flutter/material.dart';

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
    return Row(
      children: [
        Container(
            height: 50,
            width: widget.width ?? MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey[300],
                ),
              ),
            ),
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
                        fontSize: widget.fontSize ?? 15,
                      ),
                    )),
                !widget.activeIcon
                    ? Container(
                        child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                        size: 22,
                      ))
                    : Container()
              ],
            ))
      ],
    );
  }
}
