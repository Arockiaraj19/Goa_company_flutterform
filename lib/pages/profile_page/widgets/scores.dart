import 'package:flutter/material.dart';

class Scores extends StatefulWidget {
  final String name;
  final String scores;
  final Color color;
  final TextStyle valuefont;
  final TextStyle nameFont;
  final Color textColor;

  Scores(
      {Key key,
      this.name,
      this.scores,
      this.color,
      this.textColor,
      this.valuefont,
      this.nameFont})
      : super(key: key);

  @override
  _ScoresState createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
  @override
  Widget build(BuildContext context) {
    return Container(width: 80,color: Colors.transparent,
        margin: EdgeInsetsDirectional.only(top: 10),
        child: Column(
          children: [
            Container(
              child: Text(
                widget.name,
                style: widget.valuefont ??
                    TextStyle(
                        color: widget.color ?? Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "Nunito"),
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 5),
              child: Text(
                widget.scores,
                style: widget.nameFont ??
                    TextStyle(
                        color: widget.textColor ?? Colors.white,
                        fontSize: 14,
                        fontFamily: "Nunito"),
              ),
            )
          ],
        ));
  }
}
