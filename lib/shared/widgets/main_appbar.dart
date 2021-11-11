import 'package:dating_app/providers/notification_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatefulWidget {
  final Function onTapFilter;
  final bool istrue;
  MainAppBar({Key key, this.onTapFilter, this.istrue}) : super(key: key);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    var _textStyleforHeading = TextStyle(
        color: MainTheme.mainHeadingColors,
        fontWeight: FontWeight.bold,
        fontSize: 50.sp,
        fontFamily: "lato");
    return AppBar(
      backgroundColor: Colors.grey.shade50,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        if (widget.istrue)
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 50.w),
              child: Consumer<NotificationProvider>(
                builder: (context, data, child) {
                  return InkWell(
                    onTap: () {
                      Routes.sailor(Routes.notification);
                    },
                    child: Stack(
                      children: [
                        Container(
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
              ),
            ),
          )
      ],
    );
  }
}
