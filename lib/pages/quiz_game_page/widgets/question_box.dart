import 'package:flutter/material.dart';

class QuestionBox extends StatefulWidget {
  QuestionBox({Key key}) : super(key: key);

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
            "Which of these following is an idealdate for you?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: "Nunito"),
          )),
        ]));
  }
}
