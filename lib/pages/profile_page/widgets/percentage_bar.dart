import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentageBar extends StatefulWidget {
  final double percentage;
  final bool onEditProfilePage;
  final Function onTapClose;
  final Function onTap;
  final Color colors;
  final String image;
  final XFile selectedUserPic;

  PercentageBar(
      {Key key,
      this.percentage = 0.8,
      this.onEditProfilePage = false,
      this.onTapClose,
      this.colors,
      this.image,
      this.selectedUserPic,
      this.onTap})
      : super(key: key);

  @override
  _PercentageBarState createState() => _PercentageBarState();
}

class _PercentageBarState extends State<PercentageBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            child: CircularPercentIndicator(
          arcType: ArcType.FULL,
          backgroundColor: Colors.grey[50],
          animation: true,
          animationDuration: 1200,
          radius: 101.6,
          lineWidth: 7,
          percent: widget.percentage,
          center: CircularPercentIndicator(
            arcType: ArcType.FULL,
            backgroundColor: Colors.grey[50],
            animation: true,
            animationDuration: 1200,
            radius: 100.0,
            lineWidth: 7,
            percent: widget.percentage,
            center: CircularPercentIndicator(
              arcType: ArcType.FULL,
              animation: true,
              backgroundColor: Colors.grey[50],
              animationDuration: 1200,
              radius: 90.0,
              lineWidth: 5,
              percent: widget.percentage,
              center: widget.onEditProfilePage == true? Container(
                  child: InkWell(
                      onTap: () {
                        widget.onTap();
                      },
                      child: SizedBox(height: 80,width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:widget.selectedUserPic!=null? Image.file(File(widget.selectedUserPic.path),
                            fit: BoxFit.cover,)
                            :imageViewer(widget.image),
                        ),
                      ))):SizedBox(height: 80,width: 80,child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: imageViewer(widget.image),
              ),),
              linearGradient: MainTheme.loginBtnGradient,
            ),
            linearGradient: MainTheme.firstPercentBarColor,
          ),
          linearGradient: MainTheme.loginBtnGradient,
        ))
      ]),
      widget.onEditProfilePage == true
          ? Positioned(
              top: 40,
              right: 125,
              child: Center(
                  child: InkWell(
                      onTap: () {
                        widget.onTapClose();
                      },
                      child: CircleAvatar(
                          backgroundColor: widget.colors ?? Colors.grey[200],
                          radius: 13,
                          child: Icon(
                            FontAwesomeIcons.timesCircle,
                            size: 13,
                            color: Colors.red,
                          )))))
          : Container()
    ]);
  }
  
}
