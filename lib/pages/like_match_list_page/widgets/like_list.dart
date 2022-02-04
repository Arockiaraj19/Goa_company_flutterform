import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/providers/match_provider.dart';
import 'package:dating_app/shared/widgets/image_viewer.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';

class LikeList extends StatefulWidget {
  final List<LikeListModel> likeList;

  const LikeList({Key key, this.likeList}) : super(key: key);
  @override
  _LikeListState createState() => _LikeListState();
}

class _LikeListState extends State<LikeList> {
  @override
  void initState() {
    super.initState();

    skip = 0;

    controller.addListener(_scrollListener);
  }

  int skip = 0;
  int limit = 5;
  ScrollController controller = ScrollController();

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
      skip += 1;
      print(skip);
      // if (value.isNotEmpty) {
      //   skip = 1;
      //   limit = 40;
      // }
      context.read<MatchProvider>().getLikesOnlyData(skip);
      // setState(() {

      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.likeList.length == 0
          ? noResult()
          : ListView.builder(
              controller: controller,
              itemCount: widget.likeList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    UserNetwork().getMatchedprofiledata(
                        widget.likeList[index].likedUser[0].sId);
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                    leading: SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: imageViewer(widget.likeList[index].likedUser
                              .first.profileImage.first)),
                    ),
                    title:
                        Text(widget.likeList[index].likedUser.first.firstName),
                  ),
                );
              }),
    );
  }
}
