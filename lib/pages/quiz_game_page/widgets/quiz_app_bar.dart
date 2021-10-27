import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class QuizAppBar extends StatefulWidget {
  String user1;
  String user2;
  QuizAppBar(this.user1, this.user2);

  @override
  _QuizAppBarState createState() => _QuizAppBarState();
}

class _QuizAppBarState extends State<QuizAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 10,
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black,
                      size: 20,
                    ),
                  )),
            ),
            Container(
              child: Text(
                "Matching Buddy",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: "Nunito"),
              ),
            ),
          ]),
          Row(
            children: [
              Container(
                  margin: EdgeInsetsDirectional.only(end: 5, start: 5),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.user1),
                  )),
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 10,
                child: Icon(
                  Icons.forward,
                  color: MainTheme.primaryColor,
                  size: 12,
                ),
              ),
              Container(
                  margin: EdgeInsetsDirectional.only(end: 10, start: 5),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.user2),
                  )),
            ],
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Container(
          //   margin: EdgeInsetsDirectional.only(end: 5),
          //   child: Text(
          //     "Adrianne Rico",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 12,
          //     ),
          //   ),
          // ),
        ],
      )
    ]);
  }
}
