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

  @override
  Widget build(BuildContext context) {
    return
      Container(padding: EdgeInsets.only(top: 8,bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200,offset: Offset(0.0,-1.0),blurRadius:5,spreadRadius:3)],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
      ),
      child:
          GNav(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              rippleColor: Colors.grey[800], // tab button ripple color when pressed
            hoverColor: Colors.grey[700], // tab button hover color
            haptic: true, // haptic feedback
            // tabBorderRadius: 15,
            // tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
            // tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
            // tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 300), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey, // unselected icon color
            activeColor: Colors.white, // selected icon and text color
                  tabBackgroundGradient: MainTheme.loginwithBtnGradient,
            iconSize: 25, // tab button icon size
            // tabBackgroundColor: Colors.purple.withOpacity(0.1), // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // navigat// ion bar padding
            onTabChange: _onTapped,
            selectedIndex: _currentTabIndex,
            tabs: [
            GButton(
            icon: FeatherIcons.home,
            text: 'Home',
            ),
            GButton(
            icon: FeatherIcons.messageCircle,
            text: 'Chat',
            ),
            GButton(
            icon: FeatherIcons.calendar,
            text: 'Dating',
            ),
            GButton(
            icon: FeatherIcons.user,
            text: 'Profile',
            )
        ])
      // BottomNavigationBar(
      //   elevation: 12,
      //   backgroundColor: Colors.grey.shade100,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //
      //   type: BottomNavigationBarType.fixed,
      //   onTap: _onTapped,
      //   items: [
      // BottomNavigationBarItem(
      //     icon: _currentTabIndex == 0
      //         ? Icon(Icons.home_outlined,color: MainTheme.bottomBarBtnColor,size: 30,):
      //            Icon(Icons.home_outlined,color: Colors.grey,size: 25),
      //     label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: _currentTabIndex == 1
      //             ? Icon(Icons.chat_bubble_outline_outlined,color: MainTheme.bottomBarBtnColor,size: 30,):
      //         Icon(Icons.chat_bubble_outline_outlined,color: Colors.grey,size: 25),
      //         label: "Chat"),
      //     BottomNavigationBarItem(
      //         icon: _currentTabIndex == 2
      //             ? Icon(Icons.description_outlined,color: MainTheme.bottomBarBtnColor,size: 30,):
      //         Icon(Icons.description_outlined,color: Colors.grey,size: 25),
      //         label: "Bookings"),
      //     BottomNavigationBarItem(
      //         icon: _currentTabIndex == 3
      //             ? Icon(Icons.account_circle_outlined,color: MainTheme.bottomBarBtnColor,size: 30,):
      //         Icon(Icons.account_circle_outlined,color: Colors.grey,size: 25,),
      //         label: "Profile"),
      //   ],
      // ),
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
