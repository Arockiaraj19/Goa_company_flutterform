import 'package:flutter/material.dart';

class Questionicons extends StatefulWidget {
  String answer;
  String index;

  Questionicons({Key key, this.answer, this.index}) : super(key: key);

  @override
  _QuestioniconsState createState() => _QuestioniconsState();
}

class _QuestioniconsState extends State<Questionicons> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                child: CircleAvatar(
              backgroundColor: Colors.grey[400],
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
            ))
          ],
        ));
  }
}
