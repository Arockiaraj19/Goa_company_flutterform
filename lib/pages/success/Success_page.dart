import 'dart:ui';

import 'package:dating_app/pages/success/widget/buttons.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget/logo_text.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 40.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Logotext(),
              SizedBox(
                height: 85,
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 82.h,
                      width: 82.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 50.h,
                      ),
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    Text(
                      "Success",
                      style: TextStyle(
                          fontSize: 60.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff374151)),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "Congratulations your password has been changed",
                      style: TextStyle(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.normal,
                          color: Color(0xff828282)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 212.h,
              ),
              Align(
                alignment: Alignment.center,
                child: GradientButton(
                  name: "Sign In",
                  gradient: MainTheme.loginBtnGradient,
                  height: 35,
                  fontSize: 14,
                  width: 150,
                  active: true,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  onPressed: () {
                    Modular.to.pushNamed(
                      Navigate.loginWith + "?name=EMAIL",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
