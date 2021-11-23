import 'package:dating_app/models/gender_model.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class PartnerCard extends StatefulWidget {
  final String image;
  final String name;
  final bool isActive;
  final Function onTap;
  PartnerCard({Key key, this.image, this.name, this.onTap, this.isActive})
      : super(key: key);

  @override
  _PartnerCardState createState() => _PartnerCardState();
}

class _PartnerCardState extends State<PartnerCard> {
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  Container(
                    child: Image.asset(
                      widget.image,
                      color: MainTheme.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: Text(widget.name,
                          style: TextStyle(
                              color: widget.isActive == false
                                  ? Color.fromRGBO(17, 17, 17, 0.48)
                                  : MainTheme.primaryColor))),
                  SizedBox(height: 10.h),
                ])));
  }
}

class GenderEditCard extends StatefulWidget {
  final String id;
  final GenderModel data;

  final Function onTap;
  GenderEditCard({Key key, this.id, this.data, this.onTap}) : super(key: key);

  @override
  _GenderEditCardState createState() => _GenderEditCardState();
}

class _GenderEditCardState extends State<GenderEditCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            alignment: Alignment.center,
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
                  color: widget.id != widget.data.id
                      ? Colors.grey[50]
                      : MainTheme.primaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
                child: Text(widget.data.title,
                    style: TextStyle(
                        fontSize: 12,
                        color: widget.id != widget.data.id
                            ? Color.fromRGBO(17, 17, 17, 0.48)
                            : MainTheme.primaryColor))),
          ),
        ));
  }
}
