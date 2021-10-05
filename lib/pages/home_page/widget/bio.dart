import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bio extends StatefulWidget {
  Bio({Key key}) : super(key: key);

  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Bio> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.grey.shade200),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.grey.shade400, blurRadius: 1.0)
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                  margin: EdgeInsetsDirectional.only(top: 10, start: 10),
                  child: Text(
                    "Bio",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontFamily: "OpenSans"),
                  ))
            ]),
            Container(
                padding: EdgeInsetsDirectional.only(start: 30, end: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "An artist of considerable range, Jessica i am  mondatht artist for the nmality conensce jessica super valuename taken by Melbourne …",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color.fromRGBO(82, 95, 127, 1),
                            fontSize: 11,
                            fontFamily: "OpenSans"),
                      ),
                    )
                  ],
                )),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                  margin: EdgeInsetsDirectional.only(bottom: 10, end: 10),
                  child: Text("Show more",
                      style: TextStyle(
                          color: MainTheme.showMoreColor,
                          fontSize: 10,
                          fontFamily: "OpenSans"))),
            ])
          ],
        ));
  }
}
