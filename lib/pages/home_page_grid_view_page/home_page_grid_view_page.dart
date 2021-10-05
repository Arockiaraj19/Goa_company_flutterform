import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/pages/home_page_grid_view_page/widgets/home_grid_view_card.dart';
import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/home_page_grid_view_list.dart';
import 'package:dating_app/shared/widgets/main_appbar.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePageGridViewPage extends StatefulWidget {
  final UsersSuggestionModel usersData;
  HomePageGridViewPage({Key key, this.usersData}) : super(key: key);

  @override
  _HomePageGridViewPageState createState() => _HomePageGridViewPageState();
}

class _HomePageGridViewPageState extends State<HomePageGridViewPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return _buildPhone();
      } else {
        return _buildWeb();
      }
    });
  }

  Widget _buildPhone() {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.grey.shade50,
          body: SingleChildScrollView(
              child: Column(children: [
            Container(
                margin: EdgeInsetsDirectional.only(top: 30),
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                height:
                    MediaQuery.of(context).size.height - (kToolbarHeight + 50),
                child: HomePageGridViewList(usersData: widget.usersData,)),
          ]))),
    );
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height - (kToolbarHeight);
    var _width = MediaQuery.of(context).size.width - 30;

    return Scaffold(
        body: BaseLayout(
            navigationRail: NavigationMenu(
              currentTabIndex: 0,
            ),
            body: Scaffold(
                appBar: AppBar(
                  backgroundColor: MainTheme.appBarColor,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  actions: [
                    Container(
                        margin: EdgeInsetsDirectional.only(
                          end: 20,
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications_outlined,
                              color: Colors.grey,
                              // size: 20,
                            )))
                  ],
                ),
                body: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(children: [
                      Container(
                          margin:
                              EdgeInsetsDirectional.only(top: 10, bottom: 10),
                          width: _width / 1.25,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discover",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ])),
                      Container(
                          margin: EdgeInsets.all(5),
                          width: _width,
                          height: MediaQuery.of(context).size.height -
                              (kToolbarHeight + 40),
                          child:

                              //  GridView.builder(
                              //   shrinkWrap: true,
                              //   gridDelegate:
                              //       SliverGridDelegateWithFixedCrossAxisCount(
                              //           crossAxisSpacing: 10,
                              //           mainAxisSpacing: 10,
                              //           crossAxisCount: 3,
                              //           childAspectRatio: 1.1),
                              //   itemCount: 8,
                              //   itemBuilder: (BuildContext context, int index) {
                              //     return HomeGridViewcard(
                              //       onWeb: true,
                              //       width: _width / 6,
                              //     );
                              //   },
                              // )

                              StaggeredGridView.countBuilder(
                            physics: ClampingScrollPhysics(),
                            crossAxisCount: 3,
                            itemCount: 8,
                            itemBuilder: (BuildContext context, int index) {
                              return HomeGridViewcard(
                                onWeb: true,
                                width: _width / 6,
                              );
                            },
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.fit(1),
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                          ))
                    ])))));
  }
}
