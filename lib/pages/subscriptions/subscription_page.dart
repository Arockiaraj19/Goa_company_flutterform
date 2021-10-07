import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'subscription_Card.dart';

class Subscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Subscription",
            style: TextStyle(
                color: Color(0xff575757), fontWeight: FontWeight.w600),
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
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              SubscriptionCard(),
              SubscriptionCard(),
              SubscriptionCard(),
            ],
          ),
        ),
      ),
    );
  }
}
