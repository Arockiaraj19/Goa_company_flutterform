import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class QuizAppBar extends StatefulWidget {
  QuizAppBar({Key key}) : super(key: key);

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
            Container(
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
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                    ),
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
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                    ),
                  )),
            ],
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(end: 5),
            child: Text(
              "Adrianne Rico",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      )
    ]);
  }
}
