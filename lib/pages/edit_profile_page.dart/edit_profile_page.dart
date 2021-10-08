import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dating_app/models/hobby.dart';
import 'package:dating_app/models/interest.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/image_upload_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/pages/create_profile_page/widget/gender_card.dart';
import 'package:dating_app/pages/home_page/widget/interest_box.dart';
import 'package:dating_app/pages/profile_page/widgets/percentage_bar.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/shared/date_picker_input.dart';
import 'package:dating_app/shared/helpers.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/image_upload_alert.dart';
import 'package:dating_app/shared/widgets/input_field.dart';
import 'package:dating_app/shared/widgets/social_media_row_list.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel userdata;
  EditProfilePage({Key key, this.userdata}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameCtrl = TextEditingController();
  TextEditingController _lastNameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _bioCtrl = TextEditingController();
  TextEditingController _phoneNumberCtrl = TextEditingController();
  TextEditingController _dobInputCtrl = TextEditingController();
  TextEditingController _heightCtrl = TextEditingController();
  TextEditingController _weightCtrl = TextEditingController();

  DateTime selectedDate;
  int selectedMenuIndex = 0;
  Future<List<InterestModel>> interestData;
  Future<List<HobbyModel>> hobbyData;
  List<InterestModel> interestData1;
  List<HobbyModel> hobbyData1;
  List<String> interestSelected = [];
  List<String> hobbieSelected = [];
  List<dynamic> interestSelected1 = [];
  List<dynamic> hobbieSelected1 = [];
  List<bool> interestBool = [];
  List<bool> hobbieBool = [];
  bool loading = false;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController1 = TextEditingController();

  addInterestBool(int count) {
    for (int i = 0; i < count; i++) {
      interestBool.add(false);
    }
  }

  addHobbyBool(int count) {
    for (int i = 0; i < count; i++) {
      hobbieBool.add(false);
    }
  }

  String dropdownProfessionValue = null;

  List<String> itemdate = [
    "Accountant",
    "Architect",
    "Astronomer",
    "Author",
    "Dentist"
  ];

  List<Map<String, dynamic>> itemGender = [
    {
      "gender": "Male",
      "image": "assets/icons/male.png",
      'isActive': true,
    },
    {
      "gender": "Female",
      "image": "assets/icons/female.png",
      'isActive': false,
    },
    {
      "gender": "other",
      "image": "null",
      'isActive': false,
    }
  ];

  XFile selectedUserAvatar = null;

  XFile selectedUserPic = null;

  fill() async {
    _firstNameCtrl.text = widget.userdata.firstName;
    _lastNameCtrl.text = widget.userdata.lastName;
    // selectedDate=widget.userdata.dob;
    _bioCtrl.text = widget.userdata.bio ?? "";
    _heightCtrl.text =
        widget.userdata.height == null ? "" : widget.userdata.height.toString();
    _weightCtrl.text =
        widget.userdata.weight == null ? "" : widget.userdata.weight.toString();
    dropdownProfessionValue = widget.userdata.profession.first;
    selectedMenuIndex = widget.userdata.gender;
    selectedDate = DateTime.parse(widget.userdata.dob);
    _dobInputCtrl.value =
        TextEditingValue(text: DateFormat.yMMMd().format(selectedDate));
  }

  fillHobbies() {
    for (int i = 0; i < hobbyData1.length; i++) {
      if (widget.userdata.hobbies.contains(hobbyData1[i].id)) {
        hobbieBool[i] = true;
        hobbieSelected.add(hobbyData1[i].id);
        var val = {"hobby_id": hobbyData1[i].id, "title": hobbyData1[i].title};
        hobbieSelected1.add(val);
      }
    }
  }

  fillInterests() {
    for (int i = 0; i < interestData1.length; i++) {
      if (widget.userdata.interests.contains(interestData1[i].id)) {
        interestBool[i] = true;
        interestSelected.add(interestData1[i].id);
        var val = {
          "interest_id": interestData1[i].id,
          "title": interestData1[i].title
        };
        interestSelected1.add(val);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fill();
    if (interestData == null) {
      interestData = UserNetwork().getUserInterests();
      hobbyData = UserNetwork().getUserHobbies();
    }
    textEditingController.addListener(() {
      if (textEditingController.text != null) {
        fillHobbies();
      }
    });
    textEditingController1.addListener(() {
      if (textEditingController1.text != null) {
        fillInterests();
      }
    });
  }

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
    var _leadingHeading = TextStyle(
        color: MainTheme.mainHeadingColors,
        fontWeight: FontWeight.w500,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    var _textStyleforName = TextStyle(
        color: MainTheme.profileNameColors,
        fontWeight: FontWeight.w700,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    var _textStyleforHeading = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");
    var _textForsubHeading = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    var profileValue = TextStyle(
        color: MainTheme.profileValue,
        fontWeight: FontWeight.w700,
        fontSize: ScreenUtil().setSp(43),
        fontFamily: "lato");

    var profileScoreName = TextStyle(
        color: MainTheme.profileValue,
        fontWeight: FontWeight.w500,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
        fontFamily: "lato");

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

    var tabFont = TextStyle(
        color: MainTheme.socialMediaTextBold,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    var tabFontDesable = TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    var subHeading = TextStyle(
        color: MainTheme.socialMediaTextBold,
        fontWeight: FontWeight.w500,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 10,
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black,
                      size: 25,
                    ),
                  ))),
          titleSpacing: 0,
          centerTitle: true,
          title: Text(
            "Edit Profile Details",
            style: _leadingHeading,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PercentageBar(
                percentage: 0.7,
                onEditProfilePage: true,
                onTap: () {
                  selectUserPic();
                },
                image: widget.userdata.profileImage.first,
                selectedUserPic: selectedUserPic,
                onTapClose: () {
                  setState(() {
                    selectedUserPic = null;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(top: 5),
                    child: Text(
                      "Adrianne Rico, 22",
                      style: _textStyleforName,
                    ),
                  ),
                ],
              ),
              SocialMediaRowList(),
              Container(
                  padding:
                      EdgeInsetsDirectional.only(start: 10, end: 10, top: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputField(
                          onTap: () {},
                          controller: _firstNameCtrl,
                          padding: EdgeInsets.all(10),
                          validators: (String value) {
                            if (value.isEmpty) return 'Required field';
                            return null;
                          },
                          hintText: 'Your first name',
                        ),
                        InputField(
                          onTap: () {},
                          controller: _lastNameCtrl,
                          padding: EdgeInsets.all(10),
                          validators: (String value) {
                            if (value.isEmpty) return 'Required field';
                            return null;
                          },
                          hintText: 'Your last name',
                        ),
                        // InputField(
                        //   onTap: () {},
                        //   controller: _emailCtrl,
                        //   padding: EdgeInsets.all(10),
                        //   validators: (String value) {
                        //     if (value.isEmpty) return 'Required field';
                        //     return null;
                        //   },
                        //   hintText: 'Email',
                        // ),
                        InputField(
                          onTap: () {},
                          controller: _bioCtrl,
                          maxLines: 3,
                          padding: EdgeInsets.all(10),
                          validators: (String value) {
                            if (value.isEmpty) return 'Required field';
                            return null;
                          },
                          hintText: 'Bio',
                        ),
                        DatePickerInput(
                          hintText: 'DD-MM-YYYY',
                          controller: _dobInputCtrl,
                          onSelect: (DateTime date) {
                            removeFocus(context);
                            setState(() {
                              selectedDate = date;
                            });
                          },
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            padding:
                                EdgeInsetsDirectional.only(start: 10, end: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 1.0,
                                  offset: Offset(0, 3),
                                )
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButton<dynamic>(
                              isExpanded: true,
                              value: dropdownProfessionValue,
                              hint: Text("Profession"),
                              icon: Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: TextStyle(color: Colors.black),
                              underline: Container(),
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownProfessionValue = newValue;
                                });
                              },
                              items: itemdate.map<DropdownMenuItem<dynamic>>(
                                  (dynamic value) {
                                return DropdownMenuItem<dynamic>(
                                  value: value,
                                  child: Text(value
                                      // style: TextStyle(fontSize: 28.sp),
                                      ),
                                );
                              }).toList(),
                            )),
                        InputField(
                          onTap: () {},
                          controller: _heightCtrl,
                          padding: EdgeInsets.all(10),
                          validators: (String value) {
                            if (value.isEmpty) return 'Required field';
                            return null;
                          },
                          hintText: 'Height',
                        ),
                        InputField(
                          onTap: () {},
                          controller: _weightCtrl,
                          padding: EdgeInsets.all(10),
                          validators: (String value) {
                            if (value.isEmpty) return 'Required field';
                            return null;
                          },
                          hintText: 'Weight',
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 10, top: 5, bottom: 5),
                                child: Text(
                                  "Gender",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(45),
                                      fontFamily: "Inter"),
                                )),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemGender.length,
                              itemBuilder: (BuildContext context, int index) {
                                dynamic item = itemGender[index];
                                return GenderCard(
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
                                    print(
                                        'pppppppppppppppppppppppppppppppppppp${item["gender"]}');
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  )),
              Row(
                children: [
                  Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 30, top: 5, bottom: 20),
                      child: Text("Interest", style: _textForsubHeading)),
                ],
              ),
              FutureBuilder(
                  future: interestData,
                  builder:
                      (context, AsyncSnapshot<List<InterestModel>> snapshot) {
                    if (snapshot.hasData) {
                      addInterestBool(snapshot.data.length);
                      interestData1 = snapshot.data;
                      textEditingController1.text = "start";
                      return Container(
                          padding:
                              EdgeInsetsDirectional.only(start: 20, end: 20),
                          child: Column(children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 0.0,
                                      mainAxisSpacing: 0.0,
                                      crossAxisCount: 3,
                                      childAspectRatio: 2.8),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InterestBox(
                                  fontSize: ScreenUtil()
                                      .setSp(MainTheme.mPrimaryContentfontSize),
                                  fillColor: interestBool[index]
                                      ? MainTheme.primaryColor
                                      : Colors.white,
                                  color: MainTheme.primaryColor,
                                  title: snapshot.data[index].title,
                                  onTap: () {
                                    if (interestBool[index] == true) {
                                      setState(() {
                                        interestBool[index] = false;
                                      });
                                      interestSelected
                                          .remove(snapshot.data[index].id);
                                      var val = {
                                        "interest_id": snapshot.data[index].id,
                                        "title": snapshot.data[index].title
                                      };
                                      interestSelected1.remove(val);
                                    } else {
                                      setState(() {
                                        interestBool[index] = true;
                                      });
                                      interestSelected
                                          .add(snapshot.data[index].id);
                                      var val = {
                                        "interest_id": snapshot.data[index].id,
                                        "title": snapshot.data[index].title
                                      };
                                      interestSelected1.add(val);
                                    }
                                  },
                                );
                              },
                            )
                          ]));
                    } else
                      return Container(
                        height: 500,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                  }),
              Row(
                children: [
                  Container(
                      padding: EdgeInsetsDirectional.only(
                          start: 30, top: 10, bottom: 20),
                      child: Text("Hobbies", style: _textForsubHeading)),
                ],
              ),
              FutureBuilder(
                  future: hobbyData,
                  builder: (context, AsyncSnapshot<List<HobbyModel>> snapshot) {
                    if (snapshot.hasData) {
                      addHobbyBool(snapshot.data.length);
                      hobbyData1 = snapshot.data;
                      textEditingController.text = "start";
                      return Container(
                          padding:
                              EdgeInsetsDirectional.only(start: 20, end: 20),
                          child: Column(children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 0.0,
                                      mainAxisSpacing: 0.0,
                                      crossAxisCount: 3,
                                      childAspectRatio: 2.8),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InterestBox(
                                  fontSize: ScreenUtil()
                                      .setSp(MainTheme.mPrimaryContentfontSize),
                                  fillColor: hobbieBool[index]
                                      ? MainTheme.primaryColor
                                      : Colors.white,
                                  color: MainTheme.primaryColor,
                                  title: snapshot.data[index].title,
                                  onTap: () {
                                    if (hobbieBool[index] == true) {
                                      setState(() {
                                        hobbieBool[index] = false;
                                      });
                                      hobbieSelected
                                          .remove(snapshot.data[index].id);
                                      var val = {
                                        "hobby_id": snapshot.data[index].id,
                                        "title": snapshot.data[index].title
                                      };
                                      hobbieSelected1.remove(val);
                                    } else {
                                      setState(() {
                                        hobbieBool[index] = true;
                                      });
                                      hobbieSelected
                                          .add(snapshot.data[index].id);
                                      var val = {
                                        "hobby_id": snapshot.data[index].id,
                                        "title": snapshot.data[index].title
                                      };
                                      hobbieSelected1.add(val);
                                    }
                                  },
                                );
                              },
                            )
                          ]));
                    } else
                      return Container(
                        height: 500,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                  }),
              // InterestcardList(
              //   crossAxisCount: 3,
              //   itemCount: 10,
              //   mainAxisSpacing: 0.0,
              //   crossAxisSpacing: 0.0,
              //   fontSize: 11,
              //   childAspectRatio: 3,
              // ),
              //   Row(
              //     children: [
              //       Container(
              //           margin: EdgeInsetsDirectional.only(
              //               start: 10, top: 10, bottom: 10),
              //           child: Text("Album", style: MainTheme.subHeading))
              //     ],
              //   ),
              //   StaggeredGridView.countBuilder(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     mainAxisSpacing: 0,
              //     crossAxisSpacing: 0,
              //     crossAxisCount: 3,
              //     itemCount: 1,
              //     itemBuilder: (BuildContext context, int index) {
              //       return AlbumImageCard(
              //         onTap: () {
              //           selectUserImage();
              //         },
              //         // selectedUserAvatar: selectedUserAvatar,
              //         onTapClose: () {
              //           setState(() {
              //             selectedUserAvatar = null;
              //           });
              //         },
              //       );
              //     },
              //     staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              //   )
              // ])),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GradientButton(
                  margin: EdgeInsets.all(0),
                  height: MediaQuery.of(context).size.height / 20,
                  name: "Cancel",
                  buttonColor: Colors.white,
                  active: true,
                  color: MainTheme.primaryColor,
                  width: ScreenUtil().setWidth(300),
                  borderRadius: BorderRadius.circular(5),
                  fontWeight: FontWeight.bold,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                GradientButton(
                  margin: EdgeInsets.all(0),
                  height: MediaQuery.of(context).size.height / 20,
                  name: "Confirm",
                  gradient: MainTheme.loginBtnGradient,
                  active: true,
                  color: Colors.white,
                  width: ScreenUtil().setWidth(300),
                  fontWeight: FontWeight.bold,
                  borderRadius: BorderRadius.circular(5),
                  onPressed: () async {
                    if (hobbieSelected.length < 2 &&
                        interestSelected.length < 2) {
                      showtoast("Please choose minimum 2 interests & hobbies");
                    }
                    if (_formKey.currentState.validate() &&
                        interestSelected.length > 1 &&
                        hobbieSelected.length > 1) {
                      setState(() {
                        loading = true;
                      });
                      var result = selectedUserPic == null
                          ? widget.userdata.profileImage
                          : await uploadImage();
                      var userData = {
                        "first_name": _firstNameCtrl.text,
                        "last_name":
                            _lastNameCtrl.text, //"email":_emailCtrl.text,
                        "profession": ["$dropdownProfessionValue"],
                        "dob": selectedDate.toString(),
                        "gender": selectedMenuIndex,
                        "height": int.parse(_heightCtrl.text),
                        "weight": int.parse(_weightCtrl.text),
                        "bio": _bioCtrl.text,
                        "interests": interestSelected,
                        "hobbies": hobbieSelected,
                        "hobby_details": hobbieSelected1,
                        "interest_details": interestSelected1,
                        "profile_image": result
                      };
                      print(userData);
                      UserModel data =
                          await UserNetwork().patchUserData(userData);
                      data != null
                          ? await context.read<HomeProvider>().replaceData(data)
                          : null;
                      print("ool");
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }

  uploadImage() async {
    Uint8List imageString = await File(selectedUserPic.path).readAsBytes();
    // List<int> imageBytes = File(selectedUserPic.path).readAsBytesSync();
    // String imageString = base64Encode(imageBytes);
    var network = UploadImage();
    String result = await network.uploadImage(imageString);
    return [result];
  }

  void selectUserImage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ImageUploadAlert(
            onImagePicked: (XFile imageData) {
              setState(() {
                selectedUserAvatar = imageData;
              });

              // if (imageData.status == 'success') {
              // _authStore.onAvatarSelected(imageData.image);
              // }
            },
          );
        });
  }

  void selectUserPic() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ImageUploadAlert(
            onImagePicked: (XFile imageData) {
              setState(() {
                selectedUserPic = imageData;
              });
              // if (imageData.status == 'success') {
              // _authStore.onAvatarSelected(imageData.image);
              // }
            },
          );
        });
  }

  Widget _buildWeb() {
    return SafeArea(
      child: Scaffold(),
    );
  }
}
