import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/models/expertGroup_model.dart';
import 'package:dating_app/networks/expertChat_netword.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/pages/expert_ChatGroup/expertChattingPage.dart';
import 'package:dating_app/providers/home_provider.dart';

import 'package:dating_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class ExpertCard extends StatefulWidget {
  final Function onTap;
  final ExpertGroup data;
  ExpertCard({Key key, this.onTap, this.data}) : super(key: key);

  @override
  _ExpertCardState createState() => _ExpertCardState();
}

class _ExpertCardState extends State<ExpertCard> {
  goToChatPage() async {
    String groupId = await ExpertNetwork()
        .createGroup(widget.data.id, context.read<HomeProvider>().userData);
    Routes.sailor(Routes.expertchat, params: {
      "groupid": groupId,
      "id": widget.data.id,
      "name": widget.data.firstname,
      "status": widget.data.onlinestatus,
      "image": widget.data.profileImage,
    });
  }

  String userid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          goToChatPage();
        },
        child: Container(
            margin: EdgeInsets.all(7),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(end: 10, start: 10),
                  child: widget.data.profileImage.length == 0
                      ? CircleAvatar(
                          maxRadius: 80.r,
                          minRadius: 70.r,
                          backgroundImage:
                              AssetImage("assets/images/placeholder.png"))
                      : CircleAvatar(
                          maxRadius: 80.r,
                          minRadius: 70.r,
                          backgroundImage:
                              NetworkImage(widget.data.profileImage[0])),
                ),
                Expanded(
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              widget.data.firstname,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 45.sp,
                                  fontFamily: "Nunito"),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          if (widget.data.onlinestatus == 1)
                            Container(
                              height: 7,
                              width: 7,
                              decoration: BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle),
                            )
                        ],
                      ),
                      // Container(
                      //   child: Text(
                      //   "",
                      //     maxLines: 1,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: TextStyle(
                      //         color: Colors.grey,
                      //         fontSize: 40.sp,
                      //         fontFamily: "Nunito"),
                      //   ),
                      // ),
                    ],
                  )),
                )
              ],
            )));
  }
}
