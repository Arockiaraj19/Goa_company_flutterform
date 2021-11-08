import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorCard extends StatefulWidget {
  String text;
  Function ontab;
  ErrorCard({this.text, this.ontab});

  @override
  _ErrorCardState createState() => _ErrorCardState();
}

class _ErrorCardState extends State<ErrorCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          InkWell(
            onTap: widget.ontab,
            child: Container(
              height: 30.h,
              width: 300.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: MainTheme.backgroundGradient,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                "Reload",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
