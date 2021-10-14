import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/home_button_network.dart';
import 'package:dating_app/pages/home_page/widget/imageCard.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/widgets/animation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:lottie/lottie.dart';

class ImageSwiper extends StatefulWidget {
  ImageSwiper(
      {Key key,
      this.onTap,
      this.promos = const <dynamic>[],
      this.height,
      this.itemheight,
      this.itemwidth,
      this.width,
      this.userSuggestionData})
      : super(key: key);
  final Function(dynamic) onTap;
  final List<dynamic> promos;
  final UsersSuggestionModel userSuggestionData;
  final double height;
  final double width;
  final double itemheight;
  final double itemwidth;

  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        // height: widget.height ?? 250,
        width: widget.width ?? MediaQuery.of(context).size.width,
        child: Swiper(
          onIndexChanged: (int ind) {
            currentIndex = ind;
          },
          layout: SwiperLayout.TINDER,
          itemWidth: widget.itemwidth ?? 300,
          itemHeight: widget.itemheight ?? 400,
          itemBuilder: (BuildContext context, int index) {
            // dynamic _trens = widget.promos[index];
            return InkWell(
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  goToDetailPage(widget.userSuggestionData.response[index]);
                },
                child: ImageCard(
                  cardHeight: widget.itemheight ?? 300,
                  cardWidth: widget.itemwidth ?? 400,
                  name: widget.userSuggestionData.response[index].firstName ??
                      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                  image: widget.userSuggestionData.response[index].profileImage
                              .length ==
                          0
                      ? ""
                      : widget.userSuggestionData.response[index].profileImage
                              .first ??
                          "",
                ));
          },
          itemCount: widget.userSuggestionData.response.length,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Consumer<HomeProvider>(builder: (context, data, child) {
        return Container(
            // width: 300,
            padding: EdgeInsetsDirectional.only(start: 20, end: 20),
            child: AnimationButton(
              loadingstar: data.showstar,
              loadingheart: data.showheart,
              goChatPage: () async {
                print("message");
                String groupid = await ChatNetwork().createGroup(
                    widget.userSuggestionData.response[currentIndex].id,data.userData);

                goToChatPage(groupid,
                    widget.userSuggestionData.response[currentIndex].id);
              },
              onTapHeart: () {
                 context.read<HomeProvider>().changeheart();
                String confirmedUser =
                    widget.userSuggestionData.response[currentIndex].id;
                UserModel userData = data.userData;
                HomeButtonNetwork().postMatchRequest(confirmedUser, userData);
              },
              onTapFlash: () {
                print("you click star");
                 context.read<HomeProvider>().changestar();
                print(currentIndex);
                String likedUser =
                    widget.userSuggestionData.response[currentIndex].id;
                HomeButtonNetwork().postLikeUnlike(likedUser, "1");
              },
            ));
      })
    ]);
  }

  goToDetailPage(Responses userDetails) {
    Routes.sailor(Routes.detailPage, params: {"userDetails": userDetails});
  }

  goToChatPage(groupid, id) {
    Routes.sailor(Routes.chattingPage, params: {"groupid": groupid, "id": id});
  }
}
