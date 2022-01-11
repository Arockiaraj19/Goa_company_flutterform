import 'package:dating_app/models/creategroup_model.dart';
import 'package:dating_app/models/subscription_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/home_button_network.dart';
import 'package:dating_app/pages/detail_page/widgets/detail_slider.dart';
import 'package:dating_app/pages/detail_page/widgets/percentage_matching_box.dart';
import 'package:dating_app/pages/home_page/widget/Image_swiper.dart';
import 'package:dating_app/pages/home_page/widget/bio.dart';
import 'package:dating_app/pages/home_page/widget/interest_box.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/notification_provider.dart';
import 'package:dating_app/providers/single_user_provider.dart';
import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/check_persentage.dart';
import 'package:dating_app/shared/helpers/loadingLottie.dart';
import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/animation_button.dart';
import 'package:dating_app/shared/widgets/bottmsheet.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:dating_app/shared/widgets/subheading.dart';
import 'package:dating_app/shared/widgets/subscription_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class DetailPage extends StatefulWidget {
  final String id;
  DetailPage({Key key, this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<SingleUserProvider>().getData(widget.id);
  }

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 769) {
        return _buildPhone();
      } else {
        return _buildWeb();
      }
    });
  }

  bool loadingstar = true;
  bool loadingheart = true;

  Widget _buildPhone() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MainTheme.appBarColor,
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
                padding: EdgeInsets.all(15),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 10,
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.black,
                    size: 25,
                  ),
                )),
          ),
          title: Text(
            "Details",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 50.sp,
                fontFamily: "Nunito"),
          ),
          actions: [
            // Container(
            //   margin: EdgeInsetsDirectional.only(end: 10),
            //   child: Icon(
            //     Icons.notifications_outlined,
            //     color: Colors.grey,
            //     size: 25,
            //   ),
            // )
          ],
        ),
        body: Consumer<SingleUserProvider>(builder: (context, data, child) {
          return SingleChildScrollView(
              child: Column(children: [
            Container(
                child: DetailSlider(
              promos: data.userData.profileImage,
            )),
            Container(
                padding: EdgeInsetsDirectional.only(start: 30, end: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(
                            "${data.userData.firstName ?? ""} ${data.userData.lastName ?? ""}, ${data.userData.age == null ? "" : data.userData.age.toString()}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 55.sp,
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
                          size: 40.sp,
                          color: MainTheme.primaryColor,
                        )),
                        Container(
                          child: Consumer<HomeProvider>(
                              builder: (context, gdata, child) {
                            return FutureBuilder(
                              future: getdistance(gdata.userData.location,
                                  data.userData.location),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data + " " + "Miles away",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 35.sp,
                                        fontFamily: "Nunito"),
                                  );
                                } else {
                                  return Text(
                                    "0 Miles away",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 35.sp,
                                        fontFamily: "Nunito"),
                                  );
                                }
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<SubscriptionProvider>(
                        builder: (context, subdata, child) {
                      return Consumer<HomeProvider>(
                          builder: (context, gdata, child) {
                        return Container(
                            // width: 300,
                            padding:
                                EdgeInsetsDirectional.only(start: 20, end: 20),
                            child: AnimationButton(
                              loadingstar: gdata.showstar,
                              loadingheart: gdata.showheart,
                              goChatPage: () async {
                                print("hello");

                                try {
                                  String groupid = await ChatNetwork()
                                      .createGroup(
                                          data.userData.id, gdata.userData);

                                  goToChatPage(
                                      groupid,
                                      data.userData.id,
                                      data.userData.identificationImage,
                                      data.userData.firstName);
                                } on DioError catch (e) {
                                  if (e.response.statusCode == 408) {
                                    if (subdata.plan == null) {
                                      if (subdata.subscriptionData.length ==
                                          0) {
                                        subdata.getdata();
                                        BottomSheetClass()
                                            .showplans(context, false);
                                      } else {
                                        BottomSheetClass()
                                            .showplans(context, false);
                                      }
                                    }
                                  }
                                }
                              },
                              isDetail: true,
                              onTapHeart: () async {
                                await context
                                    .read<HomeProvider>()
                                    .changeheart();
                                String confirmedUser = data.userData.id;
                                UserModel userData = gdata.userData;
                                try {
                                  await HomeButtonNetwork().postMatchRequest(
                                      confirmedUser, userData);
                                } on DioError catch (e) {
                                  if (e.response.statusCode == 408) {
                                    if (subdata.plan == null) {
                                      if (subdata.subscriptionData.length ==
                                          0) {
                                        subdata.getdata();
                                        BottomSheetClass()
                                            .showplans(context, false);
                                      } else {
                                        BottomSheetClass()
                                            .showplans(context, false);
                                      }
                                    }
                                  }
                                }
                              },
                              onTapFlash: () async {
                                print("you click super star");
                                await context.read<HomeProvider>().changestar();
                                String likedUser = data.userData.id;
                                try {
                                  await HomeButtonNetwork()
                                      .postLikeUnlike(likedUser, "1");
                                } on DioError catch (e) {
                                  if (e.response.statusCode == 408) {
                                    if (subdata.plan == null) {
                                      if (subdata.subscriptionData.length ==
                                          0) {
                                        subdata.getdata();
                                        BottomSheetClass()
                                            .showplans(context, false);
                                      } else {
                                        BottomSheetClass()
                                            .showplans(context, false);
                                      }
                                    }
                                  }
                                }
                              },
                            ));
                      });
                    }),
                    Row(
                      children: [
                        Container(
                          margin:
                              EdgeInsetsDirectional.only(top: 30, bottom: 10),
                          child: Text(
                            "About me",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 55.sp,
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
                          data.userData.bio ?? "",
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: selected ? 10 : 2,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40.sp,
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
                                        fontSize: 40.sp,
                                        fontFamily: "Nunito"),
                                  )
                                : Text(
                                    'See more',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 40.sp,
                                        fontFamily: "Nunito"),
                                  ))
                      ],
                    ),

                    Stack(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              gradient: MainTheme.detailPageCard,
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: Colors.grey, blurRadius: 1.0)
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(10),
                            margin:
                                EdgeInsetsDirectional.only(top: 20, bottom: 20),
                            height: 120.h,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Row(
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: Consumer<HomeProvider>(
                                            builder: (context, gdata, child) {
                                              return Container(
                                                child: FutureBuilder(
                                                  future: Persentage()
                                                      .checkSingleSuggestionPresentage(
                                                          gdata.userData,
                                                          data.userData),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        "You and ${data.userData.firstName} have ${(snapshot.data * 100).round().toString()}% of matching",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 50.sp,
                                                            fontFamily:
                                                                "Nunito"),
                                                      );
                                                    } else {
                                                      return Text(
                                                        "You and ${data.userData.firstName} have 0% of matching",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 55.sp,
                                                            fontFamily:
                                                                "Nunito"),
                                                      );
                                                    }
                                                  },
                                                ),
                                              );
                                            },
                                          )),
                                      Container(
                                        color: Colors.transparent,
                                        height: 100.r,
                                        width: 150.r,
                                      )
                                    ],
                                  )),
                                  Row(
                                    children: [
                                      Text(
                                        'Show me',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 35.sp,
                                            fontFamily: "Nunito"),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.white70,
                                        size: 35.sp,
                                      ),
                                    ],
                                  )
                                ])),
                        Positioned(
                            top: -20,
                            right: 5,
                            child: Container(
                                height: 120.h,
                                width: 200.w,
                                child: Image.asset(
                                  "assets/images/boy_walk.png",
                                  fit: BoxFit.cover,
                                )))
                      ],
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
                                    child: Padding(
                                      padding: EdgeInsets.all(15.0.r),
                                      child: Image.asset(
                                        "assets/icons/swim.png",
                                        color: MainTheme.primaryColor,
                                        width: 60.r,
                                        height: 60.r,
                                      ),
                                    ))),
                            Container(
                                margin: EdgeInsetsDirectional.only(start: 15),
                                child: CircleAvatar(
                                    backgroundColor: Colors.grey[350],
                                    radius: 20,
                                    child: Padding(
                                      padding: EdgeInsets.all(15.0.r),
                                      child: Image.asset(
                                        "assets/icons/bag.png",
                                        width: 60.r,
                                        height: 60.r,
                                        color: MainTheme.primaryColor,
                                      ),
                                    ))),
                            Container(
                                child: CircleAvatar(
                                    backgroundColor: Colors.grey[350],
                                    radius: 20,
                                    child: Padding(
                                      padding: EdgeInsets.all(15.0.r),
                                      child: Image.asset(
                                        "assets/icons/book.png",
                                        width: 60.r,
                                        height: 60.r,
                                        color: MainTheme.primaryColor,
                                      ),
                                    )))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<HomeProvider>(
                                builder: (context, ddata, child) {
                              return Container(
                                margin: EdgeInsetsDirectional.only(start: 10),
                                child: FutureBuilder(
                                  future: Persentage().interestSinglePercentage(
                                      ddata.userData, data.userData),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        "${snapshot.data} + same interests",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 46.sp,
                                            fontFamily: "Nunito"),
                                      );
                                    } else {
                                      return Text(
                                        "0+ same interests",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 46.sp,
                                            fontFamily: "Nunito"),
                                      );
                                    }
                                  },
                                ),
                              );
                            }),
                            Container(
                                margin: EdgeInsetsDirectional.only(start: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Show me',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 35.sp,
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
          ]));
        }));
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height - (kToolbarHeight);
    var _width = MediaQuery.of(context).size.width - 30;

    return Scaffold(
        body: BaseLayout(
            navigationRail: NavigationMenu(
              currentTabIndex: 0,
            ),
            body: Scaffold(
                appBar: AppBar(
                  backgroundColor: MainTheme.appBarColor,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  actions: [
                    Container(
                        margin: EdgeInsetsDirectional.only(
                            top: 5, end: 20, bottom: 5),
                        child: Consumer<NotificationProvider>(
                          builder: (context, data, child) {
                            return InkWell(
                              onTap: () {
                                return BottomSheetClass().shownav(context);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.notifications_outlined,
                                      color: Colors.grey,
                                      size: 25,
                                    ),
                                  ),
                                  if (data.notificationData.length != 0)
                                    Positioned(
                                      right: 8,
                                      top: 2,
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                            color: MainTheme.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            data.notificationData.length
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          )),
                                    )
                                ],
                              ),
                            );
                          },
                        ))
                  ],
                ),
                body: Consumer<SingleUserProvider>(
                    builder: (context, data, child) {
                  return data.homeState == SingleUserState.Loaded
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 40.w),
                                child: Column(
                                  children: [
                                    Container(
                                        height: _height - 50,
                                        width: _width * 0.450,
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          child: Consumer<SubscriptionProvider>(
                                            builder: (context, subdata, child) {
                                              return Column(children: [
                                                Expanded(
                                                  child: Container(
                                                      child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(data
                                                        .userData
                                                        .identificationImage),
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Consumer<HomeProvider>(builder:
                                                    (context, hdata, child) {
                                                  return Container(
                                                      child: AnimationButton(
                                                    isDetail: true,
                                                    loadingstar: hdata.showstar,
                                                    loadingheart:
                                                        hdata.showheart,
                                                    goChatPage: () async {
                                                      print("message");
                                                      try {
                                                        String groupid =
                                                            await ChatNetwork()
                                                                .createGroup(
                                                                    data.userData
                                                                        .id,
                                                                    hdata
                                                                        .userData);
                                                        goToChatPage(
                                                            groupid,
                                                            data.userData.id,
                                                            data.userData
                                                                .identificationImage,
                                                            data.userData
                                                                .firstName);
                                                      } on DioError catch (e) {
                                                        if (e.response
                                                                .statusCode ==
                                                            408) {
                                                          if (subdata.plan ==
                                                              null) {
                                                            if (subdata
                                                                    .subscriptionData
                                                                    .length ==
                                                                0) {
                                                              subdata.getdata();
                                                              BottomSheetClass()
                                                                  .showplans(
                                                                      context,
                                                                      true);
                                                            } else {
                                                              BottomSheetClass()
                                                                  .showplans(
                                                                      context,
                                                                      true);
                                                            }
                                                          }
                                                        }
                                                        print(e);
                                                      }
                                                    },
                                                    onTapHeart: () async {
                                                      await context
                                                          .read<HomeProvider>()
                                                          .changeheart();
                                                      String confirmedUser =
                                                          data.userData.id;
                                                      UserModel userData =
                                                          data.userData;
                                                      try {
                                                        await HomeButtonNetwork()
                                                            .postMatchRequest(
                                                                confirmedUser,
                                                                userData);
                                                      } on DioError catch (e) {
                                                        if (e.response
                                                                .statusCode ==
                                                            408) {
                                                          if (subdata.plan ==
                                                              null) {
                                                            if (subdata
                                                                    .subscriptionData
                                                                    .length ==
                                                                0) {
                                                              subdata.getdata();
                                                              return BottomSheetClass()
                                                                  .showplans(
                                                                      context,
                                                                      true);
                                                            } else {
                                                              return BottomSheetClass()
                                                                  .showplans(
                                                                      context,
                                                                      true);
                                                            }
                                                          }
                                                        }
                                                      }
                                                    },
                                                    onTapFlash: () async {
                                                      print("you click star");
                                                      await context
                                                          .read<HomeProvider>()
                                                          .changestar();
                                                      String likedUser =
                                                          data.userData.id;
                                                      try {
                                                        await HomeButtonNetwork()
                                                            .postLikeUnlike(
                                                                likedUser, "1");
                                                      } on DioError catch (e) {
                                                        if (e.response
                                                                .statusCode ==
                                                            408) {
                                                          if (subdata.plan ==
                                                              null) {
                                                            if (subdata
                                                                    .subscriptionData
                                                                    .length ==
                                                                0) {
                                                              subdata.getdata();
                                                              return BottomSheetClass()
                                                                  .showplans(
                                                                      context,
                                                                      true);
                                                            } else {
                                                              return BottomSheetClass()
                                                                  .showplans(
                                                                      context,
                                                                      true);
                                                            }
                                                          }
                                                        }
                                                        print(e);
                                                      }
                                                    },
                                                  ));
                                                }),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                              ]);
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 110,
                                      width: _width * 0.355,
                                      child: Bio(
                                        bio: data.userData.bio,
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              gradient:
                                                  MainTheme.detailPageCard,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 1.0)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            padding: EdgeInsetsDirectional.only(
                                              start: 40,
                                            ),
                                            margin: EdgeInsetsDirectional.only(
                                                top: 20),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            width: _width * 0.355,
                                            child: Consumer<HomeProvider>(
                                                builder:
                                                    (context, hdata, child) {
                                              return FutureBuilder(
                                                  future: Persentage()
                                                      .checkSingleSuggestionPresentage(
                                                          hdata.userData,
                                                          data.userData),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              "You and ${data.userData.firstName}",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Nunito"),
                                                            )),
                                                            Container(
                                                              child: Text(
                                                                "${(snapshot.data * 100).round().toString()}% of matching",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        "Nunito"),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  EdgeInsetsDirectional
                                                                      .only(
                                                                          top:
                                                                              5),
                                                              child: Text(
                                                                'Show me',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white70,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        "Nunito"),
                                                              ),
                                                              // Icon(
                                                              //   Icons.keyboard_arrow_right,
                                                              //   color: Colors.white70,
                                                              //   size: 10,
                                                              // ),
                                                            )
                                                          ]);
                                                    } else {
                                                      return Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              "You and ${data.userData.firstName}",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Nunito"),
                                                            )),
                                                            Container(
                                                              child: Text(
                                                                "0% of matching",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        "Nunito"),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  EdgeInsetsDirectional
                                                                      .only(
                                                                          top:
                                                                              5),
                                                              child: Text(
                                                                'Show me',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white70,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        "Nunito"),
                                                              ),
                                                              // Icon(
                                                              //   Icons.keyboard_arrow_right,
                                                              //   color: Colors.white70,
                                                              //   size: 10,
                                                              // ),
                                                            )
                                                          ]);
                                                    }
                                                  });
                                            })),
                                        Positioned(
                                            top: -20,
                                            right: 40,
                                            child: Container(
                                                height: 100,
                                                width: 50,
                                                child: Image.asset(
                                                  "assets/images/boy_walk.png",
                                                  fit: BoxFit.cover,
                                                )))
                                      ],
                                    ),
                                    SubHeading(name: "Intersest"),
                                    Container(
                                      width: _width * 0.355,
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 0.0,
                                                mainAxisSpacing: 0.0,
                                                crossAxisCount: 4,
                                                childAspectRatio: 2.8),
                                        itemCount: data
                                            .userData.interestDetails.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InterestBox(
                                            fillColor: Colors.white,
                                            fontSize: ScreenUtil().setSp(
                                                MainTheme
                                                    .mSecondaryContentfontSize),
                                            color: MainTheme.primaryColor,
                                            title: data
                                                    .userData
                                                    .interestDetails[index]
                                                    .title ??
                                                "",
                                            onTap: () {},
                                          );
                                        },
                                      ),
                                    ),
                                    SubHeading(name: "Hobbies"),
                                    Container(
                                      width: _width * 0.355,
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 0.0,
                                                mainAxisSpacing: 0.0,
                                                crossAxisCount: 4,
                                                childAspectRatio: 2.8),
                                        itemCount:
                                            data.userData.hobbyDetails.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InterestBox(
                                            fillColor: Colors.white,
                                            fontSize: ScreenUtil().setSp(
                                                MainTheme
                                                    .mSecondaryContentfontSize),
                                            color: MainTheme.primaryColor,
                                            title: data
                                                    .userData
                                                    .hobbyDetails[index]
                                                    .title ??
                                                "",
                                            onTap: () {},
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : LoadingLottie();
                }))));
  }
}

class Conatiner {}

goToChatPage(groupid, id, image, name) {
  NavigateFunction().withquery(Navigate.chattingPage +
      "?groupid=$groupid&id=$id&image=$image&name=$name&onWeb=true");
}
