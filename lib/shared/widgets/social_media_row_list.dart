import 'package:dating_app/pages/profile_page/widgets/social_media_box.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialMediaRowList extends StatefulWidget {
  SocialMediaRowList({Key key}) : super(key: key);

  @override
  _SocialMediaRowListState createState() => _SocialMediaRowListState();
}

class _SocialMediaRowListState extends State<SocialMediaRowList> {
  @override
  Widget build(BuildContext context) {
    var socialMediaText = TextStyle(
        color: MainTheme.socialMediaText,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondaryContentfontSize),
        fontFamily: "lato");

    var socialMediaTextBold = TextStyle(
        color: MainTheme.socialMediaTextBold,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondaryContentfontSize),
        fontFamily: "lato");

    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      SocialMediaBox(
        name: "Add Instagram",
        image: "assets/images/Instagram_icon.png",
        style: socialMediaText,
      ),
      SocialMediaBox(
        name: "andrina_rico",
        image: "assets/images/Facebook_icon.png",
        style: socialMediaTextBold,
      ),
      SocialMediaBox(
        name: "Add Linkedin",
        image: "assets/images/LinkedIn_icons.png",
        style: socialMediaText,
      ),
    ]);
  }
}
