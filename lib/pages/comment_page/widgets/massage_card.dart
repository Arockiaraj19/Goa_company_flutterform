import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/routes.dart';
import 'package:flutter/material.dart';

class MassageCard extends StatefulWidget {
  final double height;
  final double width;
  final Function onTap;
  final ChatGroup data;
  MassageCard({Key key, this.height, this.width, this.onTap, this.data})
      : super(key: key);

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
                          radius: 28,
                          backgroundImage: NetworkImage(
                            snapshot.data,
                          ),
                        );
                      } else {
                        return CircleAvatar(
                            radius: 28,
                            backgroundImage:
                                AssetImage("assets/images/placeholder.png"));
                      }
                    },
                  ),
                ),
                Container(
                    height: widget.height,
                    width: widget.width,
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
                                      fontSize: 16,
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
                            widget.data.chat_details[0].message,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontFamily: "Nunito"),
                          ),
                        ),
                      ],
                    ))
              ],
            )));
  }
}
