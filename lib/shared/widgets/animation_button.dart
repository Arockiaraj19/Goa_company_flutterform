import 'package:dating_app/pages/home_page/widget/circularBtn.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/animation/animator_play_states.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/attention_seekers/jello.dart';
import 'package:flutter_animator/widgets/attention_seekers/shake.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:lottie/lottie.dart';

class AnimationButton extends StatefulWidget {
  final Function onTapFlip;
  final Function onTapHeart;
  final Function onTapFlash;
  final Function onTapShake;
  final Function onTapJello;
  final bool onWeb;
  final bool isDetail;
  AnimationButton(
      {Key key,
      this.onTapFlash,
      this.onTapFlip,
      this.onTapHeart,
      this.onTapJello,
      this.onTapShake,
      this.onWeb = false,
      this.isDetail = false})
      : super(key: key);

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
              Shake(
                  preferences: AnimationPreferences(
                    autoPlay: AnimationPlayStates.None,
                  ),
                  key: shake,
                  child: CircularBtn(
                    icon: FontAwesomeIcons.solidPaperPlane,
                    btnColor: Color(0xffF85565),
                    ontap: () {
                      shake.currentState.forward();
                      goToChatPage();
                    },
                  )),
              SizedBox(
                width: 15,
              ),
              Flash(
                  preferences: AnimationPreferences(
                    autoPlay: AnimationPlayStates.None,
                  ),
                  key: flash,
                  child: CircularBtn(
                    icon: FontAwesomeIcons.solidStar,
                    btnColor: Colors.blue,
                    ontap: () {
                      flash.currentState.forward();
                      widget.onTapFlash.call();
                    },
                  )),
              SizedBox(
                width: 15,
              ),
              HeartBeat(
                  preferences: AnimationPreferences(
                    autoPlay: AnimationPlayStates.None,
                  ),
                  key: heartBeat,
                  child: _showheart
                      ? CircularBtn(
                          icon: FontAwesomeIcons.solidHeart,
                          btnColor: Colors.red,
                          ontap: () {
                            heartBeat.currentState.forward();
                            widget.onTapHeart.call();
                          },
                        )
                      : Lottiebtn(
                          icon: Lottie.asset('assets/lottie/heart.json'),
                          btnColor: Colors.red,
                          ontap: () {
                            heartBeat.currentState.forward();
                            widget.onTapHeart.call();
                          },
                        )),
            ]
          : [
              Shake(
                  preferences: AnimationPreferences(
                    autoPlay: AnimationPlayStates.None,
                  ),
                  key: shake,
                  child: CircularBtn(
                    icon: FontAwesomeIcons.solidPaperPlane,
                    btnColor: Color(0xffF85565),
                    ontap: () {
                      shake.currentState.forward();
                      goToChatPage();
                    },
                  )),
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
              Flash(
                  preferences: AnimationPreferences(
                    autoPlay: AnimationPlayStates.None,
                  ),
                  key: flash,
                  child: _showheart
                      ? CircularBtn(
                          icon: FontAwesomeIcons.solidStar,
                          btnColor: Colors.blue,
                          ontap: () {
                            flash.currentState.forward();
                            widget.onTapFlash.call();
                          },
                        )
                      : Lottiebtn(
                          icon: Lottie.asset('assets/lottie/star.json',
                              fit: BoxFit.cover),
                          btnColor: Colors.red,
                          ontap: () {
                            heartBeat.currentState.forward();
                            widget.onTapHeart.call();
                          },
                        )),
              HeartBeat(
                  preferences: AnimationPreferences(
                    autoPlay: AnimationPlayStates.None,
                  ),
                  key: heartBeat,
                  child: _showheart
                      ? CircularBtn(
                          icon: FontAwesomeIcons.solidHeart,
                          btnColor: Colors.red,
                          ontap: () {
                            heartBeat.currentState.forward();
                            widget.onTapHeart.call();
                          },
                        )
                      : Lottiebtn(
                          icon: Lottie.asset('assets/lottie/heart.json',
                              fit: BoxFit.fill),
                          btnColor: Colors.red,
                          ontap: () {
                            heartBeat.currentState.forward();
                            widget.onTapHeart.call();
                          },
                        )),
            ],
    ));
  }

  goToChatPage() {
    Routes.sailor(
      Routes.chattingPage,
    );
  }
}
