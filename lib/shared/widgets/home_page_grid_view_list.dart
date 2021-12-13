import 'package:dating_app/models/subscription_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/subscription.dart';
import 'package:dating_app/pages/home_page/widget/album_card.dart';
import 'package:dating_app/pages/home_page_grid_view_page/widgets/home_grid_view_card.dart';

import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/providers/subscription_provider.dart';

import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/widgets/bottmsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomePageGridViewList extends StatefulWidget {
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final int crossAxisCount;
  final UsersSuggestionModel usersData;
  final double childAspectRatio;
  HomePageGridViewList(
      {Key key,
      this.crossAxisSpacing,
      this.mainAxisSpacing,
      this.crossAxisCount,
      this.usersData,
      this.childAspectRatio})
      : super(key: key);

  @override
  _HomePageGridViewListState createState() => _HomePageGridViewListState();
}

class _HomePageGridViewListState extends State<HomePageGridViewList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, data, child) {
      return Consumer<SubscriptionProvider>(builder: (context, subdata, child) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: widget.crossAxisSpacing ?? 10,
                mainAxisSpacing: widget.mainAxisSpacing ?? 10,
                crossAxisCount: widget.crossAxisCount ?? 2,
                childAspectRatio: widget.childAspectRatio ?? 0.7),
            itemCount: widget.usersData.response.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () async {
                    if (subdata.plan == null) {
                      if (int.parse(subdata.count) >= data.userData.subCount) {
                        List<UserModel> data =
                            await Subscription().updateCount(1);
                        await context.read<HomeProvider>().replaceData(data[0]);
                        return Routes.sailor(Routes.detailPage, params: {
                          "userDetails": widget.usersData.response[index]
                        });
                      } else {
                        if (subdata.subscriptionData.length == 0) {
                          subdata.getdata();
                          return BottomSheetClass().showplans(context);
                        } else {
                          return BottomSheetClass().showplans(context);
                        }
                      }
                    }
                    if (subdata.plan != null) {
                      print("en plan varutha");
                      print(subdata.plan);
                      if (subdata.subscriptionData.length == 0) {
                        await subdata.getdata();
                      }
                      SubscriptionModel sdata = subdata.subscriptionData
                          .firstWhere((element) => element.id == subdata.plan);

                      if (sdata.checklists.any((element) =>
                          element.id != subdata.checklistData[6].id)) {
                        return BottomSheetClass().showplans(context);
                      }
                    }
                    Routes.sailor(Routes.detailPage, params: {
                      "userDetails": widget.usersData.response[index]
                    });
                  },
                  child: HomeGridViewcard(
                    userData: widget.usersData.response[index],
                  ));
            },
          ),
        );
      });
    });
  }
}
