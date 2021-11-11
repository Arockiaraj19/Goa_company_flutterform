import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionBox extends StatefulWidget {
  String question;
  QuestionBox({Key key, this.question}) : super(key: key);

  @override
  _QuestionBoxState createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsetsDirectional.only(end: 20, start: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Text(
            widget.question,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 45.sp,
                fontFamily: "Nunito"),
          )),
        ]));
  }
}
