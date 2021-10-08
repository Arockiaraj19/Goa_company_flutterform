import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../routes.dart';

class OnboardingSwiper extends StatefulWidget {
  OnboardingSwiper(
      {Key key, this.onTap, this.promos = const <Map<String, dynamic>>[]})
      : super(key: key);
  final Function(dynamic) onTap;
  final List<Map<String, dynamic>> promos;
  @override
  _OnboardingSwiperState createState() => _OnboardingSwiperState();
}

class _OnboardingSwiperState extends State<OnboardingSwiper> {
  @override
  Widget build(BuildContext context) {
    var _textStyleHeading = TextStyle(
        color: MainTheme.onboardingTextColorHeading,
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondaryHeadingfontSize),
        fontFamily: "lato");

    var _textStyleContent = TextStyle(
        color: MainTheme.onboardingTextColorContent,
        fontSize: ScreenUtil().setSp(MainTheme.onboardingFontSize),
        fontFamily: "lato");

    var _textStyleForSikp = TextStyle(
      color: MainTheme.onboardingTextSkip,
      fontSize: ScreenUtil().setSp(MainTheme.onboardingFontSize),
      fontFamily: "Inter",
    );

    return Container(
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          dynamic _trens = widget.promos[index];
          return Stack(children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Image.asset(
                    _trens["image"],
                    fit: BoxFit.fitWidth,
                  )),
                  Container(
                      padding: EdgeInsetsDirectional.only(start: 20),
                      child: Column(children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(100),
                        ),
                        Row(
                          children: [
                            Container(
                                child: Text(
                              _trens["firstHeading"],
                              style: _textStyleHeading,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                child: Text(
                              _trens["secondHeading"],
                              style: _textStyleHeading,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(60),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(_trens["subHeading"],
                                    style: _textStyleContent)),
                          ],
                        ),
                      ]))
                ],
              ),
            ),
            index == 2
                ? Positioned(
                    bottom: 0,
                    right: 10,
                    child: GradientButton(
                      height: 40.h,
                      fontSize: 45.sp,
                      name: 'Get Started',
                      gradient: MainTheme.loginwithBtnGradient,
                      active: true,
                      color: Colors.white,
                      width: 400.w,
                      borderRadius: BorderRadius.circular(20.sp),
                      fontWeight: FontWeight.w500,
                      onPressed: () async {
                        Routes.sailor(
                          Routes.signUpPage,
                        );
                        // var dto = {"password": "123456", "email": "asd@mail.com"};
                        // _authStore.onLogin(dto);
                      },
                    ))
                : Positioned(
                    bottom: 10,
                    right: 20,
                    child: InkWell(
                        onTap: () {
                          Routes.sailor(Routes.signUpPage);
                        },
                        child: Text('Skip', style: _textStyleForSikp)))
          ]);
        },
        loop: false,
        itemCount: widget.promos.length,
        autoplay: false,
        fade: 0.0,
        pagination: SwiperPagination(
            alignment: Alignment.bottomLeft,
            builder: DotSwiperPaginationBuilder(
                color: Colors.grey[300], activeColor: MainTheme.primaryColor)),
        control: SwiperControl(
          color: Colors.transparent,
          disableColor: Colors.transparent,
        ),
      ),
    );
  }
}
