import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/websize.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MassageCard extends StatefulWidget {
  final int index;
  final Function(int) onChanged;
  final Function onTap;
  final ChatGroup data;
  final bool onWeb;
  final int selectIndex;
  MassageCard(
      {Key key,
      this.onTap,
      this.data,
      this.onWeb = false,
      this.onChanged,
      this.index,
      this.selectIndex})
      : super(key: key);

  @override
  _MassageCardState createState() => _MassageCardState();
}

class _MassageCardState extends State<MassageCard> {
  goToChatPage(groupid, id, image, name) {
    NavigateFunction().withqueryReplace(Navigate.chattingPage +
        "?groupid=$groupid&id=$id&image=$image&name=$name");
    // Routes.sailor(Routes.chattingPage,
    //     params: {"groupid": groupid, "id": id, "image": image, "name": name});
  }

  String userid;

  @override
  void initState() {
    super.initState();
    getid();
  }

  getid() async {}

  Future<String> getimage() async {
    String userid = await getUserId();
    if (widget.data.user_id_1_details[0].userid != userid) {
      return widget.data.user_id_1_details[0].identificationImage;
    } else {
      return widget.data.user_id_2_details[0].identificationImage;
    }
  }

  Future<String> getname() async {
    String userid = await getUserId();
    if (widget.data.user_id_1_details[0].userid != userid) {
      return widget.data.user_id_1_details[0].firstname;
    } else {
      return widget.data.user_id_2_details[0].firstname;
    }
  }

  gopage() async {
    String userid = await getUserId();
    if (widget.data.user_id_1_details[0].userid != userid) {
      return goToChatPage(
          widget.data.id,
          widget.data.user_id_1_details[0].userid,
          widget.data.user_id_1_details[0].identificationImage,
          widget.data.user_id_1_details[0].firstname);
    } else {
      return goToChatPage(
          widget.data.id,
          widget.data.user_id_2_details[0].userid,
          widget.data.user_id_2_details[0].identificationImage,
          widget.data.user_id_2_details[0].firstname);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (widget.onWeb) {
            widget.onChanged(widget.index);
          } else {
            gopage();
          }
        },
        child: Padding(
          padding: EdgeInsets.all(widget.selectIndex == widget.index ? 8 : 0),
          child: Container(
            decoration: BoxDecoration(
                color: widget.selectIndex == widget.index
                    ? Colors.grey[200]
                    : null,
                borderRadius: BorderRadius.circular(10)),
            child: Container(
                margin: EdgeInsets.all(7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 10, start: 10),
                      child: FutureBuilder(
                        future: getimage(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ClipRRect(
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
                                  imageUrl: snapshot.data),
                            );
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                "assets/images/placeholder.png",
                                width: widget.onWeb ? 50 : 160.r,
                                height: widget.onWeb ? 50 : 160.r,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: FutureBuilder(
                              future: getname(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            widget.onWeb ? inputFont : 45.sp,
                                        fontFamily: "Nunito"),
                                  );
                                } else {
                                  return Text(
                                    " ",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: "Nunito"),
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            child: Text(
                              widget.data.chat_details.length != 0
                                  ? widget.data.chat_details[0].message
                                  : "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: widget.onWeb ? 14 : 40.sp,
                                  fontFamily: "Nunito"),
                            ),
                          ),
                        ],
                      )),
                    ),
                    if (widget.data.unreadCount != 0)
                      Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: MainTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.0.r),
                            child: Text(
                              widget.data.unreadCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.onWeb ? inputFont : 45.sp,
                              ),
                            ),
                          )),
                    SizedBox(
                      width: 10.w,
                    )
                  ],
                )),
          ),
        ));
  }
}
