import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/loadingLottie.dart';
import 'package:dating_app/shared/helpers/websize.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'error_card.dart';
import 'no_result.dart';

class BottomsheetWidget extends StatelessWidget {
  final bool onWeb;
  const BottomsheetWidget({Key key, this.onWeb = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionProvider>(
      builder: (context, watch, child) {
        return watch.subscriptionState == SubscriptionState.Error
            ? ErrorCard(
                text: watch.errorText, ontab: () => Navigator.pop(context))
            : watch.subscriptionState == SubscriptionState.Loaded
                ? watch.subscriptionData.length == 0
                    ? noResult()
                    : Stack(
                        children: [
                          Container(
                            decoration:
                                BoxDecoration(gradient: MainTheme.bottomsheet),
                            height: 500.h,
                            child: Column(children: [
                              Text(
                                "Unlock the rest of your profile  view \nwith premium",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: onWeb ? inputFont : 40.sp,
                                ),
                              ),
                              SizedBox(
                                height: onWeb ? 5 : 10.h,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: ListView(
                                      shrinkWrap: true,
                                      children: List.generate(
                                        watch.subscriptionData.length,
                                        (index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 5.h,
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  NavigateFunction().withquery(
                                                      Navigate.subscription +
                                                          "?swiperIndex= $index");
                                                },
                                                child: Container(
                                                  width: 400,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      gradient: index % 2 == 0
                                                          ? MainTheme
                                                              .subscripeCard1
                                                          : MainTheme
                                                              .subscripeCard,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Text(
                                                          watch
                                                              .subscriptionData[
                                                                  index]
                                                              .title,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: onWeb
                                                                  ? inputFont
                                                                  : 45.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Text(
                                                          "Unlock all our features to be in complete control \n of your experiance.",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: onWeb
                                                                  ? 13
                                                                  : 35.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        if (watch
                                                                .subscriptionData[
                                                                    index]
                                                                .subscriptionType ==
                                                            "Payment")
                                                          Text(
                                                            watch
                                                                    .subscriptionData[
                                                                        index]
                                                                    .currencyType
                                                                    .symbol
                                                                    .toString() +
                                                                watch
                                                                    .subscriptionData[
                                                                        index]
                                                                    .price
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: onWeb
                                                                    ? 22
                                                                    : 70.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        if (watch
                                                                .subscriptionData[
                                                                    index]
                                                                .subscriptionType ==
                                                            "Coins")
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/coin.png",
                                                                width: 25,
                                                                height: 25,
                                                              ),
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                              Text(
                                                                watch
                                                                    .subscriptionData[
                                                                        index]
                                                                    .coins
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: onWeb
                                                                        ? 22
                                                                        : 70.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ],
                                                          ),
                                                        if (watch
                                                                .subscriptionData[
                                                                    index]
                                                                .durationType ==
                                                            2)
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 0, 8, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                watch
                                                                        .subscriptionData[
                                                                            index]
                                                                        .validity
                                                                        .toString() +
                                                                    " " +
                                                                    "days",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: onWeb
                                                                        ? 13
                                                                        : 35.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ),
                                                          ),
                                                        if (watch
                                                                .subscriptionData[
                                                                    index]
                                                                .durationType ==
                                                            1)
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 0, 8, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                watch
                                                                        .subscriptionData[
                                                                            index]
                                                                        .validity
                                                                        .toString() +
                                                                    " " +
                                                                    "years",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: onWeb
                                                                        ? 13
                                                                        : 35.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ),
                                                          ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                              // SizedBox(
                              //   height: 30.h,
                              // ),
                            ]),
                          ),
                          Positioned(
                              right: onWeb
                                  ? MediaQuery.of(context).size.width / 3.3
                                  : 0,
                              top: 0,
                              child: Image.asset("assets/images/salyImage.png"))
                        ],
                      )
                : LoadingLottie();
      },
    );
  }
}
