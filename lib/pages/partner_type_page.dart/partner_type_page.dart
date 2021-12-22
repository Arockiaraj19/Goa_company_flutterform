import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/image_upload_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/pages/create_profile_page/widget/gender_card.dart';
import 'package:dating_app/shared/helpers/websize.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/upload_verficationImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PartnerTypePage extends StatefulWidget {
  final UserModel userData;
  PartnerTypePage({Key key, this.userData}) : super(key: key);

  @override
  _PartnerTypePageState createState() => _PartnerTypePageState();
}

class _PartnerTypePageState extends State<PartnerTypePage> {
  bool loading = false;
  int selectedMenuIndex = 0;

  List<Map<String, dynamic>> itemGender = [
    {
      "gender": "Ectomorph",
      "image": "assets/images/man1.png",
      'isActive': true,
    },
    {
      "gender": "Mesomorph",
      "image": "assets/images/man2.png",
      'isActive': false,
    },
    {
      "gender": "Endomorph",
      "image": "assets/images/man3.png",
      'isActive': false,
    }
  ];
  @override
  void initState() {
    super.initState();
    print(widget.userData.verificationImage);
    print("partner type enna varuthu");
    print(widget.userData.partnerType);
    if (widget.userData.verificationImage == null &&
        widget.userData.partnerType != null) {
      print("init state kku partner type varuthaaa");
      Future.delayed(Duration(milliseconds: 800), () {
        selectUserImage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 769) {
        return _buildPhone(false);
      } else {
        return _buildWeb();
      }
    });
  }

