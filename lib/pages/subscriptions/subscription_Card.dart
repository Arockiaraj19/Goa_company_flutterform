import 'package:dating_app/models/subscription_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/subscription.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/subscription_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/regex_pattern.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionCard extends StatefulWidget {
  SubscriptionModel data;
  int index;
  bool onboard;
  final bool onWeb;
  SubscriptionCard(this.data, this.index, this.onboard, this.onWeb);
  @override
  _SubscriptionCardState createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  bool loading = false;
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showtoast("SUCCESS: " + response.paymentId);
    print("success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showtoast(
      "ERROR: " + response.code.toString() + " - " + response.message,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showtoast("EXTERNAL_WALLET: " + response.walletName);
  }

  void openCheckout(UserModel data) async {
    print("email correct a varutha");
    print(data.email);

    var options = {
      'key': "jGSNzmgHnMrqaob7fgFmZTuZ",
      'amount': double.parse(widget.data.price.toString()) * 100,
      "currency": "INR",
      'name': data.firstName + " " + data.lastName,
      'description': 'Payment',
      'prefill': {
        'contact': "0000000000",
        'email': "testemail@gmail.com",
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: widget.onWeb ? 0 : 10.h, horizontal: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: widget.onWeb ? 0 : 30.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: widget.onWeb
                      ? MediaQuery.of(context).size.width * 0.235
                      : MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      gradient: widget.index % 2 == 0
                          ? MainTheme.subscripeCard1
                          : MainTheme.subscripeCard,
                      borderRadius:
                          BorderRadius.circular(widget.onWeb ? 7 : 30.w)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: widget.onWeb ? 0 : 5.h,
                        ),
                        Text(
                          widget.data.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: widget.onWeb ? 15 : 50.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: widget.onWeb ? 2.5 : 5.h,
                        ),
                        Text(
                          "Unlock all our features to be in complete control of your experiance.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: widget.onWeb ? 12 : 40.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: widget.onWeb ? 2.5 : 5.h,
                        ),
                        if (widget.data.subscriptionType == "Payment")
                          Text(
                            widget.data.currencyType.symbol.toString() +
                                widget.data.price.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.onWeb ? 15 : 70.sp,
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
                                    fontSize: widget.onWeb ? 15 : 70.sp,
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
                                    fontSize: widget.onWeb ? 10 : 35.sp,
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
                                    fontSize: widget.onWeb ? 10 : 35.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: widget.onWeb ? 0 : 5.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: widget.onWeb ? 10 : 30.h,
              ),
              Consumer<SubscriptionProvider>(
                builder: (context, data, child) {
                  return Card(
                    elevation: 5,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(widget.onWeb ? 10 : 40.w),
                          child: Container(
                            width: widget.onWeb
                                ? MediaQuery.of(context).size.width * 0.22
                                : MediaQuery.of(context).size.width * 1,
                            child: Table(columnWidths: <int, TableColumnWidth>{
                              0: FixedColumnWidth(widget.onWeb ? 170 : 500.w),
                              1: FlexColumnWidth(widget.onWeb ? 50 : 100.w),
                            }, children: [
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: widget.onWeb ? 10 : 30.0.w,
                                      top: widget.onWeb ? 10 : 30.w),
                                  child: tableHeading('What you get:',
                                      TextAlign.start, widget.onWeb),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: widget.onWeb ? 5 : 30.0.w,
                                      top: widget.onWeb ? 5 : 30.w),
                                  child: tableHeading(
                                      'Silver', TextAlign.center, widget.onWeb),
                                ),
                              ]),
                              for (var plan in data.checklistData)
                                tablerow(
                                    plan.title,
                                    widget.data.checklists.any(
                                        (element) => element.id == plan.id),
                                    widget.onWeb),
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
                height: widget.onWeb ? 10 : 40.h,
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<HomeProvider>(builder: (context, data, child) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!widget.onWeb)
                              InkWell(
                                onTap: () async {
                                  if (widget.onboard) {
                                    Routes.sailor(Routes.findMatchPage);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  height: widget.onWeb ? 35 : 30.h,
                                  width: widget.onWeb ? 130 : 300.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: MainTheme.primaryColor,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                        color: MainTheme.primaryColor,
                                        fontSize: widget.onWeb ? 14 : 40.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            if (!widget.onWeb)
                              SizedBox(
                                width: widget.onWeb ? 25 : 100.w,
                              ),
                            InkWell(
                              onTap: () async {
                                try {
                                  setState(() {
                                    loading = true;
                                  });
                                  if (widget.data.subscriptionType == "Coins") {
                                    await Subscription().addPlan(
                                        widget.data.id,
                                        widget.data.validity,
                                        widget.data.durationType,
                                        widget.data.coins,
                                        widget.data.subscriptionType);
                                    Routes.sailor(Routes.findMatchPage);
                                  } else {
                                    openCheckout(data.userData);
                                  }

                                  // UserModel result =
                                  //     await UserNetwork().getUserData();
                                  // onboardingCheck(result);

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
                                height: widget.onWeb ? 35 : 30.h,
                                width: widget.onWeb ? 130 : 300.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    gradient: MainTheme.backgroundGradient,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "Upgrade",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: widget.onWeb ? 14 : 40.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
            ],
          ),
        ),
        Positioned(
            right: 0, top: 0, child: Image.asset("assets/images/salyImage.png"))
      ],
    );
  }
}

TableRow tablerow(data, istrue, onWeb) {
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
          tablecontent(data, onWeb),
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

Text tableHeading(text, textalin, onWeb) {
  return Text(
    text,
    textAlign: textalin,
    style: TextStyle(
      color: Color(0xff353535),
      fontWeight: FontWeight.w600,
      fontSize: onWeb ? 14 : 40.sp,
    ),
  );
}

Text tablecontent(text, onWeb) {
  return Text(
    text,
    textAlign: TextAlign.start,
    style: TextStyle(
      color: Color(0xff353535),
      fontWeight: FontWeight.w400,
      fontSize: onWeb ? 14 : 40.sp,
    ),
  );
}
