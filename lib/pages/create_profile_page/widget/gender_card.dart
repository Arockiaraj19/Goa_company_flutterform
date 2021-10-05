import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenderCard extends StatefulWidget {
  final String image;
  final String name;
  final bool isActive;
  final Function onTap;
  GenderCard({Key key, this.image, this.name, this.onTap, this.isActive})
      : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 1.0,
                  offset: Offset(0, 3),
                )
              ],
              border: Border.all(
                  width: 1.5,
                  color: widget.isActive == false
                      ? Colors.grey[50]
                      : MainTheme.primaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(5),
            child: widget.image == "null"
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        padding: EdgeInsetsDirectional.only(start: 10),
                        child: Text(widget.name,
                            style: TextStyle(
                                color: widget.isActive == false
                                    ? Color.fromRGBO(17, 17, 17, 0.48)
                                    : MainTheme.primaryColor))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey.shade300,
                    )
                  ])
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Container(child: Image.asset(widget.image)),
                        Container(
                            child: Text(widget.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: widget.isActive == false
                                        ? Color.fromRGBO(17, 17, 17, 0.48)
                                        : MainTheme.primaryColor)))
                      ])));
  }
}
