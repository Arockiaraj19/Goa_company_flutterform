import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionCard extends StatefulWidget {
  @override
  _SubscriptionCardState createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 115.h,
            decoration: BoxDecoration(
                gradient: MainTheme.loginwithBtnGradient,
                borderRadius: BorderRadius.circular(30.w)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Premium",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Unlock all our features to be in complete control \n of your experiance.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "\$9",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 70.sp,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Card(
            elevation: 5,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(40.w),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Table(columnWidths: const <int, TableColumnWidth>{
                      0: const FixedColumnWidth(210),
                      1: const FlexColumnWidth(2),
                      2: const FlexColumnWidth(2),
                    }, children: [
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0.w, top: 30.w),
                          child: tableHeading('What you get:', TextAlign.start),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0.w, top: 30.w),
                          child: tableHeading('Silver', TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0.w, top: 30.w),
                          child: tableHeading('Gold', TextAlign.center),
                        ),
                      ]),
                      tablerow("Unlimited Likes", true),
                      tablerow("Unlimited Hearts", false),
                      tablerow("Travel Mood", true),
                      tablerow("Unlimited Chats", false),
                      tablerow("Unlimited Booking", true),
                      tablerow("No ADS", false),
                      tablerow("Expert support", true),
                      tablerow("Unlimited swipe", false),
                      tablerow("Unlimited swipe", true),
                    ]),
                  ),
                ),
                Positioned(
                  right: -25,
                  top: -25,
                  child: Transform.rotate(
                    angle: 40,
                    child: Container(
                      height: 150.r,
                      width: 150.r,
                      decoration: BoxDecoration(
                          gradient: MainTheme.loginwithBtnGradient,
                          borderRadius: BorderRadius.circular(20.w)),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          InkWell(
            onTap: () => print("hello"),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 40.h,
                width: 400.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(235, 77, 181, 1),
                        Color.fromRGBO(239, 103, 152, 1)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Upgrade",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TableRow tablerow(data, istrue) {
  return TableRow(decoration: BoxDecoration(), children: [
    Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0),
      child: Row(
        children: [
          Icon(
            Icons.timer_rounded,
            color: Color(0xffEAE9E9),
            size: 20,
          ),
          SizedBox(
            width: 3.w,
          ),
          tablecontent(data),
        ],
      ),
    ),
    istrue ? access() : noaccess(),
    !istrue ? access() : noaccess(),
  ]);
}

Widget noaccess() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0),
    child: Icon(
      Icons.check_rounded,
      color: Color(0xffF3F3F3),
    ),
  );
}

Widget access() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0),
    child: Icon(
      Icons.check_rounded,
      color: Color(0xffF5B12C),
    ),
  );
}

Text tableHeading(text, textalin) {
  return Text(
    text,
    textAlign: textalin,
    style: TextStyle(
      color: Color(0xff353535),
      fontWeight: FontWeight.w600,
      fontSize: 40.sp,
    ),
  );
}

Text tablecontent(text) {
  return Text(
    text,
    textAlign: TextAlign.start,
    style: TextStyle(
      color: Color(0xff353535),
      fontWeight: FontWeight.w400,
      fontSize: 40.sp,
    ),
  );
}
