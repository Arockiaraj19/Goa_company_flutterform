import 'package:flutter/material.dart';

import 'dates_card.dart';

class DatesCardList extends StatefulWidget {
  final bool onWeb;
  final double datesCardHeight;
  final double datesCardWidth;
  final double testWidth;

  DatesCardList(
      {Key key,
      this.datesCardHeight,
      this.datesCardWidth,
      this.testWidth,
      this.onWeb = false})
      : super(key: key);

  @override
  _DatesCardListState createState() => _DatesCardListState();
}

class _DatesCardListState extends State<DatesCardList> {
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      DatesCard(
        onWeb: widget.onWeb,
        height: widget.datesCardHeight,
        width: widget.datesCardWidth,
        testWidth: widget.testWidth,
      ),
    ]);
  }
}
