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
          loop: false,
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
                  data:widget.userSuggestionData.response[index],
                  cardHeight: widget.itemheight ?? 300,
                  cardWidth: widget.itemwidth ?? 400,
                  name:
                      widget.userSuggestionData.response[index].firstName ?? "",
                  image: widget.userSuggestionData.response[index]
                              .identificationImage ==
                          null
                      ? ""
                      : widget.userSuggestionData.response[index]
                          .identificationImage,
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
                    widget.userSuggestionData.response[currentIndex].id,
                    data.userData);

                goToChatPage(
                    groupid,
                    widget.userSuggestionData.response[currentIndex].id,
                    widget.userSuggestionData.response[currentIndex]
                        .identificationImage,
                    widget.userSuggestionData.response[currentIndex].firstName);
              },
              onTapHeart: () async {
                await context.read<HomeProvider>().changeheart();
                String confirmedUser =
                    widget.userSuggestionData.response[currentIndex].id;
                UserModel userData = data.userData;
                HomeButtonNetwork().postMatchRequest(confirmedUser, userData);
              },
              onTapFlash: () async {
                print("you click star");
                await context.read<HomeProvider>().changestar();
                String likedUser =
                    widget.userSuggestionData.response[currentIndex].id;
                HomeButtonNetwork().postLikeUnlike(likedUser, "1");
                print(currentIndex);
              },
            ));
      })
    ]);
  }

  goToDetailPage(Responses userDetails) {
    Routes.sailor(Routes.detailPage, params: {"userDetails": userDetails});
  }

  goToChatPage(groupid, id, image, name) {
    Routes.sailor(Routes.chattingPage,
        params: {"groupid": groupid, "id": id, "image": image, "name": name});
  }
}
