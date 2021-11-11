import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Questionicons extends StatefulWidget {
  String option;
  String answer;
  String index;

  Questionicons({Key key, this.option, this.answer, this.index})
      : super(key: key);

  @override
  _QuestioniconsState createState() => _QuestioniconsState();
}

class _QuestioniconsState extends State<Questionicons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200.w,
        ),
        Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        backgroundColor: widget.option == widget.answer
                            ? MainTheme.primaryColor
                            : Colors.grey[400],
                        minRadius: 30.r,
                        maxRadius: 50.r,
                        child: Text(
                          widget.index.toString(),
                          style: TextStyle(
                            fontSize: 55.sp,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 15.w,
                  ),
                  Container(
                      child: Text(
                    widget.answer,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 45.sp,
                      color: widget.option == widget.answer
                          ? MainTheme.primaryColor
                          : Colors.black,
                    ),
                  )),
                ],
              )),
        ),
      ],
    );
  }
}
