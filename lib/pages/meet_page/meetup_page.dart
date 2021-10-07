import 'package:dating_app/pages/meet_page/gift_tab.dart';
import 'package:dating_app/pages/meet_page/meetup_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeetupPage extends StatefulWidget {
  @override
  _MeetupPageState createState() => _MeetupPageState();
}

class _MeetupPageState extends State<MeetupPage> {
  List<Tab> statusTitleList = [
    Tab(
      child: Row(
        children: [Text(("Restaurants"))],
      ),
    ),
    Tab(
      child: Row(
        children: [Text(("Cabs"))],
      ),
    ),
    Tab(
      child: Row(
        children: [Text(("Movie"))],
      ),
    ),
    Tab(
      child: Row(
        children: [Text(("Gifts"))],
      ),
    ),
    Tab(
      child: Row(
        children: [Text(("Rentals"))],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    TextStyle _styleselected = TextStyle(
        fontSize: 40.sp, fontWeight: FontWeight.w700, color: Colors.pink);
    TextStyle _styleBody3 = TextStyle(
        fontSize: 40.sp, fontWeight: FontWeight.w400, color: Colors.pink);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Choose Place to Meet",
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w300, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                size: 28,
                color: Colors.black,
              )),
        ],
      ),
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(30.h),
            child: new Container(
              alignment: AlignmentDirectional.center,
              child: new SafeArea(
                child: new TabBar(
                    labelStyle: _styleselected,
                    isScrollable: true,
                    indicatorColor: Colors.pink,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.pink,
                    labelPadding:
                        EdgeInsets.only(bottom: 2.h, right: 35.w, left: 35.w),
                    unselectedLabelStyle: _styleBody3,
                    tabs: statusTitleList),
              ),
            ),
          ),
          body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
            MeetupList(),
            Gifttab(),
            MeetupList(),
            MeetupList(),
            MeetupList(),
          ]),
        ),
      ),
    );
  }
}
