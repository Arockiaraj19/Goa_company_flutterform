import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/image_upload_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/image_upload_alert.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes.dart';
import 'widgets/album_image_card.dart';

class AddAlbumPicPage extends StatefulWidget {
  AddAlbumPicPage({Key key}) : super(key: key);

  @override
  _AddAlbumPicPageState createState() => _AddAlbumPicPageState();
}

class _AddAlbumPicPageState extends State<AddAlbumPicPage> {
  List<XFile> selectedUserAvatar = [null, null, null, null, null, null];
  List<String> uploadedImages = [];
  bool loading = false;
  // Uint8List  selectedUser = null;
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
    final ImagePicker picker = ImagePicker();
    var _textStyleforHeading = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    var _textForsubHeading = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w500,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    var _textForSmail = TextStyle(
        color: MainTheme.primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    var _textForHold = TextStyle(
        color: MainTheme.holdAndDrageTextColors,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondaryContentfontSize),
        fontFamily: "lato");

    return SafeArea(
        child: Scaffold(
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Container(
                  child: Text("Add your Profile Pic",
                      style: _textStyleforHeading)),
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 10, end: 10),
                    width: 200,
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
              Container(
                  margin: EdgeInsetsDirectional.only(
                      start: 60, end: 60, top: 20, bottom: 40),
                  child: Row(children: [
                    Expanded(
                        child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Flash that sleek ",
                          style: _textForsubHeading,
                          children: [
                            TextSpan(text: "smile ", style: _textForSmail

                                // TextStyle(
                                //     color: MainTheme.primaryColor,
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: ScreenUtil().setSp(45),
                                //     fontFamily: "Inter"),

                                ),
                            TextSpan(
                                text: "yours to decorate your profile",
                                style: _textForsubHeading)
                          ]),
                    )),
                  ])),
              Container(
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              "Hold and drag your photos to change the order",
                              style: _textForHold)),
                    ],
                  )),
              Container(
                  color: Colors.grey[200],
                  height: MediaQuery.of(context).size.height / 2.7,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 3,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return AlbumImageCard(
                        onTap: () async {
                          selectUserImage(index);
                        },
                        selectedUserAvatar: selectedUserAvatar[index],
                        onTapClose: () {
                          setState(() {
                            selectedUserAvatar[index] = null;
                          });
                        },
                      );
                    },
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  )),
              Container(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientButton(
                    height: 40,
                    name: loading ? "Loading.." : "Continue",
                    gradient: MainTheme.loginBtnGradient,
                    active: true,
                    isLoading: loading,
                    color: Colors.white,
                    width: ScreenUtil().setWidth(400),
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                      goToLookingForPagePage();
                    },
                  ),
                ],
              ),
            ]))));
  }

  goToLookingForPagePage() async {
    setState(() {
      loading = true;
    });
    var network = UploadImage();
    print("kl1");
    for (int i = 0; i < 6; i++) {
      if (selectedUserAvatar[i] != null) {
        print("kl2");

        Uint8List imageString =
            await File(selectedUserAvatar[i].path).readAsBytes();
        String result = await network.uploadImage(imageString);
        print("kl3");
        print(result);
        uploadedImages.add(result);
        print("kl");
      }
    }
    print("op");
    // var network1 = UserNetwork();
    // var userData = {"profile_image": uploadedImages};
    // UserModel result1 = await network1.patchUserData(userData);
    // Timer(Duration(seconds: 2), () => offLoading());
    // result1 != null ? onboardingCheck(result1) : null;
  }

  offLoading() {
    setState(() {
      loading = false;
    });
  }

  void selectUserImage(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ImageUploadAlert(
            onImagePicked: (XFile imageData) {
              setState(() {
                selectedUserAvatar[index] = imageData;
              });

              // if (imageData.status == 'success') {
              // _authStore.onAvatarSelected(imageData.image);
              // }
            },
          );
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
            child: Scaffold(
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
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Add your Profile Pic",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
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
                              width: _width / 3,
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
                            margin:
                                EdgeInsetsDirectional.only(top: 20, bottom: 40),
                            child: Row(children: [
                              Expanded(
                                  child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "Flash that sleek ",
                                    style: TextStyle(
                                        height: 2,
                                        color: MainTheme.leadingHeadings,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: "Inter"),
                                    children: [
                                      TextSpan(
                                        text: "smile ",
                                        style: TextStyle(
                                            color: MainTheme.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            fontFamily: "Inter"),
                                      ),
                                      TextSpan(
                                        text: "yours to decorate your profile",
                                        style: TextStyle(
                                            color: MainTheme.leadingHeadings,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            fontFamily: "Inter"),
                                      )
                                    ]),
                              )),
                            ])),
                        Container(
                            color: Colors.grey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Hold and drag your photos to change the order",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: MainTheme
                                                  .holdAndDrageTextColors,
                                              fontSize: 12,
                                              fontFamily: "Inter"),
                                        ))),
                              ],
                            )),
                        Container(
                            color: Colors.grey[200],
                            height: 250,
                            width: _width,
                            padding: EdgeInsets.all(10),
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 3,
                              itemCount: 6,
                              itemBuilder: (BuildContext context, int index) {
                                return AlbumImageCard(
                                    onTap: () async {
                                      selectUserImage(index);
                                    },
                                    selectedUserAvatar:
                                        selectedUserAvatar[index],
                                    onTapClose: () {
                                      setState(() {
                                        selectedUserAvatar[index] = null;
                                      });
                                    });
                              },
                              staggeredTileBuilder: (int index) =>
                                  StaggeredTile.fit(1),
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                            )),
                        Container(
                          height: _height / 8,
                          width: _width,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientButton(
                              name: loading ? "Loading.." : "Continue",
                              gradient: MainTheme.loginBtnGradient,
                              height: 35,
                              fontSize: 14,
                              width: _width / 6,
                              active: true,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              onPressed: () {
                                goToLookingForPagePage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ))))
      ]),
    ));
  }
}
