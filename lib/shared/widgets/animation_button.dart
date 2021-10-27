import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/animation/animator_play_states.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/attention_seekers/jello.dart';
import 'package:flutter_animator/widgets/attention_seekers/shake.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/src/provider.dart';

import 'package:dating_app/pages/home_page/widget/circularBtn.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/routes.dart';

class AnimationButton extends StatefulWidget {
  final bool loadingstar;
  final bool loadingheart;
  final Function goChatPage;
  final Function onTapFlip;
  final Function onTapHeart;
  final Function onTapFlash;
  final Function onTapShake;
  final Function onTapJello;
  final bool onWeb;
  final bool isDetail;
  AnimationButton(
      {Key key,
      this.loadingstar,
      this.loadingheart,
      this.goChatPage,
      this.onTapFlip,
      this.onTapHeart,
      this.onTapFlash,
      this.onTapShake,
      this.onTapJello,
      this.onWeb = false,
      this.isDetail = false});

  @override
  _AnimationButtonState createState() => _AnimationButtonState();
}

class _AnimationButtonState extends State<AnimationButton> {
  final GlobalKey<AnimatorWidgetState> flip = GlobalKey<AnimatorWidgetState>();

  final GlobalKey<AnimatorWidgetState> heartBeat =
      GlobalKey<AnimatorWidgetState>();

  final GlobalKey<AnimatorWidgetState> flash = GlobalKey<AnimatorWidgetState>();

  final GlobalKey<AnimatorWidgetState> shake = GlobalKey<AnimatorWidgetState>();

  final GlobalKey<AnimatorWidgetState> jello = GlobalKey<AnimatorWidgetState>();
  bool _showheart = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widget.isDetail
          ? [
              CircularBtn(
                  icon: FontAwesomeIcons.solidPaperPlane,
                  btnColor: Color(0xffF85565),
                  ontap: widget.goChatPage),
              SizedBox(
                width: 15,
              ),
              widget.loadingstar
                  ? CircularBtn(
                      icon: FontAwesomeIcons.solidStar,
                      btnColor: Colors.blue,
                      ontap: () {
                        widget.onTapFlash();
                      },
                    )
                  : Lottiebtn(
                      icon: Lottie.asset('assets/lottie/star.json',
                          fit: BoxFit.cover),
                      btnColor: Colors.red,
                      ontap: () {},
                    ),
              SizedBox(
                width: 15,
              ),
              widget.loadingheart
                  ? CircularBtn(
                      icon: FontAwesomeIcons.solidHeart,
                      btnColor: Colors.red,
                      ontap: () {
                        widget.onTapHeart();
                      },
                    )
                  : Lottiebtn(
                      icon: Lottie.asset('assets/lottie/heart.json'),
                      btnColor: Colors.red,
                      ontap: () {},
                    ),
            ]
          : [
              CircularBtn(
                  icon: FontAwesomeIcons.solidPaperPlane,
                  btnColor: Color(0xffF85565),
                  ontap: widget.goChatPage),
              Jello(
                  preferences: AnimationPreferences(
                    autoPlay: AnimationPlayStates.None,
                  ),
                  key: jello,
                  child: CircularBtn(
                    icon: FontAwesomeIcons.redo,
                    btnColor: Colors.yellow,
                    ontap: () {
                      context.read<HomeProvider>().reload();
                      jello.currentState.forward();
                    },
                  )),
              widget.loadingstar
                  ? CircularBtn(
                      icon: FontAwesomeIcons.solidStar,
                      btnColor: Colors.blue,
                      ontap: () {
                        widget.onTapFlash();
                      },
                    )
                  : Lottiebtn(
                      icon: Lottie.asset('assets/lottie/star.json',
                          fit: BoxFit.cover),
                      btnColor: Colors.red,
                      ontap: () {},
                    ),
              widget.loadingheart
                  ? CircularBtn(
                      icon: FontAwesomeIcons.solidHeart,
                      btnColor: Colors.red,
                      ontap: () {
                        widget.onTapHeart();
                      },
                    )
                  : Lottiebtn(
                      icon: Lottie.asset('assets/lottie/heart.json',
                          fit: BoxFit.fill),
                      btnColor: Colors.red,
                      ontap: () {},
                    ),
            ],
    ));
  }
}
