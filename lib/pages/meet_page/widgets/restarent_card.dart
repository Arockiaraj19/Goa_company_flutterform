import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestorentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: Image.asset(
                  "assets/images/web_login_image.png",
                  height: 220.r,
                  width: 220.r,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 25.w,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "McD Dago",
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: Color(0xff1B1116),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "Jl. Ir. H. Juanda No.181, Simpang, Dago",
                        style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff666666)),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                            size: 18,
                          ),
                          Text(
                            "4 kilometers away",
                            style: TextStyle(
                                fontSize: 30.sp, color: Color(0xff666666)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
