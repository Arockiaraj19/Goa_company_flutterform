import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sailor/sailor.dart';

class Alert {
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "No",
            style: TextStyle(
                fontSize: 45.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(width: 50.w),
        InkWell(
          onTap: () {
            return SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: Text(
            "Yes",
            style: TextStyle(
                fontSize: 45.sp,
                color: MainTheme.primaryColor,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(width: 20.w),
      ],
      title: Text(
        "Leave this app",
        style: TextStyle(
            fontSize: 60.sp,
            color: MainTheme.primaryColor,
            fontWeight: FontWeight.w600),
      ),
      content: Text(
        "Are you sure you want to leave this app?",
        style: TextStyle(
            fontSize: 45.sp, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
