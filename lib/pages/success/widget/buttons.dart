import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Flatbuttonstyle extends StatefulWidget {
  final String label;
  final Function onpressfuntion;
  Flatbuttonstyle(this.label, this.onpressfuntion);

  @override
  State<Flatbuttonstyle> createState() => _FlatbuttonstyleState();
}

class _FlatbuttonstyleState extends State<Flatbuttonstyle> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => widget.onpressfuntion(),
      minWidth: double.infinity,
      height: 48.h,
      child: Text(widget.label,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.w)),
      color: Colors.pink,
      splashColor: Colors.white,
    );
  }
}
