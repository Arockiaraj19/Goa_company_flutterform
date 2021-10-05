import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/animation_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeGridViewcard extends StatefulWidget {
  final bool onWeb;
  final double width;
  final Responses userData;
  HomeGridViewcard({Key key, this.onWeb = false, this.width, this.userData}) : super(key: key);

  @override
  _HomeGridViewcardState createState() => _HomeGridViewcardState();
}

class _HomeGridViewcardState extends State<HomeGridViewcard> {
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
                          widget.userData.profileImage.first??"",
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
                                      child: CircularPercentIndicator(
                                          linearGradient:
                                              MainTheme.backgroundGradient,
                                          animation: true,
                                          backgroundColor: Colors.grey[50],
                                          animationDuration: 1200,
                                          radius: 30.0,
                                          lineWidth: 5,
                                          percent: 1,
                                          center: Container(
                                              child: Text(
                                            '50',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          )))),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(
                                        '${widget.userData.firstName??""}, ${widget.userData.age.toString()}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      )),
                                      Row(
                                        children: [
                                          Container(
                                            child: Text(
                                              '5 miles away',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ),
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
                    child: widget.userData.profileImage.length==0? Icon(FontAwesomeIcons.earlybirds,size: 50,)
                        :Image.network(
                      widget.userData.profileImage.first,
                      fit: BoxFit.cover,
                    ),
                  )),
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
                                  child: CircularPercentIndicator(
                                      linearGradient:
                                          MainTheme.backgroundGradient,
                                      animation: true,
                                      backgroundColor: Colors.grey[50],
                                      animationDuration: 1200,
                                      radius: 30.0,
                                      lineWidth: 5,
                                      percent: 0.5,
                                      center: Container(
                                          child: Text(
                                        '50',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      )))),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    '${widget.userData.firstName??""}, ${widget.userData.age.toString()}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )),
                                  Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          '5 miles away',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ),
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
