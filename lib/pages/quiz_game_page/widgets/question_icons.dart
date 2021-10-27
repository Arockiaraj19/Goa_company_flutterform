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
                            ? Colors.pink
                            : Colors.grey[400],
                        radius: 20,
                        child: Text(
                          widget.index.toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      child: Text(
                    widget.answer,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.option == widget.answer
                          ? Colors.pink
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
