import 'package:dating_app/pages/chatting_page/chatting_page.dart';

import 'package:dating_app/pages/comment_page/widgets/dates_card_list.dart';

import 'package:dating_app/pages/comment_page/widgets/massage_card_list.dart';

import 'package:dating_app/pages/comment_page/widgets/request_card_list.dart';
import 'package:dating_app/pages/expert_ChatGroup/expertGroupList.dart';
import 'package:dating_app/providers/expertChat_provider.dart';

import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/alert_widget.dart';
import 'package:dating_app/shared/widgets/bottom_bar.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class ExpertGroup extends StatefulWidget {
  ExpertGroup({Key key}) : super(key: key);

  @override
  _ExpertGroupState createState() => _ExpertGroupState();
}

class _ExpertGroupState extends State<ExpertGroup>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    if (context.read<ExpertChatProvider>().chatGroupCato != null) {
      _tabController = TabController(
          length: context.read<ExpertChatProvider>().chatGroupCato.length,
          vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return _buildPhone();
    });
  }

  Widget _buildPhone() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MainTheme.appBarColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Choose the Experts",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 50.sp,
                fontFamily: "Nunito"),
          ),
          actions: [],
        ),
        body: Consumer<ExpertChatProvider>(builder: (context, data, child) {
          return Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                // indicatorPadding:
                //     const EdgeInsets.only(left: 25, right: 25, top: 10),
                labelColor: MainTheme.primaryColor,
                unselectedLabelColor: Colors.black,
                labelStyle:
                    TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 14),
                indicatorWeight: 3,
                tabs: <Widget>[
                  for (var i in data.chatGroupCato)
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        i.title,
                        style: TextStyle(
                          fontSize: 45.sp,
                        ),
                      ),
                    ),
                ],
              ),
              Divider(),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      for (var i in data.chatGroupCato)
                        Container(child: ExpertGroupList(groupdata: i)),
                    ]),
              ),
            ],
          );
        }),
      ),
    );
  }
}
