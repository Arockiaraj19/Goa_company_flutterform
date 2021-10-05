import 'package:flutter/material.dart';

class Questionicons extends StatefulWidget {
  Questionicons({Key key}) : super(key: key);

  @override
  _QuestioniconsState createState() => _QuestioniconsState();
}

class _QuestioniconsState extends State<Questionicons> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: CircleAvatar(
              backgroundColor: Colors.grey[400],
              radius: 20,
              child: Text(
                'A',
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
              "Picnic",
              textAlign: TextAlign.center,
            ))
          ],
        ));
  }
}
