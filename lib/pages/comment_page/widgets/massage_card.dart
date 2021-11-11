import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MassageCard extends StatefulWidget {
  final Function onTap;
  final ChatGroup data;
  MassageCard({Key key, this.onTap, this.data}) : super(key: key);

  @override
  _MassageCardState createState() => _MassageCardState();
}

class _MassageCardState extends State<MassageCard> {
  goToChatPage(groupid, id, image, name) {
    Routes.sailor(Routes.chattingPage,
        params: {"groupid": groupid, "id": id, "image": image, "name": name});
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
          gopage();
        },
        child: Container(
            margin: EdgeInsets.all(7),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(end: 10, start: 10),
                  child: FutureBuilder(
                    future: getimage(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          maxRadius: 80.r,
                          minRadius: 70.r,
                          backgroundImage: NetworkImage(
                            snapshot.data,
                          ),
                        );
                      } else {
                        return CircleAvatar(
                          maxRadius: 80.r,
                          minRadius: 70.r,
                            backgroundImage:
                                AssetImage("assets/images/placeholder.png"));
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
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50.sp,
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
                              fontSize: 40.sp,
                              fontFamily: "Nunito"),
                        ),
                      ),
                    ],
                  )),
                )
              ],
            )));
  }
}
