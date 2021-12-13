import 'package:dating_app/models/subscription_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/home_button_network.dart';
import 'package:dating_app/networks/subscription.dart';
import 'package:dating_app/pages/home_page/widget/imageCard.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/regex_pattern.dart';
import 'package:dating_app/shared/widgets/animation_button.dart';
import 'package:dating_app/shared/widgets/bottmsheet.dart';
import 'package:dating_app/shared/widgets/subscription_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class ImageSwiper extends StatefulWidget {
  ImageSwiper(
      {Key key,
      this.onTap,
      this.promos = const <dynamic>[],
      this.userSuggestionData})
      : super(key: key);
  final Function(dynamic) onTap;
  final List<dynamic> promos;
  final UsersSuggestionModel userSuggestionData;

  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  int currentIndex = 0;
  SwiperController _controller = SwiperController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Consumer<SubscriptionProvider>(
        builder: (context, subdata, child) {
          return Column(children: [
            Expanded(
              child: Container(child: Consumer<HomeProvider>(
                builder: (context, data, child) {
                  return Swiper(
                    onTap: (index) async {
                      if (subdata.plan == null) {
                        if (int.parse(subdata.count) >=
                            data.userData.subCount) {
                          List<UserModel> data =
                              await Subscription().updateCount(1);
                          await context
                              .read<HomeProvider>()
                              .replaceData(data[0]);
                        } else {
                          if (subdata.subscriptionData.length == 0) {
                            subdata.getdata();
                            BottomSheetClass().showplans(context);
                          } else {
                            BottomSheetClass().showplans(context);
                          }
                        }
                      } else {
                        print("en plan varutha");
                        print(subdata.plan);
                        if (subdata.subscriptionData.length == 0) {
                          await subdata.getdata();
                        }
                        SubscriptionModel sdata = subdata.subscriptionData
                            .firstWhere(
                                (element) => element.id == subdata.plan);

                        if (sdata.checklists.any((element) =>
                            element.id != subdata.checklistData[6].id)) {
                          return BottomSheetClass().showplans(context);
                        }
                      }
                    },
                    controller: _controller,
                    loop: false,
                    outer: true,
                    onIndexChanged: (int ind) async {
                      currentIndex = ind;
                      print("change index enna varuthu");
                      print(ind);
                      print("count enna varuthu");
                      print(subdata.count);
                      print("user data count enna varuthu");
                      print(data.userData.subCount);

                      if (subdata.plan == null) {
                        if (int.parse(subdata.count) >=
                            data.userData.subCount) {
                          List<UserModel> data =
                              await Subscription().updateCount(1);
                          await context
                              .read<HomeProvider>()
                              .replaceData(data[0]);
                        } else {
                          if (subdata.subscriptionData.length == 0) {
                            subdata.getdata();
                            BottomSheetClass().showplans(context);
                          } else {
                            BottomSheetClass().showplans(context);
                          }
                        }
                      } else {
                        print("en plan varutha");
                        print(subdata.plan);
                        if (subdata.subscriptionData.length == 0) {
                          await subdata.getdata();
                        }
                        SubscriptionModel sdata = subdata.subscriptionData
                            .firstWhere(
                                (element) => element.id == subdata.plan);

                        if (sdata.checklists.any(
                            (element) => element.title != checkListData[6])) {
                          BottomSheetClass().showplans(context);
                        }
                      }
                    },
                    layout: SwiperLayout.TINDER,
                    itemWidth: MediaQuery.of(context).size.width * 1,
                    itemHeight: double.infinity,
                    itemBuilder: (BuildContext context, int index) {
                      // dynamic _trens = widget.promos[index];
                      return InkWell(
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () async {
                            if (subdata.plan != null) {
                              print("en plan varutha");
                              print(subdata.plan);
                              if (subdata.subscriptionData.length == 0) {
                                await subdata.getdata();
                              }
                              SubscriptionModel sdata = subdata.subscriptionData
                                  .firstWhere(
                                      (element) => element.id == subdata.plan);

                              if (sdata.checklists.any((element) =>
                                  element.id != subdata.checklistData[6].id)) {
                                return BottomSheetClass().showplans(context);
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
                                return goToDetailPage(
                                    widget.userSuggestionData.response[index]);
                              } else {
                                if (subdata.subscriptionData.length == 0) {
                                  subdata.getdata();
                                  return BottomSheetClass().showplans(context);
                                } else {
                                  return BottomSheetClass().showplans(context);
                                }
                              }
                            }
                            goToDetailPage(
                                widget.userSuggestionData.response[index]);
                          },
                          child: ImageCard(
                            data: widget.userSuggestionData.response[index],
                            name: widget.userSuggestionData.response[index]
                                    .firstName ??
                                "",
                            image: widget.userSuggestionData.response[index]
                                        .identificationImage ==
                                    null
                                ? ""
                                : widget.userSuggestionData.response[index]
                                    .identificationImage,
                          ));
                    },
                    itemCount: widget.userSuggestionData.response.length,
                  );
                },
              )),
            ),
            SizedBox(
              height: 5.h,
            ),
            Consumer<HomeProvider>(builder: (context, data, child) {
              return Container(
                  child: AnimationButton(
                loadingstar: data.showstar,
                loadingheart: data.showheart,
                goChatPage: () async {
                  print("message");
                  try {
                    String groupid = await ChatNetwork().createGroup(
                        widget.userSuggestionData.response[currentIndex].id,
                        data.userData);
                    goToChatPage(
                        groupid,
                        widget.userSuggestionData.response[currentIndex].id,
                        widget.userSuggestionData.response[currentIndex]
                            .identificationImage,
                        widget.userSuggestionData.response[currentIndex]
                            .firstName);
                  } on DioError catch (e) {
                    if (e.response.statusCode == 408) {
                      if (subdata.plan == null) {
                        if (subdata.subscriptionData.length == 0) {
                          subdata.getdata();
                          BottomSheetClass().showplans(context);
                        } else {
                          BottomSheetClass().showplans(context);
                        }
                      }
                    }
                    print(e);
                  }
                },
                onTapHeart: () async {
                  await context.read<HomeProvider>().changeheart();
                  String confirmedUser =
                      widget.userSuggestionData.response[currentIndex].id;
                  UserModel userData = data.userData;
                  try {
                    await HomeButtonNetwork()
                        .postMatchRequest(confirmedUser, userData);
                  } on DioError catch (e) {
                    if (e.response.statusCode == 408) {
                      if (subdata.plan == null) {
                        if (subdata.subscriptionData.length == 0) {
                          subdata.getdata();
                          return BottomSheetClass().showplans(context);
                        } else {
                          return BottomSheetClass().showplans(context);
                        }
                      }
                    }
                  }
                },
                onTapFlash: () async {
                  print("you click star");
                  await context.read<HomeProvider>().changestar();
                  String likedUser =
                      widget.userSuggestionData.response[currentIndex].id;
                  try {
                    await HomeButtonNetwork().postLikeUnlike(likedUser, "1");
                  } on DioError catch (e) {
                    if (e.response.statusCode == 408) {
                      if (subdata.plan == null) {
                        if (subdata.subscriptionData.length == 0) {
                          subdata.getdata();
                          return BottomSheetClass().showplans(context);
                        } else {
                          return BottomSheetClass().showplans(context);
                        }
                      }
                    }
                    print(e);
                  }
                  print(currentIndex);
                },
              ));
            }),
            SizedBox(
              height: 20.h,
            ),
          ]);
        },
      ),
    );
  }

  goToDetailPage(Responses userDetails) {
    Routes.sailor(Routes.detailPage, params: {"userDetails": userDetails});
  }

  goToChatPage(groupid, id, image, name) {
    Routes.sailor(Routes.chattingPage,
        params: {"groupid": groupid, "id": id, "image": image, "name": name});
  }
}
