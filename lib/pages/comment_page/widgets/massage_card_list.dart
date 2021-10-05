import 'package:dating_app/pages/comment_page/widgets/massage_card.dart';
import 'package:dating_app/routes.dart';
import 'package:flutter/material.dart';

class MassageCardList extends StatefulWidget {
  final double mCardWidth;
  final double mcardHeight;
  final bool onWeb;
  MassageCardList(
      {Key key, this.mCardWidth, this.mcardHeight, this.onWeb = false})
      : super(key: key);

  @override
  _MassageCardListState createState() => _MassageCardListState();
}

class _MassageCardListState extends State<MassageCardList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
          onTap: widget.onWeb
              ? () {}
              : () {
                  goToChattingPage();
                },
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
        MassageCard(
          height: widget.mcardHeight,
          width: widget.mCardWidth,
        ),
      ],
    );
  }

  goToChattingPage() {
    Routes.sailor(Routes.chattingPage);
  }
}
