import 'package:dating_app/models/creategroup_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/home_button_network.dart';
import 'package:dating_app/pages/detail_page/widgets/detail_slider.dart';
import 'package:dating_app/pages/detail_page/widgets/percentage_matching_box.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/animation_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Responses userDetails;
  DetailPage({Key key, this.userDetails}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return _buildPhone();
      } else {
        return _buildWeb();
      }
    });
  }

  Widget _buildPhone() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MainTheme.appBarColor,
          elevation: 0,
          actions: [
            Container(
              margin: EdgeInsetsDirectional.only(end: 10),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.grey,
                size: 25,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  child: Text(
                    "Details",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: "Nunito"),
                  ),
                ),
              ],
            )),
            Positioned(
              left: 10,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 15,
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black,
                    ),
                  ))),
            )
          ]),
          Row(
            children: [
              Container(
                  child: DetailSlider(
                promos: widget.userDetails.profileImage,
              ))
            ],
          ),
          Container(
              padding: EdgeInsetsDirectional.only(start: 30, end: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "${widget.userDetails.firstName ?? ""} ${widget.userDetails.lastName ?? ""}, ${widget.userDetails.age == null ? "" : widget.userDetails.age.toString()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontFamily: "Nunito"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          child: Icon(
                        Icons.location_on,
                        size: 13,
                        color: MainTheme.primaryColor,
                      )),
                      Container(
                        child: Text(
                          "Distance(2km)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: "Nunito"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<HomeProvider>(builder: (context, data, child) {
                    return Container(
                        // width: 300,
                        padding: EdgeInsetsDirectional.only(start: 20, end: 20),
                        child: AnimationButton(
                          goChatPage: () async {
                            print("hello");

                            String groupid = await ChatNetwork()
                                .createGroup(widget.userDetails.id);
                            print("front la data varuthaa");
                            print(groupid);
                            print(widget.userDetails.id);
                            goToChatPage(groupid, widget.userDetails.id);
                          },
                          isDetail: true,
                          onTapHeart: () {
                            String confirmedUser = widget.userDetails.id;
                            UserModel userData = data.userData;
                            HomeButtonNetwork()
                                .postMatchRequest(confirmedUser, userData);
                          },
                          onTapFlash: () {
                            String likedUser = widget.userDetails.id;
                            HomeButtonNetwork().postLikeUnlike(likedUser, "1");
                          },
                        ));
                  }),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(top: 30, bottom: 10),
                        child: Text(
                          "About me",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: "Nunito"),
                        ),
                      ),
                    ],
                  ),
                  AnimatedContainer(
                      width: MediaQuery.of(context).size.width,
                      height: selected
                          ? ScreenUtil().setHeight(100)
                          : ScreenUtil().setHeight(50),
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      child: Text(
                        widget.userDetails.bio ?? "",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: selected ? 10 : 2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: "Nunito"),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = !selected;
                            });
                          },
                          child: selected
                              ? Text(
                                  'See less',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontFamily: "Nunito"),
                                )
                              : Text(
                                  'See more',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontFamily: "Nunito"),
                                ))
                    ],
                  ),

                  PercentageMatchingBox(
                    userSuggestionData: widget.userDetails,
                  ),

                  // Stack(
                  //   children: [
                  //     Container(
                  //         decoration: BoxDecoration(
                  //           color: MainTheme.primaryColor,
                  //           boxShadow: <BoxShadow>[
                  //             BoxShadow(color: Colors.grey, blurRadius: 1.0)
                  //           ],
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         padding: EdgeInsets.all(10),
                  //         margin:
                  //             EdgeInsetsDirectional.only(top: 20, bottom: 20),
                  //         height: MediaQuery.of(context).size.height / 7,
                  //         width: MediaQuery.of(context).size.width,
                  //         child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                   child: Row(
                  //                 children: [
                  //                   Expanded(
                  //                       flex: 3,
                  //                       child: Container(
                  //                         child: Text(
                  //                           "You and Adrianne have 85% of matching",
                  //                           maxLines: 2,
                  //                           overflow: TextOverflow.ellipsis,
                  //                           style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontWeight: FontWeight.bold,
                  //                               fontSize: 15,
                  //                               fontFamily: "Nunito"),
                  //                         ),
                  //                       )),
                  //                   Container(
                  //                     color: MainTheme.primaryColor,
                  //                     height: 50,
                  //                     width: 50,
                  //                   )
                  //                 ],
                  //               )),
                  //               Row(
                  //                 children: [
                  //                   Text(
                  //                     'Show me',
                  //                     style: TextStyle(
                  //                         color: Colors.white70,
                  //                         fontSize: 12,
                  //                         fontFamily: "Nunito"),
                  //                   ),
                  //                   Icon(
                  //                     Icons.keyboard_arrow_right,
                  //                     color: Colors.white70,
                  //                     size: 10,
                  //                   ),
                  //                 ],
                  //               )
                  //             ])),
                  //     Positioned(
                  //         top: -20,
                  //         right: 5,
                  //         child: Container(
                  //             height: 100,
                  //             width: 50,
                  //             child: Image.asset(
                  //               "assets/images/boy_walk.png",
                  //               fit: BoxFit.cover,
                  //             )))
                  //   ],
                  // ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        fit: StackFit.loose,
                        children: [
                          Container(
                              margin: EdgeInsetsDirectional.only(start: 30),
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey[350],
                                  radius: 20,
                                  child: Image.asset(
                                    "assets/icons/swim.png",
                                    color: Colors.red,
                                    width: 20,
                                    height: 20,
                                  ))),
                          Container(
                              margin: EdgeInsetsDirectional.only(start: 15),
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey[350],
                                  radius: 20,
                                  child: Image.asset(
                                    "assets/icons/bag.png",
                                    width: 20,
                                    height: 20,
                                    color: Colors.red,
                                  ))),
                          Container(
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey[350],
                                  radius: 20,
                                  child: Image.asset(
                                    "assets/icons/book.png",
                                    width: 20,
                                    height: 20,
                                    color: Colors.red,
                                  )))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 10),
                            child: Text(
                              "6+ same interests",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: "Nunito"),
                            ),
                          ),
                          Container(
                              margin: EdgeInsetsDirectional.only(start: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Show me',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: "Nunito"),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.black,
                                    size: 10,
                                  ),
                                ],
                              ))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ))
        ])));
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height - (kToolbarHeight);
    var _width = MediaQuery.of(context).size.width - 30;

    return Scaffold();
  }
}

class Conatiner {}

goToChatPage(groupid, id) {
  Routes.sailor(Routes.chattingPage, params: {"groupid": groupid, "id": id});
}
