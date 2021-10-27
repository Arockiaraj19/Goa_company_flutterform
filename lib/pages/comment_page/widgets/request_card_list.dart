import 'package:dating_app/pages/comment_page/widgets/request_card.dart';
import 'package:flutter/material.dart';

class RequestCardList extends StatefulWidget {
  final bool onWeb;
  final double requestCardHeight;
  final double requestCardWidth;
  final double testWidth;
  RequestCardList(
      {Key key,
      this.requestCardHeight,
      this.requestCardWidth,
      this.testWidth,
      this.onWeb = false})
      : super(key: key);

  @override
  _RequestCardListState createState() => _RequestCardListState();
}

class _RequestCardListState extends State<RequestCardList> {
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      // RequestCard(
      //   onWeb: widget.onWeb,
      //   height: widget.requestCardHeight,
      //   width: widget.requestCardWidth,
      //   testWidth: widget.testWidth,
      // ),
    ]);
  }
}
