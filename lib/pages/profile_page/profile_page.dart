import 'dart:async';
import 'dart:io';

import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/user_network.dart';

import 'package:dating_app/pages/home_page/widget/interest_box.dart';
import 'package:dating_app/pages/profile_page/widgets/percentage_bar.dart';
import 'package:dating_app/pages/profile_page/widgets/scores.dart';
import 'package:dating_app/pages/profile_page/widgets/setting_box.dart';
import 'package:dating_app/pages/profile_page/widgets/social_media_box.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/shared/helpers/check_persentage.dart';
import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/album_card_list.dart';
import 'package:dating_app/shared/widgets/bottom_bar.dart';
import 'package:dating_app/shared/widgets/interest_card_list.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:dating_app/shared/widgets/subheading.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:share/share.dart';

import '../../routes.dart';

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
  }

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

  getinsta() async {
    FlutterInsta flutterInsta = new FlutterInsta();
    await flutterInsta.getProfileData("coding_boy_");
    print(flutterInsta.username);
    print(flutterInsta.bio);
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

    return SafeArea(
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
                          size: 20,
                        )),
                        Container(
                            child: Text('Edit Profile',
                                style: TextStyle(
                                    color: MainTheme.primaryColor,
                                    fontSize: 12,
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
                    height: 190,
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
                                  height: 130,
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
                                  child: Column(children: [
                                    FutureBuilder(
                                      future: Persentage()
                                          .checkPresentage(data.userData),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          return PercentageBar(
                                            image: data
                                                .userData.identificationImage,
                                            percentage: snapshot.data,
                                          );
                                        } else {
                                          return PercentageBar(
                                            image: data
                                                .userData.identificationImage,
                                            percentage: 0,
                                          );
                                        }
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsetsDirectional.only(
                                              top: 5),
                                          child: Text(
                                              "${data.userData.firstName ?? ""} ${data.userData.lastName ?? ""}",
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
                                  ])),
                              Positioned(
                                  right: 10,
                                  top: 40,
                                  child: Container(
                                      padding: EdgeInsetsDirectional.only(
                                          top: 1, start: 1, bottom: 1),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: const Radius.circular(5),
                                          bottomLeft: const Radius.circular(5),
                                        ),
                                      ),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: const Radius.circular(5),
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
                                                Container(child: Text('120'))
                                              ])))))
                            ])
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Routes.sailor(Routes.likeMatchListPage,
                                  params: {"index": 0});
                            },
                            child: Scores(
                              name: likeCount == -1 ? "" : likeCount.toString(),
                              scores: "Like",
                              nameFont: profileScoreName,
                              valuefont: profileValue,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Routes.sailor(Routes.likeMatchListPage,
                                  params: {"index": 1});
                            },
                            child: Scores(
                              name:
                                  matchCount == -1 ? "" : matchCount.toString(),
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
                          name: "andrina_rico",
                          image: "assets/images/Facebook_icon.png",
                          style: socialMediaTextBold,
                        ),
                      ),
                    ]),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 10),
                  padding: EdgeInsetsDirectional.only(start: 20, end: 20),
                  height: 35,
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
                                        crossAxisCount: 3,
                                        childAspectRatio: 2.8),
                                itemCount: data.userData.interestDetails.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InterestBox(
                                    fillColor: Colors.white,
                                    fontSize: ScreenUtil().setSp(
                                        MainTheme.mSecondaryContentfontSize),
                                    color: MainTheme.primaryColor,
                                    title: data.userData.interestDetails[index]
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
                                      child: Text("Hobbies", style: subHeading))
                                ],
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 0.0,
                                        mainAxisSpacing: 0.0,
                                        crossAxisCount: 3,
                                        childAspectRatio: 2.8),
                                itemCount: data.userData.hobbyDetails.length,
                                itemBuilder: (BuildContext context, int index) {
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
                                  onTap: () => _createDynamicLink(),
                                  child: SettingBox(name: "Refer & Earn")),
                          InkWell(
                              onTap: () {
                                Routes.sailor(Routes.meetuppage);
                              },
                              child: SettingBox(name: "Booking")),
                          SettingBox(name: "Order history"),
                          SettingBox(name: "About"),
                          GestureDetector(
                            onTap: () {
                              Routes.sailor.navigate((Routes.loginPage),
                                  navigationType: NavigationType.pushReplace);
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
    }));
  }

  bool _isCreatingLink = false;

  connectfb() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken;
    } else {
      print(result.status);
      print(result.message);
    }
  }

  Future<void> _createDynamicLink() async {
    String _linkMessage;
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://life2sparks.page.link',
      link: Uri.parse("https://life2sparks.page.link/ref?id=1234567890"),
      androidParameters: AndroidParameters(
        packageName: "com.life2sparks",
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (true) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
    print(url);
    return Share.share(_linkMessage);
  }

  goToEditProfilePagePage(UserModel userData) {
    Routes.sailor(Routes.editProfilePage, params: {"userDetails": userData});
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
            body: Container(
                padding: EdgeInsetsDirectional.only(start: 2),
                color: Colors.grey[200],
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      // titleSpacing: 0,
                      title: Container(
                          margin:
                              EdgeInsetsDirectional.only(top: 20, start: 25),
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
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.grey,
                                  // size: 20,
                                )))
                      ],
                    ),
                    body: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Container(
                                //   height: 220,
                                //   width: _width / 25,
                                // ),
                                Container(
                                    height: 280,
                                    width: _width * 0.365,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PercentageBar(
                                          percentage: 0.7,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      top: 5),
                                              child: Text("Adrianne Rico, 22",
                                                  style: _textStyleforName),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 70,
                                          margin: EdgeInsetsDirectional.only(
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
                                                color: Colors.grey.shade200,
                                                blurRadius: 1.0,
                                                offset: Offset(0, 3),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsetsDirectional.only(
                                              top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Scores(
                                                name: "120",
                                                scores: "Like",
                                                textColor: Colors.black,
                                                color: MainTheme.primaryColor,
                                                nameFont: profileScoreName,
                                                valuefont: profileValue,
                                              ),
                                              Scores(
                                                name: "186",
                                                scores: "Heart",
                                                textColor: Colors.black,
                                                color: MainTheme.primaryColor,
                                                nameFont: profileScoreName,
                                                valuefont: profileValue,
                                              ),
                                              Scores(
                                                name: "200",
                                                scores: "Score",
                                                textColor: Colors.black,
                                                color: MainTheme.primaryColor,
                                                nameFont: profileScoreName,
                                                valuefont: profileValue,
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
                                              SocialMediaBox(
                                                name: "Add Instagram",
                                                image:
                                                    "assets/images/Instagram_icon.png",
                                                style: socialMediaText,
                                              ),
                                              SocialMediaBox(
                                                name: "andrina_rico",
                                                image:
                                                    "assets/images/Facebook_icon.png",
                                                style: socialMediaTextBold,
                                              ),
                                              SocialMediaBox(
                                                name: "Add Linkedin",
                                                image:
                                                    "assets/images/LinkedIn_icons.png",
                                                style: socialMediaText,
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
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsetsDirectional
                                                      .only(
                                                    top: 10,
                                                    bottom: 10,
                                                  ),
                                                  child: Text("Album",
                                                      style: subHeading))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  height: 220,
                                                  width: _width * 0.355,
                                                  child: AlbumCardList(
                                                    childAspectRatio: 1.9,
                                                    mainAxisSpacing: 15,
                                                    crossAxisSpacing: 15,
                                                    crossAxisCount: 3,
                                                    itemCount: 6,
                                                  )),
                                            ],
                                          ),
                                        ]))
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Container(
                              //   height: 220,
                              //   width: _width / 25,
                              // ),
                              Container(
                                height: 300,
                                width: _width * 0.365,
                                child: SingleChildScrollView(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 20, end: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsetsDirectional.only(
                                                        top: 10, bottom: 10),
                                                child: Text("About",
                                                    style: subHeading))
                                          ],
                                        ),
                                        Container(
                                            child: Row(children: [
                                          Expanded(
                                            child: Text(
                                                "Hi, I am Adrianne Rico. I am now 22 years old and I am looking for someone to love and care for me seriously....",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: MainTheme
                                                        .profileNameColors,
                                                    fontSize: 11,
                                                    fontFamily: "Inter")),
                                          ),
                                        ])),
                                        Row(
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsetsDirectional.only(
                                                        top: 10, bottom: 10),
                                                child: Text("Interest",
                                                    style: subHeading))
                                          ],
                                        ),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: 0.0,
                                                  mainAxisSpacing: 0.0,
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 2.8),
                                          itemCount: 8,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InterestBox(
                                              fontSize: ScreenUtil().setSp(
                                                  MainTheme
                                                      .mPrimaryContentfontSize),
                                              color: MainTheme.primaryColor,
                                              title:
                                                  "snapshot.data[index].title",
                                              onTap: () {},
                                            );
                                          },
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsetsDirectional.only(
                                                        top: 10, bottom: 10),
                                                child: Text("Hobbies",
                                                    style: subHeading))
                                          ],
                                        ),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: 0.0,
                                                  mainAxisSpacing: 0.0,
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 2.8),
                                          itemCount: 8,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InterestBox(
                                              fontSize: ScreenUtil().setSp(
                                                  MainTheme
                                                      .mPrimaryContentfontSize),
                                              color: MainTheme.primaryColor,
                                              title: "Cycling",
                                              onTap: () {},
                                            );
                                          },
                                        )
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
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsetsDirectional.only(
                                                  // top: 50,
                                                  bottom: 10,
                                                ),
                                                child: Text("Booking Details",
                                                    style: subHeading

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
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  height: 200,
                                                  width: _width * 0.350,
                                                  child: Column(children: [
                                                    SettingBox(
                                                      name: "Booking",
                                                      width: _width * 0.300,
                                                      fontSize: 12,
                                                    ),
                                                    SettingBox(
                                                      name: "Order history",
                                                      width: _width * 0.300,
                                                      fontSize: 12,
                                                    ),
                                                    SettingBox(
                                                      name: "About",
                                                      width: _width * 0.300,
                                                      fontSize: 12,
                                                    ),
                                                    SettingBox(
                                                      name: "Log out",
                                                      width: _width * 0.300,
                                                      activeIcon: true,
                                                      fontSize: 12,
                                                    ),
                                                  ]))
                                            ]),
                                      ]))
                            ],
                          )
                        ]))))));
  }
}
