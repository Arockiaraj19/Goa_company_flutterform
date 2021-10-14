import 'package:dating_app/pages/comment_page/widgets/massage_card.dart';
import 'package:dating_app/providers/chat_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ChatProvider>().getGroupData();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, data, child) {
        return data.chatState == ChatState.Loaded
            ? data.chatGroupData.length == 0
                ? Container()
                : ListView.builder(
                    itemBuilder: (context, index) => MassageCard(
                        height: widget.mcardHeight,
                        width: widget.mCardWidth,
                        data: data.chatGroupData[index]),
                    itemCount: data.chatGroupData.length,
                  )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
