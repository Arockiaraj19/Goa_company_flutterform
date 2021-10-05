import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterestBox extends StatefulWidget {
  final double fontSize;
  final Color color;
  final Color fillColor;
  final String title;
  final Function onTap;
  InterestBox({Key key, this.fontSize, this.color, this.onTap, this.title, this.fillColor})
      : super(key: key);

  @override
  _InterestBoxState createState() => _InterestBoxState();
}

class _InterestBoxState extends State<InterestBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: Container(
            // width: MediaQuery.of(context).size.width - 30 * 0.3,
            height: 30,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: widget.fillColor,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey, blurRadius: 1.0)
              ],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 0.6, color: widget.color ?? Colors.white),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: widget.fontSize ?? ScreenUtil().setSp(9),
                      fontFamily: "OpenSans"),
                ))
              ],
            )));
  }
}
