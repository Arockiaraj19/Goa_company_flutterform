import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
              padding: EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 10,
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                  size: 25,
                ),
              )),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 70.r, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Terms of serviece",
                    style: TextStyle(
                        color: Color(0xff323F4B),
                        fontSize: 45.sp,
                        fontFamily: "Inter"),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 45.sp,
                        color: Color(0xff7B8794),
                      ))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Open Source Libraries",
                    style: TextStyle(
                        color: Color(0xff323F4B),
                        fontSize: 45.sp,
                        fontFamily: "Inter"),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 45.sp,
                        color: Color(0xff7B8794),
                      ))
                ],
              ),
              Divider(),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "App Version",
                style: TextStyle(
                    color: Color(0xff323F4B),
                    fontSize: 45.sp,
                    fontFamily: "Inter"),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "v10.1Live",
                style: TextStyle(
                    color: Color(0xff323F4B),
                    fontSize: 45.sp,
                    fontFamily: "Inter"),
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}