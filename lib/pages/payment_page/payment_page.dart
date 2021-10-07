import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff212121),
        ),
        title: Text(
          "Payment",
          style:
              TextStyle(color: Color(0xff575757), fontWeight: FontWeight.w600),
        ),
        actions: [
          Icon(
            Icons.notifications_none,
            color: Color(0xff575757),
            size: 30,
          ),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 50.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Premium Subscription Plan",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 60.h,
                decoration: BoxDecoration(
                    gradient: MainTheme.loginwithBtnGradient,
                    borderRadius: BorderRadius.circular(30.w)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total Amount Payable",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "₹800",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "Choose your payment option",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.all(20.0.w),
                child: Column(
                  children: [
                    paymentmethod("Credit Card/Debit Card"),
                    SizedBox(
                      height: 25.h,
                    ),
                    paymentmethod("Paytm"),
                    SizedBox(
                      height: 25.h,
                    ),
                    paymentmethod("GooglePay"),
                    SizedBox(
                      height: 25.h,
                    ),
                    paymentmethod("PhonePay"),
                    SizedBox(
                      height: 25.h,
                    ),
                    paymentmethod("BHIM/UPI"),
                    SizedBox(
                      height: 25.h,
                    ),
                    paymentmethod("Amazon Pay"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row paymentmethod(data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              "assets/images/web_login_image.png",
              height: 80.r,
              width: 80.r,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              data,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 50.r,
        )
      ],
    );
  }
}
