import 'package:dating_app/providers/notification_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function onTapFilter;
  final bool istrue;
  MainAppBar({Key key, this.onTapFilter, this.istrue}) : super(key: key);

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    var _textStyleforHeading = TextStyle(
        color: MainTheme.mainHeadingColors,
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondaryHeadingfontSize),
        fontFamily: "lato");
    return AppBar(
        backgroundColor: Colors.grey.shade50, // MainTheme.appBarColor,
        elevation: 0,
        actions: [
          if (widget.istrue)
            Consumer<NotificationProvider>(
              builder: (context, data, child) {
                return InkWell(
                  onTap: () {
                    Routes.sailor(Routes.notification);
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(end: 10, top: 5),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                      if (data.notificationData.length != 0)
                        Positioned(
                          right: 8,
                          top: 2,
                          child: Container(
                              alignment: Alignment.center,
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: MainTheme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                data.notificationData.length.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.sp,
                                ),
                              )),
                        )
                    ],
                  ),
                );
              },
            )
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight - 100),
            child: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight - 50),
                child: Column(children: [
                  Container(
                      padding: EdgeInsetsDirectional.only(start: 30, end: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:
                                  Text("Discover", style: _textStyleforHeading),
                            ),
                            Container(
                                margin: EdgeInsetsDirectional.only(end: 10),
                                child: InkWell(
                                  onTap: () {
                                    _showOtpBottomSheet();
                                  },
                                  child: Image.asset(
                                    "assets/icons/adjust.png",
                                    color: Colors.grey,
                                    width: 25,
                                    height: 25,
                                  ),
                                ))
                          ])),
                ]))));
  }

  _showOtpBottomSheet() {
    showModalBottomSheet(
        context: context,
        // isScrollControlled: true,
        // isDismissible: false,
        // enableDrag: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (BuildContext context) {
          return Column(
              mainAxisSize: MainAxisSize.min, children: [FilterBottomSheet()]);
        });
  }
}
