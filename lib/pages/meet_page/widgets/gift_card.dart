import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class Giftcard extends StatelessWidget {
  const Giftcard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r)),
      child: Column(
        children: [
          Image.asset(
            "assets/images/web_login_image.png",
            width: double.infinity,
            height: 180.h,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.all(10.0.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "LNF",
                    style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff666666)),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "McD Dago",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: Color(0xff1B1116),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(3.r),
                      child: Icon(
                        Icons.star,
                        color: Color(0xffFFCE1F),
                        size: 40.r,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.r),
                      child: Icon(
                        Icons.star,
                        color: Color(0xffFFCE1F),
                        size: 40.r,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.r),
                      child: Icon(
                        Icons.star,
                        color: Color(0xffFFCE1F),
                        size: 40.r,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.r),
                      child: Icon(
                        Icons.star,
                        color: Color(0xffFFCE1F),
                        size: 40.r,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.r),
                      child: Icon(
                        Icons.star,
                        color: Color(0xffFFCE1F),
                        size: 40.r,
                      ),
                    ),
                    Text(
                      "(1450 reviews)",
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff666666)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "₹1400",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: Color(0xff1B1116),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
