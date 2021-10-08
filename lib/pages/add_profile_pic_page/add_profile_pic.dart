import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/image_upload_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/image_upload_alert.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddProfilePic extends StatefulWidget {
  const AddProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _AddProfilePicState createState() => _AddProfilePicState();
}

class _AddProfilePicState extends State<AddProfilePic> {
  XFile selectedUserAvatar;
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
            onImagePicked: (XFile imageData) {
              setState(() {
                selectedUserAvatar = imageData;
              });
              showPopup();
            },
          );
        });
  }

  void showPopup() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
      builder: (context1) => Container(
        padding: EdgeInsets.all(25),
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      goToAlbumPage(selectedUserAvatar);
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: MainTheme.primaryColor)),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    List<int> imageBytes = File(image.path).readAsBytesSync();

// convert that list to a string & encode the as base64 files
    String imageString = base64Encode(imageBytes);
    setState(() {
      loading = true;
    });
    var network = UploadImage();
    var network1 = UserNetwork();
    Timer(Duration(seconds: 6), () => offLoading());
    // // String result = await network.uploadImage(imageString, 2);
    // var userData = {"identification_image": result};
    // UserModel result1 = await network1.patchUserData(userData);
    // result1 != null ? onboardingCheck(result1) : null;
  }

  offLoading() {
    setState(() {
      loading = false;
    });
  }
}
