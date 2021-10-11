import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularBtn extends StatefulWidget {
  final IconData icon;
  final Function ontap;
  final Color btnColor;
  CircularBtn({Key key, this.icon, this.ontap, this.btnColor})
      : super(key: key);

  @override
  _CircularBtnState createState() => _CircularBtnState();
}

class _CircularBtnState extends State<CircularBtn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: widget.ontap,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                  offset: Offset(1, 1),
                )
              ],
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                    child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(widget.icon,
                          size: 18, color: widget.btnColor ?? Colors.grey)),
                )))));
  }
}

class Lottiebtn extends StatefulWidget {
  final Widget icon;
  final Function ontap;
  final Color btnColor;
  Lottiebtn({Key key, this.icon, this.ontap, this.btnColor}) : super(key: key);

  @override
  _LottiebtnState createState() => _LottiebtnState();
}

class _LottiebtnState extends State<Lottiebtn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: widget.ontap,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                  offset: Offset(1, 1),
                )
              ],
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                    child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22,
                  child: Container(
                      height: 300.w, width: 300.w, child: widget.icon),
                )))));
  }
}
