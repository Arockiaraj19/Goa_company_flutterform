import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class ChattBox extends StatefulWidget {
  final bool sendMsg;
  final double width;
  ChattBox({Key key, this.sendMsg = false, this.width}) : super(key: key);

  @override
  _ChattBoxState createState() => _ChattBoxState();
}

class _ChattBoxState extends State<ChattBox> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              child: Column(
        crossAxisAlignment: widget.sendMsg == true
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                color: widget.sendMsg == true
                    ? MainTheme.primaryColor
                    : Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 1.0,
                    offset: Offset(1, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              width: widget.width ?? MediaQuery.of(context).size.width * 0.6,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: widget.sendMsg == true
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(bottom: 10),
                      child: Text("Hello Man, How are you!,",
                          style: TextStyle(
                              color: widget.sendMsg == true
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14,
                              fontFamily: "Inter")),
                    ),
                    Container(
                        child: Text(
                      "10:10  PM",
                      style: TextStyle(
                          color: widget.sendMsg == true
                              ? Colors.grey[400]
                              : MainTheme.primaryColor,
                          fontSize: 14,
                          fontFamily: "Inter"),
                    ))
                  ]))
        ],
      )))
    ]);
  }
}
