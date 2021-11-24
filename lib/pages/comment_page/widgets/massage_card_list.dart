import 'package:dating_app/pages/comment_page/widgets/massage_card.dart';
import 'package:dating_app/providers/chat_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/loadingLottie.dart';
import 'package:dating_app/shared/widgets/error_card.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class MassageCardList extends StatefulWidget {
  final double mCardWidth;
  final double mcardHeight;
  final bool onWeb;
  MassageCardList(
      {Key key, this.mCardWidth, this.mcardHeight, this.onWeb = false})
      : super(key: key);

  @override
  _MassageCardListState createState() => _MassageCardListState();
}

class _MassageCardListState extends State<MassageCardList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ChatProvider>().getGroupData("");
  }

  //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40.h,
            child: TextFormField(
              onChanged: (val) {
                context.read<ChatProvider>().getGroupData(val);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                    left: 15.0.w,
                  ),
                  child: Icon(
                    Icons.search,
                    color: Color(0xff8F96AD),
                    size: 60.sp,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                    left: 18.0.w, bottom: 12.0.h, top: 12.0.h, right: 2.0.w),
                hintText: "Search messages",
                hintStyle: TextStyle(
                    fontSize: 35.sp,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff666666)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: BorderSide(
                      color: Color(0xffEFEBEB),
                      width: 0,
                      style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: BorderSide(
                      color: Color(0xffEFEBEB),
                      width: 0,
                      style: BorderStyle.solid),
                ),
              ),
              enableInteractiveSelection: true,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Container(
            child: Consumer<ChatProvider>(
              builder: (context, data, child) {
                return data.chatState == ChatState.Error
                    ? ErrorCard(
                        text: data.errorText,
                        ontab: () {
                          context.read<ChatProvider>().getGroupData("");
                        },
                      )
                    : data.chatState == ChatState.Loaded
                        ? data.chatGroupData.length == 0
                            ? Container()
                            : ListView.builder(
                                itemBuilder: (context, index) => MassageCard(
                                    data: data.chatGroupData[index]),
                                itemCount: data.chatGroupData.length,
                              )
                        : LoadingLottie();
              },
            ),
          ),
        ),
      ],
    );
  }
}
