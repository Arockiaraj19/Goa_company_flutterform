import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/shared/helpers/check_persentage.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PercentageMatchingBox extends StatefulWidget {
  final double height;
  final double width;
  final bool onWeb;
  final Responses userSuggestionData;
  PercentageMatchingBox(
      {Key key,
      this.height,
      this.width,
      this.onWeb = false,
      this.userSuggestionData})
      : super(key: key);

  @override
  _PercentageMatchingBoxState createState() => _PercentageMatchingBoxState();
}

class _PercentageMatchingBoxState extends State<PercentageMatchingBox> {
  @override
  Widget build(BuildContext context) {
    return widget.onWeb
        ? Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    gradient: MainTheme.detailPageCard,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.grey, blurRadius: 1.0)
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsetsDirectional.only(
                    start: 40,
                  ),
                  margin: EdgeInsetsDirectional.only(top: 20),
                  height:
                      widget.height ?? MediaQuery.of(context).size.height / 7,
                  width: widget.width ?? MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          "You and Adrianne have",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: "Nunito"),
                        )),
                        Container(
                          child: Text(
                            "85% of matching",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: "Nunito"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 5),
                          child: Text(
                            'Show me',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontFamily: "Nunito"),
                          ),
                          // Icon(
                          //   Icons.keyboard_arrow_right,
                          //   color: Colors.white70,
                          //   size: 10,
                          // ),
                        )
                      ])),
              Positioned(
                  top: -20,
                  right: 40,
                  child: Container(
                      height: 100,
                      width: 50,
                      child: Image.asset(
                        "assets/images/boy_walk.png",
                        fit: BoxFit.cover,
                      )))
            ],
          )
        : Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    gradient: MainTheme.detailPageCard,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.grey, blurRadius: 1.0)
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsetsDirectional.only(top: 20, bottom: 20),
                  height:
                      widget.height ?? MediaQuery.of(context).size.height / 7,
                  width: widget.width ?? MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Consumer<HomeProvider>(
                                  builder: (context, data, child) {
                                    return Container(
                                      child: FutureBuilder(
                                        future: Persentage()
                                            .checkSuggestionPresentage(
                                                data.userData,
                                                widget.userSuggestionData),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              "You and ${widget.userSuggestionData.firstName} have ${(snapshot.data * 100).round().toString()}% of matching",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: "Nunito"),
                                            );
                                          } else {
                                            return Text(
                                              "You and ${widget.userSuggestionData.firstName} have 0% of matching",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: "Nunito"),
                                            );
                                          }
                                        },
                                      ),
                                    );
                                  },
                                )),
                            Container(
                              color: Colors.transparent,
                              height: 50,
                              width: 50,
                            )
                          ],
                        )),
                        Row(
                          children: [
                            Text(
                              'Show me',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontFamily: "Nunito"),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white70,
                              size: 10,
                            ),
                          ],
                        )
                      ])),
              Positioned(
                  top: -20,
                  right: 5,
                  child: Container(
                      height: 100,
                      width: 50,
                      child: Image.asset(
                        "assets/images/boy_walk.png",
                        fit: BoxFit.cover,
                      )))
            ],
          );
  }
}
