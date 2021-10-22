import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
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
  Future<String> getimage(MatchListModel userData) async {
    String userid = await getUserId();
    if (userData.user1[0].userId != userid) {
      return userData.user1[0].identificationImage;
    } else {
      return userData.user2[0].identificationImage;
    }
  }

  Future<String> getname(MatchListModel userData) async {
    String userid = await getUserId();
    if (userData.user1[0].userId != userid) {
      return userData.user1[0].firstName;
    } else {
      return userData.user2[0].firstName;
    }
  }

  Future<String> getlastname(MatchListModel userData) async {
    String userid = await getUserId();
    if (userData.user1[0].userId != userid) {
      return userData.user1[0].lastName;
    } else {
      return userData.user2[0].lastName;
    }
  }

  Future getdata(MatchListModel data) async {
    String userid = await getUserId();
    if (data.user1[0].userId != userid) {
      return UserNetwork().getMatchedprofiledata(data.user1[0].userId);
    } else {
      return UserNetwork().getMatchedprofiledata(data.user2[0].userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.matchList.length == 0
          ? noResult()
          : ListView.builder(
              itemCount: widget.matchList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    getdata(widget.matchList[index]);
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(16, 5, 16, 5),
                    leading: SizedBox(
                      width: 60,
                      height: 60,
                      child: FutureBuilder(
                        future: getimage(widget.matchList[index]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: imageViewer(snapshot.data));
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:
                                  Image.asset("assets/images/placeholder.png"),
                            );
                          }
                        },
                      ),
                    ),
                    title: FutureBuilder(
                      future: getname(widget.matchList[index]),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data);
                        } else {
                          return Text("");
                        }
                      },
                    ),
                    subtitle: FutureBuilder(
                      future: getlastname(widget.matchList[index]),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data);
                        } else {
                          return Text("");
                        }
                      },
                    ),
                  ),
                );
              }),
    );
  }
}
