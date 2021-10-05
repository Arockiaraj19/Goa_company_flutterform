import 'package:flutter/material.dart';

class BaseLayout extends StatefulWidget {
  BaseLayout({Key key, this.navigationRail, this.body}) : super(key: key);
  final Widget navigationRail;
  final Widget body;

  @override
  _BaseLayoutState createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.navigationRail ?? Container(),
          Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width - 30,
                  child: widget.body)

              //     != null
              //         ? Container(
              //             color: Colors.amber,
              //             height:
              //                 MediaQuery.of(context).size.height - (kToolbarHeight),
              //             width: MediaQuery.of(context).size.width - 40,
              //             // child: SingleChildScrollView(
              //             child: widget.body,
              //             //  Column(
              //             //   mainAxisSize: MainAxisSize.min,
              //             //   children: [
              //             //     widget.body,
              //             //   ],
              //             // ),
              //             // ),
              //           )
              //         : Container()),
              ),
        ],
      ),
    );
  }
}
