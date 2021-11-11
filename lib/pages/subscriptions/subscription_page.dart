import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/shared/widgets/error_card.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'subscription_Card.dart';

class Subscription extends StatefulWidget {
  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionProvider>().getdata();
  }

  SwiperController _controller = SwiperController();
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
                  fontSize: 50.sp,
                  color: Color(0xff575757),
                  fontWeight: FontWeight.w600),
            ),
            actions: [
              // Icon(
              //   Icons.notifications_none,
              //   color: Color(0xff575757),
              //   size: 30,
              // ),
              // SizedBox(
              //   width: 15.w,
              // ),
            ],
          ),
          backgroundColor: Colors.white,
          body: Consumer<SubscriptionProvider>(
            builder: (context, data, child) {
              return data.subscriptionState == SubscriptionState.Error
                  ? ErrorCard(
                      text: data.errorText,
                      ontab: () {
                        context.read<SubscriptionProvider>().getdata();
                      })
                  : data.subscriptionState == SubscriptionState.Loaded
                      ? data.subscriptionData.length == 0
                          ? noResult()
                          : Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Swiper(
                                  scrollDirection: Axis.horizontal,
                                  controller: _controller,
                                  viewportFraction: 0.85,
                                  scale: 0.9,
                                  loop: false,
                                  outer: true,
                                  itemHeight: 480.h,
                                  itemWidth: double.infinity,
                                  itemCount: data.subscriptionData.length,
                                  itemBuilder: (context, index) {
                                    return SingleChildScrollView(
                                      child: SubscriptionCard(
                                          data.subscriptionData[index], index),
                                    );
                                  }))
                      : Center(
                          child: CircularProgressIndicator(),
                        );
            },
          )),
    );
  }
}
