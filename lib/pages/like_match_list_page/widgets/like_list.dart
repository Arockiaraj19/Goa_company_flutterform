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
  Widget build(BuildContext context) {
    return Scaffold(
      body:widget.likeList.length==0?noResult():
      ListView.builder(
          itemCount: widget.likeList.length,
          itemBuilder: (context,index){
            return ListTile(
              contentPadding: EdgeInsets.fromLTRB(16,10,16,10),
              leading: SizedBox(width: 60,height: 60,
                child: ClipRRect(borderRadius: BorderRadius.circular(100),
                    child: imageViewer(widget.likeList[index].likedUser.first.profileImage.first)),
              ),
              title: Text(widget.likeList[index].likedUser.first.firstName),
            );
          }),
    );
  }
}
