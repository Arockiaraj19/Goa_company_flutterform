import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/shared/helpers/check_persentage.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/animation_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeGridViewcard extends StatefulWidget {
  final bool onWeb;
  final double width;
  final Responses userData;
  HomeGridViewcard({Key key, this.onWeb = false, this.width, this.userData})
      : super(key: key);

  @override
  _HomeGridViewcardState createState() => _HomeGridViewcardState();
}

class _HomeGridViewcardState extends State<HomeGridViewcard> {
  Future<String> getdistance(location) async {
    print("location");

    double distanceInMeters = await Geolocator.distanceBetween(
        widget.userData.location.coordinates[0],
        widget.userData.location.coordinates[1],
        location.coordinates[0],
        location.coordinates[1]);
    print("location in miles");
    String miles = (distanceInMeters / 1609.34).round().toString();
    return miles;
  }

  @override
  Widget build(BuildContext context) {
    return widget.onWeb
        ? Container(
            child:
                // Stack(children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Container(
                      height: 200,
                      width: widget.width,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                        child: Image.network(
                          widget.userData.identificationImage ?? "",
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                      width: widget.width,
                      height: 66,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.3, color: Colors.grey.shade300),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 1.0,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                            // padding: EdgeInsets.all(5),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsetsDirectional.only(end: 5),
                                      child: Consumer<HomeProvider>(
                                        builder: (context, data, child) {
                                          return CircularPercentIndicator(
                                              linearGradient:
                                                  MainTheme.backgroundGradient,
                                              animation: true,
                                              backgroundColor: Colors.grey[50],
                                              animationDuration: 1200,
                                              radius: 30.0,
                                              lineWidth: 5,
                                              percent: 1,
                                              center: Container(
                                                child: FutureBuilder(
                                                  future: Persentage()
                                                      .checkSuggestionPresentage(
                                                          data.userData,
                                                          widget.userData),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        (snapshot.data * 100)
                                                            .round()
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      );
                                                    } else {
                                                      return Text(
                                                        '0',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ));
                                        },
                                      )),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(
                                        '${widget.userData.firstName ?? ""}, ${widget.userData.age.toString()}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      )),
                                      Row(
                                        children: [
                                          Consumer<HomeProvider>(
                                              builder: (context, data, child) {
                                            return Container(
                                              child: FutureBuilder(
                                                future: getdistance(
                                                    data.userData.location),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      '${snapshot.data} miles away',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    );
                                                  } else {
                                                    return Text(
                                                      '0 miles away',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    );
                                                  }
                                                },
                                              ),
                                            );
                                          }),
                                        ],
                                      )
                                    ],
                                  ),
                                ]),
                          )),
                        ],
                      )),
                  Container(
                      height: 70, width: widget.width, child: AnimationButton())
                ]),
            // Positioned(
            //     right: 10,
            //     top: 10,
            //     child: Icon(
            //       Icons.favorite_outline,
            //       color: Colors.white,
            //     )),
            // Positioned(
            //     right: 0,
            //     bottom: 0,
            //     child: Icon(
            //       Icons.verified_user_sharp,
            //       color: Colors.blue,
            //       size: 30,
            //     ))
            // ])
          )
        : Stack(children: [
            Container(
                child: FittedBox(
                    child: Column(children: [
              Stack(
                children: [
                  Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                        child: widget.userData.identificationImage == null
                            ? Icon(
                                FontAwesomeIcons.earlybirds,
                                size: 50,
                              )
                            : Image.network(
                                widget.userData.identificationImage,
                                fit: BoxFit.cover,
                              ),
                      )),
                  if (widget.userData.isVerified == true)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset("assets/images/isverified.png",
                          height: 35, width: 35 ),
                    ),
                ],
              ),
              Container(
                  width: 200,
                  height: 66,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey.shade300),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 1.0,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                        // padding: EdgeInsets.all(5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsetsDirectional.only(
                                    end: 5, start: 5),
                                child: Consumer<HomeProvider>(
                                  builder: (context, data, child) {
                                    return CircularPercentIndicator(
                                        linearGradient:
                                            MainTheme.backgroundGradient,
                                        animation: true,
                                        backgroundColor: Colors.grey[50],
                                        animationDuration: 1200,
                                        radius: 30.0,
                                        lineWidth: 5,
                                        percent: 0.5,
                                        center: Container(
                                          child: FutureBuilder(
                                            future: Persentage()
                                                .checkSuggestionPresentage(
                                                    data.userData,
                                                    widget.userData),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  (snapshot.data * 100)
                                                      .round()
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10),
                                                );
                                              } else {
                                                return Text(
                                                  '0',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10),
                                                );
                                              }
                                            },
                                          ),
                                        ));
                                  },
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    '${widget.userData.firstName ?? ""}, ${widget.userData.age.toString()}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )),
                                  Row(
                                    children: [
                                      Consumer<HomeProvider>(
                                          builder: (context, data, child) {
                                        return Container(
                                          child: FutureBuilder(
                                            future: getdistance(
                                                data.userData.location),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  '${snapshot.data} miles away',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                );
                                              } else {
                                                return Text(
                                                  '0 miles away',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                );
                                              }
                                            },
                                          ),
                                        );
                                      }),
                                    ],
                                  )
                                ],
                              ),
                            ]),
                      )),
                    ],
                  ))
            ]))),

            // Positioned(
            //     right: 10,
            //     top: 10,
            //     child: Icon(
            //       Icons.favorite_outline,
            //       color: Colors.white,
            //     )),
            // Positioned(
            //     right: 5,
            //     bottom: 60,
            //     child: Icon(
            //       Icons.verified_user_sharp,
            //       color: Colors.blue,
            //       size: 30,
            //     ))
          ]);
  }
}
