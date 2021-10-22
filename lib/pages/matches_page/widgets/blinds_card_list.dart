import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/pages/matches_page/widgets/blind_card.dart';
import 'package:dating_app/providers/blind_provider.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/filter_bottom_sheet1.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'matches_card.dart';

class BlindsCardList extends StatefulWidget {
  final bool onWeb;
  final double datesCardHeight;
  final double datesCardWidth;
  final double testWidth;

  BlindsCardList(
      {Key key,
      this.datesCardHeight,
      this.datesCardWidth,
      this.testWidth,
      this.onWeb = false})
      : super(key: key);

  @override
  _BlindsCardListState createState() => _BlindsCardListState();
}

class _BlindsCardListState extends State<BlindsCardList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BlindProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlindProvider>(builder: (context, data, child) {
      if (data.homeState == HomeState.Loading) {
        return Center(child: CircularProgressIndicator());
      } else if (data.homeState == HomeState.Loaded) {
        return data.blindData.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Lottie.asset('assets/lottie/sad_face.json')),
                    Text("oops!! there is \nNo Blind Dates",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    GradientButton(
                      margin: EdgeInsets.all(0),
                      height: MediaQuery.of(context).size.height / 20,
                      name: "Find me date",
                      gradient: MainTheme.loginBtnGradient,
                      active: true,
                      color: Colors.white,
                      width: ScreenUtil().setWidth(400),
                      fontWeight: FontWeight.bold,
                      borderRadius: BorderRadius.circular(5),
                      onPressed: () async {
                        _showOtpBottomSheet();
                      },
                    ),
                  ])
            : ListView.builder(
                itemCount: data.blindData.length,
                itemBuilder: (context, index) {
                  return BlindsCard(
                    onWeb: widget.onWeb,
                    height: widget.datesCardHeight,
                    width: widget.datesCardWidth,
                    testWidth: widget.testWidth,
                    data: data.blindData[index],
                  );
                },
              );
      }
    });
  }

  _showOtpBottomSheet() {
    showModalBottomSheet(
        context: context,
        // isScrollControlled: true,
        // isDismissible: false,
        // enableDrag: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (BuildContext context) {
          return Column(
              mainAxisSize: MainAxisSize.min, children: [FilterBottomSheet1()]);
        });
  }
}
