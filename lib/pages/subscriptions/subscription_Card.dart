import 'package:dating_app/models/subscription_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/subscription.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SubscriptionCard extends StatefulWidget {
  SubscriptionModel data;
  int index;
  bool onboard;
  SubscriptionCard(this.data, this.index, this.onboard);
  @override
  _SubscriptionCardState createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    gradient: widget.index % 2 == 0
                        ? MainTheme.subscripeCard1
                        : MainTheme.subscripeCard,
                    borderRadius: BorderRadius.circular(30.w)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      widget.data.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Unlock all our features to be in complete control of your experiance.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    if (widget.data.subscriptionType == "Payment")
                      Text(
                        widget.data.currencyType.symbol.toString() +
                            widget.data.price.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 70.sp,
                            fontWeight: FontWeight.w800),
                      ),
                    if (widget.data.subscriptionType == "Coins")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            widget.data.coins.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 70.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    if (widget.data.durationType == 2)
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.data.validity.toString() + " " + "days",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    if (widget.data.durationType == 1)
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.data.validity.toString() + " " + "years",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Consumer<SubscriptionProvider>(
                builder: (context, data, child) {
                  return Card(
                    elevation: 5,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(40.w),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Table(columnWidths: <int, TableColumnWidth>{
                              0: FixedColumnWidth(500.w),
                              1: FlexColumnWidth(100.w),
                            }, children: [
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 30.0.w, top: 30.w),
                                  child: tableHeading(
                                      'What you get:', TextAlign.start),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 30.0.w, top: 30.w),
                                  child:
                                      tableHeading('Silver', TextAlign.center),
                                ),
                              ]),
                              for (var plan in data.checklistData)
                                tablerow(
                                    plan.title,
                                    widget.data.checklists.any(
                                        (element) => element.id == plan.id)),
                            ]),
                          ),
                        ),
                        Positioned(
                          right: -100.w,
                          top: -100.w,
                          child: Transform.rotate(
                            angle: 40,
                            child: Container(
                              height: 300.r,
                              width: 150.r,
                              decoration: BoxDecoration(
                                  gradient: MainTheme.loginwithBtnGradient,
                                  borderRadius: BorderRadius.circular(20.w)),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (widget.onboard) {
                                Routes.sailor(Routes.findMatchPage);
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              height: 30.h,
                              width: 300.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: MainTheme.primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                    color: MainTheme.primaryColor,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                          ),
                          InkWell(
                            onTap: () async {
                              try {
                                setState(() {
                                  loading = true;
                                });
                                await Subscription().addPlan(
                                    widget.data.id,
                                    widget.data.validity,
                                    widget.data.durationType,
                                    widget.data.coins,
                                    widget.data.subscriptionType);
                                // UserModel result =
                                //     await UserNetwork().getUserData();
                                // onboardingCheck(result);
                                Routes.sailor(Routes.findMatchPage);
                              } on DioError catch (e) {
                                print("error enna varuthu");
                                print(e);
                                setState(() {
                                  loading = false;
                                });
                                // if (e.response.statusCode == 409) {
                                //   print("ithukulla error varuthaaa");
                                //   setState(() {
                                //     loading = false;
                                //   });
                                //   UserModel result =
                                //       await UserNetwork().getUserData();
                                //   onboardingCheck(result);
                                // }
                              }
                            },
                            child: Container(
                              height: 30.h,
                              width: 300.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  gradient: MainTheme.backgroundGradient,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "Upgrade",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
        Positioned(
            right: 0, top: 0, child: Image.asset("assets/images/salyImage.png"))
      ],
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
