import 'dart:async';
import 'dart:io';

import 'package:dating_app/models/firebase_messing.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/pages/detail_page/widgets/percentage_matching_box.dart';
import 'package:dating_app/pages/home_page/widget/Image_swiper.dart';
import 'package:dating_app/pages/home_page/widget/bio.dart';
import 'package:dating_app/pages/home_page_grid_view_page/home_page_grid_view_page.dart';
import 'package:dating_app/providers/chat_provider.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/notification_provider.dart';
import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/loadingLottie.dart';
import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/album_card_list.dart';
import 'package:dating_app/shared/widgets/alert_widget.dart';
import 'package:dating_app/shared/widgets/bottmsheet.dart';
import 'package:dating_app/shared/widgets/bottom_bar.dart';
import 'package:dating_app/shared/widgets/animation_button.dart';
import 'package:dating_app/shared/widgets/error_card.dart';
import 'package:dating_app/shared/widgets/filter_bottom_sheet.dart';
import 'package:dating_app/shared/widgets/home_page_grid_view_list.dart';
import 'package:dating_app/shared/widgets/interest_card_list.dart';
import 'package:dating_app/shared/widgets/main_appbar.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:dating_app/shared/widgets/subheading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sailor/sailor.dart';

import 'widget/interest_box.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var val = 1;
  Future<bool> val1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("home page kku varuthaa");
    FCM().initPushNotification();
    if (context.read<HomeProvider>().userData == null) {
      getdata();
      getnotifi();
    }
    Future.delayed(Duration(milliseconds: 500), () {
      if (context.read<SubscriptionProvider>().plan == null) {
        context.read<SubscriptionProvider>().getprofilecount();
      }
      if (context.read<HomeProvider>().userData.chatCountUpdate != null) {
        Duration difference = DateTime.now()
            .difference(context.read<HomeProvider>().userData.chatCountUpdate);
        print("difference in days");
        print(difference.inDays);
        if (difference.inDays >= 1) {
          callCountUpdate();
        }
      }
    });
  }

  getdata() async {
    await context.read<SubscriptionProvider>().checkplans();
  }

  getnotifi() async {
    context.read<HomeProvider>().getData();

    context.read<NotificationProvider>().getData();
  }

  callCountUpdate() async {
    await ChatNetwork().updateUserCount();
  }

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

  Future<void> _pullRefresh() async {
    context.read<HomeProvider>().reload();
  }

  Widget _buildPhone() {
    var _height = MediaQuery.of(context).size.height - kToolbarHeight;
    var _textStyleforHeading = TextStyle(
        color: MainTheme.mainHeadingColors,
        fontWeight: FontWeight.bold,
        fontSize: 50.sp,
        fontFamily: "lato");
    return WillPopScope(
      onWillPop: () {
        Alert().showAlertDialog(context);
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 50.w),
                child: Consumer<NotificationProvider>(
                  builder: (context, data, child) {
                    return InkWell(
                      onTap: () {
                        NavigateFunction().withquery(Navigate.notification);
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
                                    data.notificationData.length.toString(),
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
                ),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 0),
                child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      FittedBox(
                        child: Container(
                          child: Text("Discover", style: _textStyleforHeading),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showOtpBottomSheet();
                        },
                        child: FittedBox(
                          child: Image.asset(
                            "assets/icons/adjust.png",
                            color: Colors.grey,
                            width: 18.h,
                          ),
                        ),
                      )
                    ])),
              ),
              Expanded(
                child: Consumer<SubscriptionProvider>(
                    builder: (context, sub, child) {
                  return sub.subscriptionState == SubscriptionState.Error
                      ? ErrorCard(
                          text: sub.errorText,
                          ontab: () => NavigateFunction()
                              .withqueryReplace(Navigate.homePage))
                      : Consumer<HomeProvider>(builder: (context, data, child) {
                          return data.homeState == HomeState.Error
                              ? ErrorCard(
                                  text: data.errorText,
                                  ontab: () => NavigateFunction()
                                      .withqueryReplace(Navigate.homePage))
                              : data.homeState == HomeState.Loaded
                                  ? data.usersSuggestionData.response.length ==
                                          0
                                      ? noResult()
                                      : data.view == 1
                                          ? ImageSwiper(
                                              userSuggestionData:
                                                  data.usersSuggestionData,
                                              promos: [
                                                "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                                                "https://us.123rf.com/450wm/vadymvdrobot/vadymvdrobot1803/vadymvdrobot180303570/97983244-happy-asian-woman-in-t-shirt-bites-eyeglasses-and-looking-at-the-camera-over-grey-background.jpg?ver=6",
                                                "https://cdn.lifehack.org/wp-content/uploads/2014/03/shutterstock_97566446.jpg",
                                                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"
                                              ],
                                              onTap: (dynamic promo) {},
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: HomePageGridViewPage(
                                                usersData:
                                                    data.usersSuggestionData,
                                              ),
                                            )
                                  : LoadingLottie();
                        });
                }),
              ),
            ],
          ),
        ),
        floatingActionButton:
            Consumer<HomeProvider>(builder: (context, data, child) {
          return FloatingActionButton(
            backgroundColor: Colors.white,
            child: data.view == 2
                ? Icon(
                    Icons.grid_view_outlined,
                    color: MainTheme.primaryColor,
                  )
                : Icon(
                    Icons.list,
                    color: MainTheme.primaryColor,
                  ),
            onPressed: () {
              if (data.view == 1) {
                data.changeView(2);
              } else {
                data.changeView(1);
              }
            },
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomTabBar(
          currentIndex: 0,
        ),
      ),
    );
  }

  // goToFilterPage() {
  //   Routes.sailor(
  //     Routes.filterPage,
  //   );
  // }

  // goToPerfectMatchPage() {
  //   Routes.sailor(
  //     Routes.perfectMatchPage,
  //   );
  // }

  _showOtpBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        // isDismissible: false,
        // enableDrag: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [FilterBottomSheet()]),
          );
        });
  }

  int cardIndex = 0;
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
                body: Consumer<HomeProvider>(builder: (context, data, child) {
                  return data.homeState == HomeState.Loaded
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
                                        alignment: Alignment.centerLeft,
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                20.w,
                                                0,
                                                0,
                                                0,
                                              ),
                                              child: Text(
                                                "Discover",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        height: _height - 50,
                                        width: _width * 0.450,
                                        child: ImageSwiper(
                                          onChanged: (int index) {
                                            print(
                                                "initiala home page kku index varutha web la");
                                            print(index);
                                            setState(() {
                                              cardIndex = index;
                                            });
                                          },
                                          // height: _height - 150,
                                          // width: _width * 0.450,
                                          // itemheight: _height - 150,
                                          // itemwidth: _width / 3.2,
                                          userSuggestionData:
                                              data.usersSuggestionData,
                                          promos: [
                                            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                                            "https://us.123rf.com/450wm/vadymvdrobot/vadymvdrobot1803/vadymvdrobot180303570/97983244-happy-asian-woman-in-t-shirt-bites-eyeglasses-and-looking-at-the-camera-over-grey-background.jpg?ver=6",
                                            "https://cdn.lifehack.org/wp-content/uploads/2014/03/shutterstock_97566446.jpg",
                                            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"
                                          ],
                                          onTap: (dynamic promo) {},
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
                                        bio: data.usersSuggestionData
                                            .response[cardIndex].bio,
                                      ),
                                    ),
                                    PercentageMatchingBox(
                                      width: _width * 0.355,
                                      height: 80,
                                      onWeb: true,
                                      userSuggestionData: data
                                          .usersSuggestionData
                                          .response[cardIndex],
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
                                            .usersSuggestionData
                                            .response[cardIndex]
                                            .interestDetails
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InterestBox(
                                            fillColor: Colors.white,
                                            fontSize: ScreenUtil().setSp(
                                                MainTheme
                                                    .mSecondaryContentfontSize),
                                            color: MainTheme.primaryColor,
                                            title: data
                                                    .usersSuggestionData
                                                    .response[cardIndex]
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
                                        itemCount: data
                                            .usersSuggestionData
                                            .response[cardIndex]
                                            .hobbyDetails
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InterestBox(
                                            fillColor: Colors.white,
                                            fontSize: ScreenUtil().setSp(
                                                MainTheme
                                                    .mSecondaryContentfontSize),
                                            color: MainTheme.primaryColor,
                                            title: data
                                                    .usersSuggestionData
                                                    .response[cardIndex]
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
