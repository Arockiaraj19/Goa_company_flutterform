import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dating_app/providers/notification_provider.dart';
import 'package:dating_app/shared/helpers/websize.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/subscription_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/instagram.dart';
import 'package:dating_app/networks/ref_network.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/networks/subscription.dart';
import 'package:dating_app/networks/topic_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/pages/about_page/aboutUs_page.dart';

import 'package:dating_app/pages/home_page/widget/interest_box.dart';
import 'package:dating_app/pages/profile_page/widgets/percentage_bar.dart';
import 'package:dating_app/pages/profile_page/widgets/scores.dart';
import 'package:dating_app/pages/profile_page/widgets/setting_box.dart';
import 'package:dating_app/pages/profile_page/widgets/social_media_box.dart';
import 'package:dating_app/providers/expertChat_provider.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/shared/helpers/check_persentage.dart';
import 'package:dating_app/shared/helpers/loadingLottie.dart';
import 'package:dating_app/shared/helpers/regex_pattern.dart';
import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/album_card_list.dart';
import 'package:dating_app/shared/widgets/alert_widget.dart';
import 'package:dating_app/shared/widgets/bottmsheet.dart';
import 'package:dating_app/shared/widgets/bottom_bar.dart';
import 'package:dating_app/shared/widgets/error_card.dart';
import 'package:dating_app/shared/widgets/filter_bottom_sheet1.dart';
import 'package:dating_app/shared/widgets/interest_card_list.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:dating_app/shared/widgets/subheading.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import '../../routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController _tabController;
  var val = 1;
  Future<bool> val1;
  int likeCount = -1, matchCount = -1;

  getData() async {
    likeCount = await UserNetwork().getUserLikeCount();
    matchCount = await UserNetwork().getUserMatchCount();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _tabController = TabController(length: 2, vsync: this);
    if (context.read<HomeProvider>().userData == null) {
      context.read<HomeProvider>().getData();
    }
    // _createRewardedAd();
  }

  // static final AdRequest request = AdRequest(
  //   keywords: <String>['Book', 'Game'],
  //   nonPersonalizedAds: true,
  // );

  // RewardedAd _rewardedAd;
  // int _numRewardedLoadAttempts = 0;
  // bool show = false;

  // void _createRewardedAd() {
  //   RewardedAd.load(
  //       adUnitId: "ca-app-pub-3940256099942544/5224354917",
  //       request: request,
  //       rewardedAdLoadCallback: RewardedAdLoadCallback(
  //         onAdLoaded: (RewardedAd ad) {
  //           print('$ad loaded.');
  //           _rewardedAd = ad;
  //           _numRewardedLoadAttempts = 0;

  //           // _showRewardedAd();
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('RewardedAd failed to load: $error');
  //           _rewardedAd = null;
  //           _numRewardedLoadAttempts += 1;
  //           if (_numRewardedLoadAttempts <= 4) {
  //             _createRewardedAd();
  //           }
  //         },
  //       ));
  // }

  // void _showRewardedAd() {
  //   if (_rewardedAd == null) {
  //     print('Warning: attempt to show rewarded before loaded.');
  //     return;
  //   }

  //   _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (RewardedAd ad) {
  //       _createRewardedAd();
  //       print('ad onAdShowedFullScreenContent.');
  //     },
  //     onAdDismissedFullScreenContent: (RewardedAd ad) async {
  //       UserModel data = await UserNetwork().getUserData();
  //       await context.read<HomeProvider>().replaceData(data);
  //       print('$ad onAdDismissedFullScreenContent.');
  //     },
  //     onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');

  //       ad.dispose();
  //     },
  //   );

  //   _rewardedAd.show(
  //       onUserEarnedReward: (RewardedAd ad, RewardItem reward) async {
  //     await Ref()
  //         .coinCredit(context.read<HomeProvider>().userData.userReferralCode);
  //     UserModel data = await UserNetwork().getUserData();
  //     await context.read<HomeProvider>().replaceData(data);
  //   });
  //   _rewardedAd = null;
  // }

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

  getinsta() async {
    Token data = await getToken(Constants.APP_ID, Constants.APP_SECRET);
    print("instagram account correct a varuthaa");
    print(data);
  }

  @override
  void dispose() {
    super.dispose();
    // _rewardedAd.dispose();
    // _rewardedAd = null;
  }

  int getItemCountPerRow(BuildContext context) {
    double minTileWidth = 100; //in your case
    double availableWidth = MediaQuery.of(context).size.width;

    int i = availableWidth ~/ minTileWidth;
    return i;
  }

  Widget _buildPhone() {
    var _textStyleforName = TextStyle(
        color: MainTheme.profileNameColors,
        fontWeight: FontWeight.w700,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    var profileValue = TextStyle(
        color: MainTheme.profileValue,
        fontWeight: FontWeight.w700,
        fontSize: ScreenUtil().setSp(43),
        fontFamily: "lato");

    var profileScoreName = TextStyle(
        color: MainTheme.profileValue,
        fontWeight: FontWeight.w500,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
        fontFamily: "lato");

    var socialMediaText = TextStyle(
        color: MainTheme.socialMediaText,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondaryContentfontSize),
        fontFamily: "lato");

    var socialMediaTextBold = TextStyle(
        color: MainTheme.socialMediaTextBold,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondaryContentfontSize),
        fontFamily: "lato");

    var tabFont = TextStyle(
        color: MainTheme.socialMediaTextBold,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    var tabFontDesable = TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    var subHeading = TextStyle(
        color: MainTheme.socialMediaTextBold,
        fontWeight: FontWeight.w700,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    return WillPopScope(
      onWillPop: () {
        return Alert().showAlertDialog(context);
      },
      child: Consumer<HomeProvider>(builder: (context, data, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0,
            actions: [
              InkWell(
                  onTap: () {
                    goToEditProfilePagePage(data.userData);
                  },
                  child: Container(
                      padding: EdgeInsetsDirectional.only(end: 10),
                      child: Row(
                        children: [
                          Container(
                              child: Icon(
                            Icons.edit_outlined,
                            color: MainTheme.primaryColor,
                            size: 50.sp,
                          )),
                          Container(
                              child: Text('Edit Profile',
                                  style: TextStyle(
                                      color: MainTheme.primaryColor,
                                      fontSize: 35.sp,
                                      fontFamily: "Nunito")))
                        ],
                      ))),
            ],
          ),
          body: WillPopScope(
            onWillPop: () {
              if (val == 2) {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              }
              Fluttertoast.showToast(
                  msg: "Press the back button again to exit",
                  timeInSecForIosWeb: 4);
              val = 2;
              Timer(Duration(seconds: 2), () {
                val = 1;
              });
              return val1;
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        gradient: MainTheme.ScoreBackgroundGradient,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.zero,
                                        topRight: Radius.zero,
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          FutureBuilder(
                                            future: Persentage()
                                                .checkPresentage(data.userData),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.hasData) {
                                                return PercentageBar(
                                                  image: data.userData
                                                      .identificationImage,
                                                  percentage: snapshot.data,
                                                );
                                              } else {
                                                return PercentageBar(
                                                  image: data.userData
                                                      .identificationImage,
                                                  percentage: 0,
                                                );
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsetsDirectional.only(
                                                        top: 5),
                                                child: Text(
                                                    "${data.userData.firstName ?? ""} ${data.userData.lastName ?? ""} , ${data.userData.age}",
                                                    style: _textStyleforName

                                                    // TextStyle(
                                                    //     color: Colors.black,
                                                    //     fontWeight: FontWeight.bold,
                                                    //     fontSize: 16,
                                                    //     fontFamily: "Nunito"),

                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                        ])),
                                Positioned(
                                    right: 10,
                                    top: 40,
                                    child: InkWell(
                                      onTap: () {
                                        // _showRewardedAd();
                                      },
                                      child: Container(
                                          padding: EdgeInsetsDirectional.only(
                                              top: 1, start: 1, bottom: 1),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: const Radius.circular(5),
                                              bottomLeft:
                                                  const Radius.circular(5),
                                            ),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(5),
                                                bottomLeft:
                                                    const Radius.circular(5),
                                              ),
                                              child: Container(
                                                  padding: EdgeInsets.all(2),
                                                  color: Colors.white,
                                                  child: Row(children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                          end: 2,
                                                          start: 2,
                                                        ),
                                                        child: Image.asset(
                                                          "assets/images/coin.png",
                                                          width: 10,
                                                          height: 10,
                                                        )),
                                                    Container(
                                                        child: Text(data
                                                                    .userData
                                                                    .coin ==
                                                                null
                                                            ? "0"
                                                            : data
                                                                .userData.coin))
                                                  ])))),
                                    ))
                              ])
                            ]),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                NavigateFunction().withquery(
                                    Navigate.likeMatchListPage + "?index=0");
                              },
                              child: Scores(
                                name:
                                    likeCount == -1 ? "" : likeCount.toString(),
                                scores: "Like",
                                nameFont: profileScoreName,
                                valuefont: profileValue,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                NavigateFunction().withquery(
                                    Navigate.likeMatchListPage + "?index=1");
                              },
                              child: Scores(
                                name: matchCount == -1
                                    ? ""
                                    : matchCount.toString(),
                                scores: "Heart",
                                nameFont: profileScoreName,
                                valuefont: profileValue,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Scores(
                                name: data.userData.score.toString(),
                                scores: "Score",
                                nameFont: profileScoreName,
                                valuefont: profileValue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ])),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () => getinsta(),
                          child: SocialMediaBox(
                            name: "Add Instagram",
                            image: "assets/images/Instagram_icon.png",
                            style: socialMediaText,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            return connectfb();
                          },
                          child: SocialMediaBox(
                            name: data.userData.facebookName == null
                                ? "Add Facebook"
                                : data.userData.facebookName,
                            image: data.userData.facebookName == null
                                ? "assets/images/fbnotselect.png"
                                : "assets/images/Facebook_icon.png",
                            style: socialMediaTextBold,
                            data: data.userData.facebookName,
                          ),
                        ),
                      ]),
                  Container(
                    margin: EdgeInsetsDirectional.only(top: 10),
                    padding: EdgeInsetsDirectional.only(start: 20, end: 20),
                    height: 50.h,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: MainTheme.primaryColor,
                      // indicatorPadding: const EdgeInsets.all(10),
                      labelColor: MainTheme.socialMediaTextBold,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: tabFont,
                      unselectedLabelStyle: tabFontDesable,
                      indicatorWeight: 3,
                      tabs: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "About",
                            // style: TextStyle(
                            //   fontSize: 14,
                            // ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Booking",
                            // style: TextStyle(
                            //   fontSize: 14,
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 178,
                      child: TabBarView(controller: _tabController, children: <
                          Widget>[
                        SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsetsDirectional.only(
                                start: 20, top: 25, end: 20),
                            child: Column(
                              children: [
                                Row(children: [
                                  // Text("About me  ",style: TextStyle(
                                  //     color: Colors.black,fontWeight: FontWeight.bold,
                                  //     fontSize: 14,
                                  //     fontFamily: "Inter")),
                                  Expanded(
                                    child: Text(data.userData.bio ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: "Inter")),
                                  ),
                                ]),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsetsDirectional.only(
                                            top: 25, bottom: 10),
                                        child:
                                            Text("Interest", style: subHeading))
                                  ],
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 0.0,
                                          mainAxisSpacing: 0.0,
                                          crossAxisCount:
                                              getItemCountPerRow(context),
                                          childAspectRatio: 2.8),
                                  itemCount:
                                      data.userData.interestDetails.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InterestBox(
                                      fillColor: Colors.white,
                                      fontSize: ScreenUtil().setSp(
                                          MainTheme.mSecondaryContentfontSize),
                                      color: MainTheme.primaryColor,
                                      title: data.userData
                                              .interestDetails[index].title ??
                                          "",
                                      onTap: () {},
                                    );
                                  },
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsetsDirectional.only(
                                            top: 10, bottom: 10),
                                        child:
                                            Text("Hobbies", style: subHeading))
                                  ],
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 0.0,
                                          mainAxisSpacing: 0.0,
                                          crossAxisCount:
                                              getItemCountPerRow(context),
                                          childAspectRatio: 2.8),
                                  itemCount: data.userData.hobbyDetails.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InterestBox(
                                      fillColor: Colors.white,
                                      fontSize: ScreenUtil().setSp(
                                          MainTheme.mSecondaryContentfontSize),
                                      color: MainTheme.primaryColor,
                                      title: data.userData.hobbyDetails[index]
                                              .title ??
                                          "",
                                      onTap: () {},
                                    );
                                  },
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsetsDirectional.only(
                                            top: 10, bottom: 10),
                                        child: Text("Album", style: subHeading))
                                  ],
                                ),
                                AlbumCardList(
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0,
                                  crossAxisCount: 3,
                                  images: data.userData.profileImage,
                                  itemCount: data.userData.profileImage.length,
                                )
                              ],
                            )),
                        SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsetsDirectional.only(
                              start: 20, end: 20, top: 30),
                          child: Column(children: [
                            _isCreatingLink
                                ? Center(child: CircularProgressIndicator())
                                : InkWell(
                                    onTap: () async {
                                      String link = await DynamcLink()
                                          .creatLink(
                                              data.userData.userReferralCode);
                                      print(link);
                                      return Share.share(link,
                                          subject: 'Look what I made!');
                                    },
                                    child: SettingBox(name: "Refer & Earn")),
                            Consumer<SubscriptionProvider>(
                                builder: (context, subdata, child) {
                              return InkWell(
                                  onTap: () async {
                                    if (subdata.plan != null) {
                                      if (subdata.subscriptionData.length ==
                                          0) {
                                        await subdata.getdata();
                                      }
                                      SubscriptionModel sdata = subdata
                                          .subscriptionData
                                          .firstWhere((element) =>
                                              element.id == subdata.plan);
                                      print("id correct varuthaa");
                                      print(subdata.checklistData[5].title);
                                      if (sdata.checklists.any((element) =>
                                          element.id !=
                                          subdata.checklistData[5].id)) {
                                        return BottomSheetClass()
                                            .showplans(context);
                                      }
                                    }

                                    if (subdata.plan == null) {
                                      if (int.parse(subdata.count) >=
                                          data.userData.subCount) {
                                        List<UserModel> data =
                                            await Subscription().updateCount(1);
                                        await context
                                            .read<HomeProvider>()
                                            .replaceData(data[0]);
                                        await context
                                            .read<ExpertChatProvider>()
                                            .getGroupCatoData();
                                        return NavigateFunction()
                                            .withquery(Navigate.expertGroup);
                                      } else {
                                        if (subdata.subscriptionData.length ==
                                            0) {
                                          subdata.getdata();
                                          return BottomSheetClass()
                                              .showplans(context);
                                        } else {
                                          return BottomSheetClass()
                                              .showplans(context);
                                        }
                                      }
                                    }
                                    await context
                                        .read<ExpertChatProvider>()
                                        .getGroupCatoData();
                                    NavigateFunction()
                                        .withquery(Navigate.expertGroup);
                                  },
                                  child: SettingBox(name: "Expert Chat"));
                            }),
                            InkWell(
                                onTap: () {
                                  NavigateFunction().withquery(
                                      Navigate.subscription + "?onboard=false");
                                },
                                child: SettingBox(name: "Subscription")),
                            SettingBox(name: "Order history"),
                            InkWell(
                                onTap: () {
                                  NavigateFunction()
                                      .withquery(Navigate.aboutus);
                                },
                                child: SettingBox(name: "About")),
                            GestureDetector(
                              onTap: () {
                                showAlertDialog(context);
                              },
                              child: SettingBox(
                                name: "Log out",
                                activeIcon: true,
                              ),
                            ),
                          ]),
                        ),
                      ]))
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomTabBar(
            currentIndex: 3,
          ),
        );
      }),
    );
  }

  bool _isCreatingLink = false;

  connectfb() async {
    final result = await FacebookAuth.i.login(
      permissions: ['email', 'public_profile', 'user_link'],
    );
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.i.getUserData(
        fields: "name,link",
      );
      print(userData);

      UserModel data = await UserNetwork().patchUserData({
        "facebook_username": userData["name"],
        "facebook_link": userData["id"].toString(),
      });
      data != null
          ? await context.read<HomeProvider>().replaceData(data)
          : null;
    }
    // by default we request the email and the public profile
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "No",
            style: TextStyle(
                fontSize: inputFont,
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(width: 50.w),
        InkWell(
          onTap: () {
            saveLoginStatus(1);
            NavigateFunction().withqueryReplace(Navigate.loginPage);
          },
          child: Text(
            "Yes",
            style: TextStyle(
                fontSize: inputFont,
                color: MainTheme.primaryColor,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(width: 20.w),
      ],
      title: Text(
        "Logout",
        style: TextStyle(
            fontSize: 20,
            color: MainTheme.primaryColor,
            fontWeight: FontWeight.w600),
      ),
      content: Text(
        "Do you want logout?",
        style: TextStyle(
            fontSize: inputFont,
            color: Colors.black,
            fontWeight: FontWeight.w400),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  goToEditProfilePagePage(UserModel userData) {
    print("user data correct a varuthaa");
    print(userData);
    NavigateFunction()
        .withoutquery(Navigate.editProfilePage, {"userDetails": userData});
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height - (kToolbarHeight);
    var _width = MediaQuery.of(context).size.width - 30;

    var _textStyleforName = TextStyle(
        color: MainTheme.profileNameColors,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        fontFamily: "lato");

    var profileValue = TextStyle(
        color: MainTheme.primaryColor,
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontFamily: "lato");

    var profileScoreName = TextStyle(
        color: MainTheme.webProfileScoreName,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        fontFamily: "lato");

    var socialMediaText = TextStyle(
        color: MainTheme.socialMediaText,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        fontFamily: "lato");

    var socialMediaTextBold = TextStyle(
        color: MainTheme.socialMediaTextBold,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        fontFamily: "lato");

    var subHeading = TextStyle(
        color: MainTheme.socialMediaTextBold,
        fontWeight: FontWeight.w500,
        fontSize: 13,
        fontFamily: "lato");

    return Scaffold(
        body: BaseLayout(
            navigationRail: NavigationMenu(
              currentTabIndex: 2,
            ),
            body: Consumer<HomeProvider>(builder: (context, data, child) {
              return data.homeState == HomeState.Error
                  ? ErrorCard(
                      text: data.errorText,
                      ontab: () => NavigateFunction()
                          .withqueryReplace(Navigate.profilePage))
                  : data.homeState != HomeState.Loaded
                      ? LoadingLottie()
                      : Container(
                          padding: EdgeInsetsDirectional.only(start: 2),
                          color: Colors.grey[200],
                          child: Scaffold(
                              appBar: AppBar(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                automaticallyImplyLeading: false,
                                // titleSpacing: 0,
                                title: Container(
                                    margin: EdgeInsetsDirectional.only(
                                        top: 20, start: 25),
                                    child: Text(
                                      "Profile Details",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "OpenSans",
                                        fontSize: 14,
                                      ),
                                    )),
                                actions: [
                                  Container(
                                      margin: EdgeInsetsDirectional.only(
                                          top: 5, end: 20, bottom: 5),
                                      child: Consumer<NotificationProvider>(
                                        builder: (context, data, child) {
                                          return InkWell(
                                            onTap: () {
                                              return BottomSheetClass()
                                                  .shownav(context);
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons
                                                        .notifications_outlined,
                                                    color: Colors.grey,
                                                    size: 25,
                                                  ),
                                                ),
                                                if (data.notificationData
                                                        .length !=
                                                    0)
                                                  Positioned(
                                                    right: 8,
                                                    top: 2,
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 15,
                                                        width: 15,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: MainTheme
                                                              .primaryColor,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Text(
                                                          data.notificationData
                                                              .length
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
                                  // InkWell(
                                  //   onTap: () {
                                  //     goToEditProfilePagePage(data.userData);
                                  //   },
                                  //   child: Container(
                                  //       child: Text('Edit Profile',
                                  //           style: TextStyle(
                                  //               color: MainTheme.primaryColor,
                                  //               fontSize: 14,
                                  //               fontFamily: "Nunito"))),
                                  // )
                                ],
                              ),
                              body: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            // Container(
                                            //   height: 220,
                                            //   width: _width / 25,
                                            // ),
                                            Container(
                                                height: 285,
                                                width: _width * 0.365,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                        ),
                                                        FutureBuilder(
                                                          future: Persentage()
                                                              .checkPresentage(
                                                                  data.userData),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              return PercentageBar(
                                                                image: data
                                                                    .userData
                                                                    .identificationImage,
                                                                percentage:
                                                                    snapshot
                                                                        .data,
                                                              );
                                                            } else {
                                                              return PercentageBar(
                                                                image: data
                                                                    .userData
                                                                    .identificationImage,
                                                                percentage: 0,
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              goToEditProfilePagePage(
                                                                  data.userData);
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsetsDirectional
                                                                    .only(
                                                                        start:
                                                                            20,
                                                                        end:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                        child:
                                                                            Icon(
                                                                      Icons
                                                                          .edit_outlined,
                                                                      color: MainTheme
                                                                          .primaryColor,
                                                                      size: 14,
                                                                    )),
                                                                    Container(
                                                                        child: Text(
                                                                            'Edit Profile',
                                                                            style: TextStyle(
                                                                                color: MainTheme.primaryColor,
                                                                                fontSize: 14,
                                                                                fontFamily: "Nunito")))
                                                                  ],
                                                                ))),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsetsDirectional
                                                                  .only(top: 5),
                                                          child: Text(
                                                              "${data.userData.firstName ?? ""} ${data.userData.lastName ?? ""} , ${data.userData.age}",
                                                              style:
                                                                  _textStyleforName),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            // _showRewardedAd();
                                                          },
                                                          child: Card(
                                                            child: Container(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .all(3),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            3)),
                                                                child: ClipRRect(
                                                                    child: Container(
                                                                        padding: EdgeInsets.all(2),
                                                                        color: Colors.white,
                                                                        child: Row(children: [
                                                                          Container(
                                                                              padding: EdgeInsetsDirectional.only(
                                                                                end: 2,
                                                                                start: 2,
                                                                              ),
                                                                              child: Image.asset(
                                                                                "assets/images/coin.png",
                                                                                width: 20,
                                                                                height: 20,
                                                                              )),
                                                                          Container(
                                                                              child: Text(data.userData.coin == null ? "0" : data.userData.coin))
                                                                        ])))),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 70,
                                                      margin:
                                                          EdgeInsetsDirectional
                                                              .only(
                                                                  top: 10,
                                                                  start: 10,
                                                                  end: 10,
                                                                  bottom: 10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        // border: Border.all(
                                                        //   width: 1,
                                                        //   color: Colors.grey.shade100,
                                                        // ),
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey.shade200,
                                                            blurRadius: 1.0,
                                                            offset:
                                                                Offset(0, 3),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .only(top: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              NavigateFunction()
                                                                  .withquery(Navigate
                                                                          .likeMatchListPage +
                                                                      "?index=0");
                                                            },
                                                            child: Scores(
                                                              name: likeCount ==
                                                                      -1
                                                                  ? ""
                                                                  : likeCount
                                                                      .toString(),
                                                              scores: "Like",
                                                              nameFont:
                                                                  profileScoreName,
                                                              valuefont:
                                                                  profileValue,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              NavigateFunction()
                                                                  .withquery(Navigate
                                                                          .likeMatchListPage +
                                                                      "?index=1");
                                                            },
                                                            child: Scores(
                                                              name: matchCount ==
                                                                      -1
                                                                  ? ""
                                                                  : matchCount
                                                                      .toString(),
                                                              scores: "Heart",
                                                              nameFont:
                                                                  profileScoreName,
                                                              valuefont:
                                                                  profileValue,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Scores(
                                                              name: data
                                                                  .userData
                                                                  .score
                                                                  .toString(),
                                                              scores: "Score",
                                                              nameFont:
                                                                  profileScoreName,
                                                              valuefont:
                                                                  profileValue,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                          InkWell(
                                                            onTap: () =>
                                                                getinsta(),
                                                            child:
                                                                SocialMediaBox(
                                                              name:
                                                                  "Add Instagram",
                                                              image:
                                                                  "assets/images/Instagram_icon.png",
                                                              style:
                                                                  socialMediaText,
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              return connectfb();
                                                            },
                                                            child:
                                                                SocialMediaBox(
                                                              name: data.userData
                                                                          .facebookName ==
                                                                      null
                                                                  ? "Add Facebook"
                                                                  : data
                                                                      .userData
                                                                      .facebookName,
                                                              image: data.userData
                                                                          .facebookName ==
                                                                      null
                                                                  ? "assets/images/fbnotselect.png"
                                                                  : "assets/images/Facebook_icon.png",
                                                              style:
                                                                  socialMediaTextBold,
                                                              data: data
                                                                  .userData
                                                                  .facebookName,
                                                            ),
                                                          ),
                                                        ])),
                                                  ],
                                                )),
                                            Container(
                                              height: 220,
                                              width: _width / 45,
                                            ),
                                            Container(
                                                height: 280,
                                                width: _width * 0.400,
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                              margin:
                                                                  EdgeInsetsDirectional
                                                                      .only(
                                                                top: 10,
                                                                bottom: 10,
                                                              ),
                                                              child: Text(
                                                                  "Album",
                                                                  style:
                                                                      subHeading))
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                              height: 220,
                                                              width: _width *
                                                                  0.355,
                                                              child:
                                                                  AlbumCardList(
                                                                mainAxisSpacing:
                                                                    10.0,
                                                                crossAxisSpacing:
                                                                    10.0,
                                                                crossAxisCount:
                                                                    3,
                                                                images: data
                                                                    .userData
                                                                    .profileImage,
                                                                itemCount: data
                                                                    .userData
                                                                    .profileImage
                                                                    .length,
                                                              )),
                                                        ],
                                                      ),
                                                    ]))
                                          ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // Container(
                                          //   height: 220,
                                          //   width: _width / 25,
                                          // ),
                                          Container(
                                            height: 300,
                                            width: _width * 0.365,
                                            child: SingleChildScrollView(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        start: 20, end: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                            child: Text("About",
                                                                style:
                                                                    subHeading))
                                                      ],
                                                    ),
                                                    Container(
                                                        child: Row(children: [
                                                      Expanded(
                                                        child: Text(
                                                            data.userData.bio ??
                                                                "",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                color: MainTheme
                                                                    .profileNameColors,
                                                                fontSize: 11,
                                                                fontFamily:
                                                                    "Inter")),
                                                      ),
                                                    ])),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                            child: Text(
                                                                "Interest",
                                                                style:
                                                                    subHeading))
                                                      ],
                                                    ),
                                                    GridView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisSpacing:
                                                                  0.0,
                                                              mainAxisSpacing:
                                                                  0.0,
                                                              crossAxisCount: 4,
                                                              childAspectRatio:
                                                                  2.8),
                                                      itemCount: data
                                                          .userData
                                                          .interestDetails
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return InterestBox(
                                                          fillColor:
                                                              Colors.white,
                                                          fontSize: ScreenUtil()
                                                              .setSp(MainTheme
                                                                  .mSecondaryContentfontSize),
                                                          color: MainTheme
                                                              .primaryColor,
                                                          title: data
                                                                  .userData
                                                                  .interestDetails[
                                                                      index]
                                                                  .title ??
                                                              "",
                                                          onTap: () {},
                                                        );
                                                      },
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                            child: Text(
                                                                "Hobbies",
                                                                style:
                                                                    subHeading))
                                                      ],
                                                    ),
                                                    GridView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisSpacing:
                                                                  0.0,
                                                              mainAxisSpacing:
                                                                  0.0,
                                                              crossAxisCount: 4,
                                                              childAspectRatio:
                                                                  2.8),
                                                      itemCount: data.userData
                                                          .hobbyDetails.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return InterestBox(
                                                          fillColor:
                                                              Colors.white,
                                                          fontSize: ScreenUtil()
                                                              .setSp(MainTheme
                                                                  .mSecondaryContentfontSize),
                                                          color: MainTheme
                                                              .primaryColor,
                                                          title: data
                                                                  .userData
                                                                  .hobbyDetails[
                                                                      index]
                                                                  .title ??
                                                              "",
                                                          onTap: () {},
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Container(
                                            height: 45,
                                            width: _width / 45,
                                          ),
                                          Container(
                                              height: 300,
                                              width: _width * 0.400,
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .only(
                                                              // top: 50,
                                                              bottom: 10,
                                                            ),
                                                            child: Text(
                                                                "Booking Details",
                                                                style:
                                                                    subHeading

                                                                //  TextStyle(
                                                                //   color: Colors.black,
                                                                //   fontWeight: FontWeight.w500,
                                                                //   fontFamily: "OpenSans",
                                                                //   fontSize: 15,
                                                                // ),

                                                                ))
                                                      ],
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                              height: 220,
                                                              width: _width *
                                                                  0.350,
                                                              child: Column(
                                                                  children: [
                                                                    _isCreatingLink
                                                                        ? Center(
                                                                            child:
                                                                                CircularProgressIndicator())
                                                                        : InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              String link = await DynamcLink().creatLink(data.userData.userReferralCode);
                                                                              print(link);
                                                                              return Share.share(link, subject: 'Look what I made!');
                                                                            },
                                                                            child:
                                                                                SettingBox(fontSize: 12, name: "Refer & Earn")),
                                                                    Consumer<SubscriptionProvider>(builder:
                                                                        (context,
                                                                            subdata,
                                                                            child) {
                                                                      return InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            // if (subdata
                                                                            //         .plan !=
                                                                            //     null) {
                                                                            //   if (subdata
                                                                            //           .subscriptionData
                                                                            //           .length ==
                                                                            //       0) {
                                                                            //     await subdata
                                                                            //         .getdata();
                                                                            //   }
                                                                            //   SubscriptionModel sdata = subdata
                                                                            //       .subscriptionData
                                                                            //       .firstWhere((element) =>
                                                                            //           element
                                                                            //               .id ==
                                                                            //           subdata
                                                                            //               .plan);
                                                                            //   print(
                                                                            //       "id correct varuthaa");
                                                                            //   print(subdata
                                                                            //       .checklistData[
                                                                            //           5]
                                                                            //       .title);
                                                                            //   if (sdata.checklists.any((element) =>
                                                                            //       element
                                                                            //           .id !=
                                                                            //       subdata
                                                                            //           .checklistData[
                                                                            //               5]
                                                                            //           .id)) {
                                                                            //     return BottomSheetClass()
                                                                            //         .showplans(
                                                                            //             context);
                                                                            //   }
                                                                            // }

                                                                            // if (subdata
                                                                            //         .plan ==
                                                                            //     null) {
                                                                            //   if (int.parse(
                                                                            //           subdata
                                                                            //               .count) >=
                                                                            //       data.userData
                                                                            //           .subCount) {
                                                                            //     List<UserModel>
                                                                            //         data =
                                                                            //         await Subscription()
                                                                            //             .updateCount(1);
                                                                            //     await context
                                                                            //         .read<
                                                                            //             HomeProvider>()
                                                                            //         .replaceData(
                                                                            //             data[0]);
                                                                            //     await context
                                                                            //         .read<
                                                                            //             ExpertChatProvider>()
                                                                            //         .getGroupCatoData();
                                                                            //     return Routes
                                                                            //         .sailor(
                                                                            //             Routes.expertGroup);
                                                                            //   } else {
                                                                            //     if (subdata
                                                                            //             .subscriptionData
                                                                            //             .length ==
                                                                            //         0) {
                                                                            //       subdata
                                                                            //           .getdata();
                                                                            //       return BottomSheetClass()
                                                                            //           .showplans(
                                                                            //               context);
                                                                            //     } else {
                                                                            //       return BottomSheetClass()
                                                                            //           .showplans(
                                                                            //               context);
                                                                            //     }
                                                                            //   }
                                                                            // }
                                                                            await context.read<ExpertChatProvider>().getGroupCatoData();
                                                                            NavigateFunction().withquery(Navigate.expertGroup);
                                                                          },
                                                                          child: SettingBox(
                                                                              fontSize: 12,
                                                                              name: "Expert Chat"));
                                                                    }),
                                                                    Consumer<SubscriptionProvider>(builder:
                                                                        (context,
                                                                            subdata,
                                                                            child) {
                                                                      return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if (subdata.subscriptionData.length ==
                                                                                0) {
                                                                              subdata.getdata();
                                                                              return BottomSheetClass().showsub(context);
                                                                            } else {
                                                                              return BottomSheetClass().showsub(context);
                                                                            }
                                                                          },
                                                                          child: SettingBox(
                                                                              fontSize: 12,
                                                                              name: "Subscription"));
                                                                    }),
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          showsub(
                                                                              context);
                                                                        },
                                                                        child: SettingBox(
                                                                            fontSize:
                                                                                12,
                                                                            name:
                                                                                "About")),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        showAlertDialog(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          SettingBox(
                                                                        fontSize:
                                                                            12,
                                                                        name:
                                                                            "Log out",
                                                                        activeIcon:
                                                                            true,
                                                                      ),
                                                                    ),
                                                                  ]))
                                                        ]),
                                                  ]))
                                        ],
                                      )
                                    ]),
                              )));
            })));
  }

  showsub(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: 400,
                height: 280,
                child: AboutUs(
                  onWeb: true,
                )),
          );
        });
  }
}
