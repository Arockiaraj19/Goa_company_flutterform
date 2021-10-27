import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/shared/helpers/check_persentage.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ImageCard extends StatefulWidget {
  final Responses data;
  final String image;
  final String name;
  final double rating;
  final double cardHeight;
  final double cardWidth;
  final EdgeInsetsGeometry cardMargin;
  ImageCard(
      {Key key,
      this.data,
      this.cardHeight,
      this.cardWidth,
      this.cardMargin,
      this.image,
      this.name,
      this.rating})
      : super(key: key);

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height - (kToolbarHeight);
    var _width = MediaQuery.of(context).size.width - 30;
    return Container(
        // margin: EdgeInsetsDirectional.only(start: 5, end: 5),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.grey, blurRadius: 1.0)
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        // height: 300,
        // width: 300,
        height: widget.cardHeight ?? _height * 0.680,
        width: widget.cardWidth ?? _width * 0.300,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                Stack(alignment: AlignmentDirectional.bottomCenter, children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(Rect.fromLTRB(rect.width - 180,
                        rect.height - 180, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    useOldImageOnUrlChange: true,
                    placeholder: (context, url) => shimmerEffects(context),
                    errorWidget: (context, url, error) => Icon(
                      FontAwesomeIcons.earlybirds,
                      size: 100,
                      color: Colors.grey.shade300,
                    ),
                    imageUrl: widget.image ??
                        "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: 20, end: 20, top: 5, bottom: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            widget.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          )),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  '5 miles away',
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Consumer<HomeProvider>(builder: (context, data, child) {
                        return Container(
                          // height: 30,
                          child: FutureBuilder(
                            future: Persentage().checkSuggestionPresentage(
                                data.userData, widget.data),
                            builder: (BuildContext context,
                                AsyncSnapshot<double> snapshot) {
                              if (snapshot.hasData) {
                                return CircularPercentIndicator(
                                    linearGradient:
                                        MainTheme.backgroundGradient,
                                    animation: true,
                                    backgroundColor: Colors.grey[50],
                                    animationDuration: 1200,
                                    radius: 40.0,
                                    lineWidth: 8,
                                    percent: snapshot.data,
                                    center: Container(
                                        child: Text((snapshot.data * 100)
                                            .round()
                                            .toString())));
                              } else {
                                return CircularPercentIndicator(
                                    linearGradient:
                                        MainTheme.backgroundGradient,
                                    animation: true,
                                    backgroundColor: Colors.grey[50],
                                    animationDuration: 1200,
                                    radius: 40.0,
                                    lineWidth: 8,
                                    percent: 0,
                                    center: Container(child: Text('0')));
                              }
                            },
                          ),
                        );
                      })
                    ]),
                height: 66,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ])));
  }
}
