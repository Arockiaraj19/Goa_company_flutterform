import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTheme {
  MainTheme();

  factory MainTheme.init() {
    return MainTheme();
  }

  static const Color appBarColor = Colors.white;
  static const Color bottomBarColor = Color.fromRGBO(251, 251, 251, 1);
  static const Color bottomBarBtnColor = Color.fromRGBO(235, 77, 181, 1);
  static const Color primaryColor = Color.fromRGBO(235, 77, 181, 1);
  static const Color showMoreColor = Color.fromRGBO(235, 77, 181, 1);
  static const Color loginTextColor = Color.fromRGBO(232, 232, 232, 1);
  static const Color trackColors = Color.fromRGBO(255, 255, 255, 1);

  ///////onboardingTextColor
  static const Color onboardingTextColorHeading = Color.fromRGBO(63, 63, 63, 1);
  static const Color onboardingTextColorContent = Color.fromRGBO(86, 86, 86, 1);
  static const Color onboardingTextSkip = Color.fromRGBO(116, 116, 116, 1);
  static const double onboardingFontSize = 35;
  static const LinearGradient getStartedBtnGradient = LinearGradient(
      colors: <Color>[
        Color.fromRGBO(235, 77, 181, 1),
        Color.fromRGBO(239, 103, 152, 1)
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: <double>[0.0, 1.0],
      tileMode: TileMode.mirror);

  //////// end

  ////////login and sign up

  static const Color sparksTextColor = Color.fromRGBO(245, 245, 245, 1);
  static const Color matchTextColor = Color.fromRGBO(232, 232, 232, 1);
  static const Color contentTextColor = Color.fromRGBO(236, 236, 236, 1);
  static const Color alreadyTextColor = Color.fromRGBO(217, 217, 217, 1);
  static const Color logincontentTextColor = Color.fromRGBO(217, 217, 217, 1);

  //////////end

  //////// login with
  static const Color welcomeBackTextColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color goodToSeeTextColor = Color.fromRGBO(227, 227, 227, 1);
  static const Color enterTextColor = Color.fromRGBO(24, 23, 37, 1);
  static const Color forgotPassTextColor = Color.fromRGBO(151, 151, 151, 1);

  static const LinearGradient loginwithBtnGradient = LinearGradient(
      colors: <Color>[
        Color.fromRGBO(237, 107, 192, 1),
        Color.fromRGBO(239, 103, 144, 1)
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: <double>[0.0, 1.0],
      tileMode: TileMode.mirror);



  //////otp page

  static const Color codeIsSendTextColor = Color.fromRGBO(86, 86, 86, 1);

  /////end

  /// sign with pages
  static const Color leadingHeadings = Color.fromRGBO(24, 23, 37, 1);

  ///end

  ///add your profile

  static const Color holdAndDrageTextColors = Color.fromRGBO(102, 102, 102, 1);

  ///

  ///home
  static const Color mainHeadingColors = Color.fromRGBO(53, 53, 53, 1);

  ///end

  ///profile

  static const Color profileNameColors = Color.fromRGBO(79, 79, 79, 1);
  static const Color webProfileScoreName = Color.fromRGBO(74, 74, 74, 1);

  static const Color profileValue = Color.fromRGBO(255, 255, 255, 1);

  static const LinearGradient ScoreBackgroundGradient = LinearGradient(
      colors: <Color>[
        Color.fromRGBO(235, 77, 181, 1),
        Color.fromRGBO(246, 94, 126, 1)
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: <double>[0.0, 0.5],
      tileMode: TileMode.mirror);

  static const Color socialMediaText = Color.fromRGBO(118, 118, 118, 1);
  static const Color socialMediaTextBold = Color.fromRGBO(24, 23, 37, 1);

  ///

  static const double mPrimaryHeadingfontSize = 90; //44
  static const double mSecondaryHeadingfontSize = 55; //24
  static const double mPrimarySubHeadingfontSize = 45; //22
  static const double mSecondarySubHeadingfontSize = 40; //18
  static const double mTertiarySubHeadingfontSize = 37; //16
  static const double mPrimaryContentfontSize = 35; //14
  static const double mSecondaryContentfontSize = 28; //12

  static const TextStyle primaryHeading = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontFamily: "OpenSans",
    fontSize: 20,
  );

  static const TextStyle secondaryHeading = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontFamily: "OpenSans",
    fontSize: 18,
  );

  static const TextStyle subHeading = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontFamily: "OpenSans",
    fontSize: 13,
  );

  static const TextStyle primaryContent = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontFamily: "OpenSans",
    fontSize: 14,
  );

  static const TextStyle secondaryContent = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontFamily: "OpenSans",
    fontSize: 12,
  );

  



  static const LinearGradient buttonGradient = LinearGradient(
      colors: <Color>[
        Color.fromRGBO(255, 103, 155, 1),
        Color.fromRGBO(255, 137, 96, 1),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: <double>[0.1, 0.9],
      tileMode: TileMode.mirror);

  static const LinearGradient loginBtnGradient = LinearGradient(
      colors: <Color>[
        Color.fromRGBO(235, 77, 181, 1),
        Color.fromRGBO(239, 103, 144, 1)
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: <double>[0.1, 0.9],
      tileMode: TileMode.mirror);

  static const LinearGradient loginBtnGradientwhite = LinearGradient(
      colors: <Color>[Colors.white, Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: <double>[0.1, 0.9],
      tileMode: TileMode.mirror);

  static const LinearGradient loginBtnGradientGrey = LinearGradient(
      colors: <Color>[Colors.grey, Colors.grey],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: <double>[0.1, 0.9],
      tileMode: TileMode.mirror);

  static const LinearGradient firstPercentBarColor = LinearGradient(
      colors: <Color>[
        Color.fromRGBO(237, 107, 192, 0.5),
        Color.fromRGBO(246, 94, 126, 0.5)
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topLeft,
      stops: <double>[0, 0.5],
      tileMode: TileMode.mirror);

  static const LinearGradient backgroundGradient = LinearGradient(
      colors: <Color>[
        Color.fromRGBO(235, 77, 181, 1),
        Color.fromRGBO(248, 85, 101, 1)
      ],
      begin: Alignment.topCenter,
      end: Alignment.topCenter,
      stops: <double>[0.0, 1.0],
      tileMode: TileMode.mirror);
}
