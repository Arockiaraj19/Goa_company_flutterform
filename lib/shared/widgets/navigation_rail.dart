import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sailor/sailor.dart';

import '../../routes.dart';

class NavigationMenu extends StatefulWidget {
  final int currentTabIndex;
  NavigationMenu({Key key, this.currentTabIndex}) : super(key: key);

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, constraint) => SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    selectedIndex: widget.currentTabIndex,
                    onDestinationSelected: (int index) {
                      if (index == widget.currentTabIndex) {
                        return;
                      } else {
                        _navigateToPage(index: index, context: context);
                      }
                    },
                    minWidth: 80,
                    backgroundColor: MainTheme.appBarColor,
                    labelType: NavigationRailLabelType.none,
                    leading: Text(
                      "Spark",
                      style: TextStyle(
                          color: MainTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(20),
                          fontFamily: "lato"),
                    ),
                    destinations: [
                      NavigationRailDestination(
                        icon: Image.asset(
                          "assets/icons/home.png",
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setHeight(25),
                          color: Colors.grey,
                        ),
                        selectedIcon: _buildActiveIcon(
                          "assets/icons/home.png",
                        ),
                        label: Text('First'),
                      ),
                      NavigationRailDestination(
                        icon: Image.asset(
                          "assets/icons/comment.png",
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setHeight(25),
                          color: Colors.grey,
                        ),
                        selectedIcon:
                            _buildActiveIcon("assets/icons/comment.png"),
                        label: Text('Second'),
                      ),
                      NavigationRailDestination(
                        icon: Image.asset(
                          "assets/icons/profile.png",
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setHeight(25),
                          color: Colors.grey,
                        ),
                        selectedIcon: _buildActiveIcon(
                          "assets/icons/profile.png",
                        ),
                        label: Text('Third'),
                      ),
                      NavigationRailDestination(
                        icon: Image.asset(
                          "assets/icons/menu.png",
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setHeight(25),
                          color: Colors.grey,
                        ),
                        selectedIcon: _buildActiveIcon(
                          "assets/icons/menu.png",
                        ),
                        label: Text('four'),
                      ),
                    ],
                  ),
                ))));
  }

  Widget _buildActiveIcon(String icon) {
    return Container(
      child: InkWell(
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Image.asset(
          icon,
          color: MainTheme.primaryColor,
          width: ScreenUtil().setWidth(35),
          height: ScreenUtil().setHeight(35),
        ),
        onTap: () {},
      ),
    );
  }

  void _navigateToPage({BuildContext context, int index}) {
    if (index == widget.currentTabIndex) {
      return;
    }
    switch (index) {
      case 0:
        {
          Routes.sailor(Routes.homePage,
              navigationType: NavigationType.pushReplace);
          break;
        }
      case 1:
        {
          Routes.sailor(Routes.commentPage,
              navigationType: NavigationType.pushReplace);
          break;
        }
      case 2:
        {
          Routes.sailor(Routes.profilePage,
              navigationType: NavigationType.pushReplace);

          break;
        }
      case 3:
        {
          Routes.sailor(Routes.matchPage,
              navigationType: NavigationType.pushReplace);

          break;
        }
    }
  }
}
