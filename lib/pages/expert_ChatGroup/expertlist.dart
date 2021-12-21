import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/models/expertGroup_model.dart';
import 'package:dating_app/networks/expertChat_netword.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/pages/expert_ChatGroup/expertChattingPage.dart';
import 'package:dating_app/pages/home_page/widget/circularBtn.dart';
import 'package:dating_app/providers/home_provider.dart';

import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/websize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';

class ExpertCard extends StatefulWidget {
  final Function onTap;
  final ExpertGroup data;
  final bool onWeb;
  ExpertCard({Key key, this.onTap, this.data, this.onWeb}) : super(key: key);

  @override
  _ExpertCardState createState() => _ExpertCardState();
}

class _ExpertCardState extends State<ExpertCard> {
  goToChatPage() async {
    String groupId = await ExpertNetwork()
        .createGroup(widget.data.id, context.read<HomeProvider>().userData);
    NavigateFunction().withquery(Navigate.expertchat +
        "?groupid=$groupId&id=${widget.data.id}&name=${widget.data.firstname}&status=${widget.data.onlinestatus}&image=${widget.data.profileImage}&onWeb=${widget.onWeb}");
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
          if (!widget.onWeb) {
            goToChatPage();
          }
        },
        child: Container(
            margin: EdgeInsets.all(7),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(end: 10, start: 10),
                  child: widget.data.profileImage.length == 0
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            "assets/images/placeholder.png",
                            width: widget.onWeb ? 50 : 160.r,
                            height: widget.onWeb ? 50 : 160.r,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              width: widget.onWeb ? 50 : 160.r,
                              height: widget.onWeb ? 50 : 160.r,
                              placeholder: (context, url) => Image.asset(
                                    "assets/images/placeholder.png",
                                    width: widget.onWeb ? 50 : 160.r,
                                    height: widget.onWeb ? 50 : 160.r,
                                    fit: BoxFit.cover,
                                  ),
                              imageUrl: widget.data.profileImage[0]),
                        ),
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
                                  fontSize: widget.onWeb ? inputFont : 45.sp,
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
                ),
                if (widget.onWeb)
                  CircularBtn(
                      icon: FontAwesomeIcons.solidPaperPlane,
                      btnColor: Color(0xffF85565),
                      ontap: () {
                        if (widget.onWeb) {
                          goToChatPage();
                        }
                      }),
                if (widget.onWeb)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  )
              ],
            )));
  }
}
