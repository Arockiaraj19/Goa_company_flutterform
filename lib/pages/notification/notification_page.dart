import 'package:dating_app/networks/notification_network.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/notification_provider.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  List<String> deleteId = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<NotificationProvider>(
            builder: (ctx, data, child) {
              return data.notificationData.length == 0
                  ? Center(
                      child: noResult(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 1.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15.0.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (deleteId.length != 0)
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          deleteId = [];
                                        });
                                      },
                                      child: Text(
                                        "cancel",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 45.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  if (deleteId.length == 0)
                                    Text(
                                      "NotificationPage",
                                      style: TextStyle(
                                          color: Color(0xff1A1F36),
                                          fontSize: 45.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  if (deleteId.length == 0)
                                    Row(
                                      children: [
                                        Text(
                                          "Mark all as read",
                                          style: TextStyle(
                                              color: Color(0xff1A1F36),
                                              fontSize: 45.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                for (int i = 0;
                                                    i <
                                                        data.notificationData
                                                            .length;
                                                    i++) {
                                                  deleteId.add(data
                                                      .notificationData[i].id);
                                                }
                                              });
                                            },
                                            icon: Icon(
                                                Icons.check_circle_outlined))
                                      ],
                                    ),
                                  if (deleteId.length != 0)
                                    InkWell(
                                      onTap: () async {
                                        bool result =
                                            await NotificationNetwork()
                                                .deleteData(deleteId);
                                        if (result) {
                                          Navigator.pop(context);
                                          context
                                              .read<NotificationProvider>()
                                              .getData();
                                        }
                                      },
                                      child: Text(
                                        "remove",
                                        style: TextStyle(
                                            color: MainTheme.primaryColor,
                                            fontSize: 45.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: data.notificationData.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Dismissible(
                                        key: ObjectKey(
                                            data.notificationData[index].id),
                                        onDismissed: (direction) async {
                                          bool result =
                                              await NotificationNetwork()
                                                  .deleteData([
                                            data.notificationData[index].id
                                          ]);
                                        },
                                        child: Container(
                                          color: deleteId.contains(data
                                                  .notificationData[index].id)
                                              ? Colors.grey[200]
                                              : Colors.white,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.all(25.0.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 7,
                                                  width: 7,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      shape: BoxShape.circle),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Image.network(
                                                        data
                                                            .notificationData[
                                                                index]
                                                            .sender
                                                            .identificationImage,
                                                        height: 150.r,
                                                        width: 150.r,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    SizedBox(width: 30.w),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          RichText(
                                                            text: new TextSpan(
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff1A1F36),
                                                                  fontSize:
                                                                      45.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              children: <
                                                                  TextSpan>[
                                                                new TextSpan(
                                                                  text: data
                                                                          .notificationData[
                                                                              index]
                                                                          .sender
                                                                          .firstname +
                                                                      " " +
                                                                      data
                                                                          .notificationData[
                                                                              index]
                                                                          .sender
                                                                          .lastname,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff1A1F36),
                                                                      fontSize:
                                                                          48.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                new TextSpan(
                                                                  text:
                                                                      '  ${data.notificationData[index].content}  ',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff1A1F36),
                                                                      fontSize:
                                                                          45.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          Text(
                                                            DateFormat
                                                                    .yMMMMEEEEd()
                                                                .format(data
                                                                    .notificationData[
                                                                        index]
                                                                    .createdAt),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 40.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider()
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }))
                          ],
                        ),
                      ),
                    );
            },
          )),
    );
  }
}
