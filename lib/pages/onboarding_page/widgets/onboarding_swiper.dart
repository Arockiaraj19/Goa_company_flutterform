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
      fontSize: 40.sp,
      fontFamily: "Inter",
    );

    return Container(
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          dynamic _trens = widget.promos[index];
          return Stack(children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  Container(
                      height: 300.h,
                      width: double.infinity,
                      child: Image.asset(
                        _trens["image"],
                        fit: BoxFit.fitWidth,
                      )),
                  Container(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 80.r, vertical: 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(105),
                          ),
                          Container(
                              child: Text(
                            _trens["firstHeading"] +
                                "\n" +
                                _trens["secondHeading"],
                            style: _textStyleHeading,
                          )),
                          // Container(
                          //     child: Text(
                          //   _trens["secondHeading"],
                          //   style: _textStyleHeading,
                          // )),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(_trens["subHeading"],
                                      style: _textStyleContent)),
                            ],
                          ),
                        ]),
                  ))
                ],
              ),
            ),
            index == 2
                ? Positioned(
                    bottom: 90.w,
                    right: 60.w,
                    child: GradientButton(
                      height: 35.h,
                      fontSize: 35.sp,
                      name: 'Get Started',
                      gradient: MainTheme.loginwithBtnGradient,
                      active: true,
                      color: Colors.white,
                      width: 300.w,
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
                    bottom: 125.w,
                    right: 70.w,
                    child: InkWell(
                        onTap: () {
                          Routes.sailor(Routes.signUpPage);
                        },
                        child: Text('Skip', style: _textStyleForSikp))),
          ]);
        },
        loop: false,
        itemCount: widget.promos.length,
        autoplay: false,
        fade: 0.0,
        pagination: SwiperPagination(
            margin: EdgeInsets.symmetric(vertical: 100.w, horizontal: 70.w),
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
