import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/providers/match_provider.dart';
import 'package:dating_app/shared/widgets/image_viewer.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';

class MatchList extends StatefulWidget {
final List<MatchListModel> matchList;

  const MatchList({Key key, this.matchList}) : super(key: key);
  @override
  _MatchListState createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:widget.matchList.length==0?noResult():
      ListView.builder(
          itemCount: widget.matchList.length,
          itemBuilder: (context,index){
            return ListTile(
              contentPadding: EdgeInsets.fromLTRB(16,5,16,5),
              leading:  SizedBox(width: 60,height: 60,
                child: ClipRRect(borderRadius: BorderRadius.circular(100),
                    child: imageViewer(widget.matchList[index].userDetails.first.profileImage.first),),
              ),
              title: Text(widget.matchList[index].userDetails.first.firstName),
              subtitle:Text(widget.matchList[index].userDetails.first.lastName),
            );
          }),
    );
  }
}
