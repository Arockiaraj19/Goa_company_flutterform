import 'package:dating_app/pages/onboarding_page/widgets/onboarding_swiper.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/notification_provider.dart';
import 'package:dating_app/providers/subscription_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> item = [
      {
        "image": "assets/images/locations.png",
        "firstHeading": "Find Your",
        'secondHeading': "Perfect Match",
        'subHeading': "The greatest way to make a love connections",
      },
      {
        "image": "assets/images/couple.png",
        "firstHeading": "Meet",
        'secondHeading': "Interesting People",
        'subHeading': "Spark Date based on your personal perference",
      },
      {
        "image": "assets/images/dating.png",
        "firstHeading": "Date",
        'secondHeading': "With Partner",
        'subHeading': "We partner with exclusive venues to schedule",
      }
    ];

    // ScreenUtil.init(context);

    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: OnboardingSwiper(
          promos: item,
        ),
      ),
    ));
  }
}