  Widget _buildPhone(onWeb) {
    var _textStyleforHeading = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w600,
        fontSize: onWeb
            ? 18
            : ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    var _textStyleforLookingFor = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w500,
        fontSize: onWeb
            ? 16
            : ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    return Scaffold(
        bottomSheet: Container(
          height: 100,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                  height: onWeb ? 35 : 110.w,
                  fontSize: onWeb ? inputFont : 40.sp,
                  width: onWeb ? 130 : 500.w,
                  name: loading ? "Saving.." : "Continue",
                  gradient: MainTheme.loginBtnGradient,
                  active: true,
                  isLoading: loading,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(onWeb ? 5 : 20.sp),
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    Future.delayed(Duration(milliseconds: 500), () {
                      selectUserImage();
                    });
                  }),
            ],
          ),
        ),
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 25,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Container(
              child: Text("Looking for", style: _textStyleforHeading)),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Row(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(start: 10, end: 10),
                width: 250,
                color: MainTheme.primaryColor,
                height: 2,
              ),
            ],
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 10, end: 10),
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300,
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsetsDirectional.only(top: 40, bottom: 30),
                  child: Text("Who are you looking for?",
                      style: _textStyleforLookingFor)),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(0)),
          Container(
              width: MediaQuery.of(context).size.width * 0.588,
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemGender.length,
                  itemBuilder: (BuildContext context, int index) {
                    dynamic item = itemGender[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: onWeb
                                ? MediaQuery.of(context).size.width / 4
                                : null,
                            child: PartnerCard(
                              name: item["gender"],
                              image: item["image"],
                              isActive: widget.userData.partnerType == null
                                  ? item["isActive"]
                                  : widget.userData.partnerType ==
                                          item["gender"]
                                      ? true
                                      : false,
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    selectedMenuIndex = index;
                                    itemGender = itemGender
                                        .map<Map<String, dynamic>>(
                                            (Map<String, dynamic> item) {
                                      item['isActive'] = false;
                                      return item;
                                    }).toList();
                                    itemGender[index]['isActive'] = true;
                                  });
                                }
                              },
                            )),
                      ],
                    );
                  })),
        ])));
  }

  goToParterTypePage() async {
    setState(() {
      loading = true;
    });

    try {
      var network = UserNetwork();
      var network1 = UploadImage();
      var userData;
      if (selectedUserAvatar == null) {
        userData = {
          "partner_type": widget.userData.partnerType != null
              ? widget.userData.partnerType
              : itemGender[selectedMenuIndex]["gender"]
        };
      } else {
        String result = await network1.uploadImage(
            selectedUserAvatar.path, "verification_image");
        userData = {
          "partner_type": widget.userData.partnerType != null
              ? widget.userData.partnerType
              : itemGender[selectedMenuIndex]["gender"],
          "verification_image": result
        };
      }

      UserModel result = await network.patchUserData(userData);
      NavigateFunction().withquery(Navigate.subscription + "?onboard=true");
    } catch (e) {
      offLoading();
    }
  }

  goToParterTypePageWeb() async {
    setState(() {
      loading = true;
    });

    try {
      var network = UserNetwork();
      var network1 = UploadImageWeb();
      var userData;
      if (selectedWebAvatar == null) {
        userData = {
          "partner_type": widget.userData.partnerType != null
              ? widget.userData.partnerType
              : itemGender[selectedMenuIndex]["gender"]
        };
      } else {
        String result =
            await network1.uploadImage(selectedWebAvatar, "verification_image");
        userData = {
          "partner_type": widget.userData.partnerType != null
              ? widget.userData.partnerType
              : itemGender[selectedMenuIndex]["gender"],
          "verification_image": result
        };
      }

      UserModel result = await network.patchUserData(userData);
      NavigateFunction().withquery(Navigate.subscription + "?onboard=true");
    } catch (e) {
      offLoading();
    }
  }

  XFile selectedUserAvatar;
  Uint8List selectedWebAvatar;
  void selectUserImage() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return VerificationUploadAlert(
            onImagePicked: !kIsWeb
                ? (XFile imageData) {
                    setState(() {
                      selectedUserAvatar = imageData;
                    });
                    showPopup();
                  }
                : (Uint8List imageData) {
                    setState(() {
                      selectedWebAvatar = imageData;
                      print("bytes inga varuthaa");
                    });
                    showPopup();
                  },
            skipImage: () {
              Navigator.pop(context);

              goToParterTypePage();
            },
          );
        });
  }

  bool loading1 = false;

  void showPopup() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
      builder: (context1) => StatefulBuilder(
        builder: (BuildContext context, setSState) {
          return Container(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: double.infinity,
                    height: 300.h,
                    child: kIsWeb
                        ? Image.memory(selectedWebAvatar)
                        : Image.file(File(selectedUserAvatar.path))),
                SizedBox(
                  height: 5.h,
                ),
                loading1
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GestureDetector(
                        onTap: () {
                          setSState(() {
                            loading1 = !loading1;
                          });
                          if (kIsWeb) {
                            goToParterTypePageWeb();
                          } else {
                            goToParterTypePage();
                          }
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: MainTheme.primaryColor)),
                          alignment: Alignment.center,
                          child: Text(
                            "Selfi is readable",
                            style: TextStyle(
                                color: MainTheme.primaryColor,
                                fontSize: 18,
                                fontFamily: "Nunito"),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    selectUserImage();
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: MainTheme.primaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: MainTheme.primaryColor,
                        ),
                        Text(
                          "Take a new picture",
                          style: TextStyle(
                              color: MainTheme.primaryColor,
                              fontSize: 18,
                              fontFamily: "Nunito"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  offLoading() {
    setState(() {
      loading = false;
    });
  }

  Widget _buildWeb() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width / 2;

    var _textStyleforSpark = TextStyle(
        color: MainTheme.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 28,
        fontFamily: "lato");

    var _textStyleforAlreadyHave =
        TextStyle(color: Colors.black, fontSize: 14, fontFamily: "lato");

    var _textStyleforLogin = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 14,
        fontFamily: "lato");

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Row(children: [
        Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/web_login_image.png",
                  ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsetsDirectional.only(
                    top: 30,
                    start: 30,
                  ),
                  child: Text("Spark", style: _textStyleforSpark)),
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[100],
                  blurRadius: 1.0,
                  offset: Offset(0, 5),
                )
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.zero,
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.zero,
              ),
            ),
            height: _height,
            width: _width,
            padding: EdgeInsetsDirectional.only(
              end: _width / 30,
              start: _width / 30,
            ),
            child: _buildPhone(true))
      ]),
    ));
  }

  Scaffold webpart(double _width, double _height) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: ScreenUtil().setWidth(20),
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsetsDirectional.only(
              end: _width / 6,
              start: _width / 6,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Looking for",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: MainTheme.leadingHeadings,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "Inter"),
                    )),
                  ],
                ),
                Container(
                  height: _height / 45,
                  width: _width,
                ),
                Row(
                  children: [
                    Container(
                      width: _width / 2,
                      color: MainTheme.primaryColor,
                      height: 2,
                    ),
                  ],
                ),
                Container(
                  width: _width,
                  color: Colors.grey.shade300,
                  height: 1,
                ),
                Container(
                  height: _height / 18,
                  width: _width,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      "Who are you looking for?",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: MainTheme.leadingHeadings,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: "Inter"),
                    )),
                  ],
                ),
                Container(
                  height: _height / 15,
                  width: _width,
                ),
                Container(
                  width: _width / 2.5,
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: itemGender.length,
                      itemBuilder: (BuildContext context, int index) {
                        dynamic item = itemGender[index];
                        return Container(
                            height: 80,
                            width: 60,
                            child: GenderCard(
                              name: item["gender"],
                              image: item["image"],
                              isActive: item["isActive"],
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    selectedMenuIndex = index;
                                    itemGender = itemGender
                                        .map<Map<String, dynamic>>(
                                            (Map<String, dynamic> item) {
                                      item['isActive'] = false;
                                      return item;
                                    }).toList();
                                    itemGender[index]['isActive'] = true;
                                  });
                                }
                              },
                            ));
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientButton(
                      name: loading ? "Saving.." : "Continue",
                      gradient: MainTheme.loginBtnGradient,
                      height: 35,
                      fontSize: 14,
                      isLoading: loading,
                      width: _width / 6,
                      active: true,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      onPressed: () {
                        goToParterTypePage();
                      },
                    ),
                  ],
                ),
              ],
            )));
  }
}
