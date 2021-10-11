import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sailor/sailor.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../routes.dart';

class BottomTabBar extends StatefulWidget {
  final int currentIndex;

  BottomTabBar({@required this.currentIndex});

  @override
  _BottomTabBar createState() => _BottomTabBar();
}

class _BottomTabBar extends State<BottomTabBar> {
  int _currentTabIndex;

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.currentIndex;
  }

  final iconList = <IconData>[
    FeatherIcons.home,
    FeatherIcons.messageCircle,
    FeatherIcons.calendar,
    FeatherIcons.user,
  ];

  List<String> bottomnavheading = ['Home', 'Chat', 'Dating', 'Profile'];
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      height: 70.h,
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        final iconcolor = isActive ? Colors.pink : Color(0xff99A3B0);
        final textcolor = isActive ? Colors.pink : Colors.transparent;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5.h),
            Icon(
              iconList[index],
              size: 24,
              color: iconcolor,
            ),
            SizedBox(height: 1.h),
            Text(
              bottomnavheading[index],
              maxLines: 1,
              style: TextStyle(color: textcolor, fontSize: 40.sp),
            )
          ],
        );
      },
      backgroundColor: Colors.white,
      activeIndex: _currentTabIndex,
      splashColor: Colors.white,
      splashSpeedInMilliseconds: 100,
      notchSmoothness: NotchSmoothness.softEdge,
      gapLocation: GapLocation.center,
      onTap: _onTapped,
    );
  }

  _onTapped(int pageIndex) {
    String page;
    if (widget.currentIndex == pageIndex) return;

    switch (pageIndex) {
      case 0:
        {
          page = Routes.homePage;
          break;
        }
      case 1:
        {
          page = Routes.commentPage;
          break;
        }
      case 2:
        {
          page = Routes.matchPage;
          break;
        }
      case 3:
        {
          page = Routes.profilePage;
          break;
        }

      default:
        {
          page = Routes.homePage;
          break;
        }
    }
    setState(() {
      _currentTabIndex = pageIndex;
    });
    Routes.sailor.navigate(page, navigationType: NavigationType.pushReplace);
  }
}
