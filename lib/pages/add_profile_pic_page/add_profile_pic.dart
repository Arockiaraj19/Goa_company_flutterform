import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/image_upload_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/image_upload_alert.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddProfilePic extends StatefulWidget {
  const AddProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _AddProfilePicState createState() => _AddProfilePicState();
}

class _AddProfilePicState extends State<AddProfilePic> {
  XFile selectedUserAvatar;
  Uint8List selectedWebAvatar;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 500), () => selectUserImage());
  }

  void selectUserImage() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ImageUploadAlert(
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
                    });
        });
  }

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
                loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GestureDetector(
                        onTap: () {
                          setSState(() {
                            loading = !loading;
                          });
                          if (kIsWeb) {
                            goToAlbumPageWeb(selectedWebAvatar);
                          } else {
                            goToAlbumPage(selectedUserAvatar);
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
                      mainAxisAlignment: MainAxisAlignment.center,
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

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Scaffold(
            body: selectedWebAvatar != null
                ? Center(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 2,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: selectedWebAvatar != null
                                ? Image.memory(
                                    selectedWebAvatar,
                                  )
                                : Image.asset(
                                    "assets/images/Add_image.png",
                                    fit: BoxFit.fill,
                                  ))),
                  )
                : Container())
        : Scaffold(
            body: selectedUserAvatar != null
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: selectedUserAvatar != null
                            ? Platform.isAndroid
                                ? Image.file(
                                    File(selectedUserAvatar.path),
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    selectedUserAvatar.path,
                                    fit: BoxFit.fill,
                                  )
                            : Image.asset(
                                "assets/images/Add_image.png",
                                fit: BoxFit.fill,
                              )))
                : Container());
  }

  goToAlbumPage(XFile image) async {
    var network = UploadImage();
    var network1 = UserNetwork();

    try {
      String result = await network.uploadImage(image.path, "identification");
      var userData = {"identification_image": result};
      UserModel result1 = await network1.patchUserData(userData);
      result1 != null ? onboardingCheck(result1) : null;
    } catch (e) {
      offLoading();
    }
  }

  goToAlbumPageWeb(Uint8List image) async {
    var network = UploadImageWeb();
    var network1 = UserNetwork();

    try {
      String result = await network.uploadImage(image, "identification");
      var userData = {"identification_image": result};
      UserModel result1 = await network1.patchUserData(userData);
      result1 != null ? onboardingCheck(result1) : null;
    } catch (e) {
      offLoading();
    }
  }

  offLoading() {
    setState(() {
      loading = false;
    });
  }
}

class Unit8List {}
