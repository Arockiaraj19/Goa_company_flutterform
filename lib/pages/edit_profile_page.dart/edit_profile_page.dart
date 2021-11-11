import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dating_app/models/gender_model.dart';
import 'package:dating_app/models/hobby.dart';
import 'package:dating_app/models/interest.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/gender_network.dart';
import 'package:dating_app/networks/image_upload_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/pages/add_album_page/widgets/album_image_card.dart';
import 'package:dating_app/pages/create_profile_page/widget/gender_card.dart';
import 'package:dating_app/pages/gender_select_page/gender_select_page.dart';
import 'package:dating_app/pages/home_page/widget/interest_box.dart';
import 'package:dating_app/pages/profile_page/widgets/percentage_bar.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/shared/date_picker_input.dart';
import 'package:dating_app/shared/helpers.dart';
import 'package:dating_app/shared/helpers/check_persentage.dart';
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
import 'package:dio/dio.dart';

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
      'isActive': false,
    },
    {
      "gender": "Female",
      "image": "assets/icons/female.png",
      'isActive': false,
    },
    {
      "gender": "More",
      "image": "null",
      'isActive': false,
    }
  ];

  XFile selectedUserAvatar = null;

  XFile selectedUserPic = null;

  fill() async {
    _firstNameCtrl.text = widget.userdata.firstName;
    _lastNameCtrl.text = widget.userdata.lastName;

    _bioCtrl.text = widget.userdata.bio ?? "";
    _heightCtrl.text =
        widget.userdata.height == null ? "" : widget.userdata.height.toString();
    _weightCtrl.text =
        widget.userdata.weight == null ? "" : widget.userdata.weight.toString();
    dropdownProfessionValue = widget.userdata.profession.first;
    // selectedMenuIndex = widget.userdata.gender;
    selectedDate = DateTime.parse(widget.userdata.dob);
    _dobInputCtrl.value =
        TextEditingValue(text: DateFormat.yMMMd().format(selectedDate));
    for (var i = 0; i < widget.userdata.profileImage.length; i++) {
      alreadyimage[i] = widget.userdata.profileImage[i];
    }
  }

  fillHobbies() {
    for (int i = 0; i < hobbyData1.length; i++) {
      if (widget.userdata.hobbies.contains(hobbyData1[i].hobby_id)) {
        hobbieBool[i] = true;
        hobbieSelected.add(hobbyData1[i].hobby_id);
        var val = {
          "hobby_id": hobbyData1[i].hobby_id,
          "title": hobbyData1[i].title
        };
        hobbieSelected1.add(val);
      }
    }
  }

  fillInterests() {
    for (int i = 0; i < interestData1.length; i++) {
      if (widget.userdata.interests.contains(interestData1[i].interest_id)) {
        interestBool[i] = true;
        interestSelected.add(interestData1[i].interest_id);
        var val = {
          "interest_id": interestData1[i].interest_id,
          "title": interestData1[i].title
        };
        interestSelected1.add(val);
      }
    }
  }

  Future _future;
  String _selectedGender;
  String _selectedGenderid;
  GenderModel genderdetail;
  List<String> alreadyimage = [null, null, null, null, null, null];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time = 0;
    fill();
    _future = GenderNetwork().getGenderData();
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

  int time = 0;
  List<XFile> selectedalbumAvatar = [null, null, null, null, null, null];
  List<String> uploadedImages = [];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 1100) {
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
              FutureBuilder(
                future: Persentage().checkPresentage(widget.userdata),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return PercentageBar(
                      percentage: snapshot.data,
                      onEditProfilePage: true,
                      onTap: () {
                        selectUserPic();
                      },
                      image: widget.userdata.identificationImage,
                      selectedUserPic: selectedUserPic,
                      onTapClose: () {
                        setState(() {
                          selectedUserPic = null;
                        });
                      },
                    );
                  } else {
                    return PercentageBar(
                      percentage: 0,
                      onEditProfilePage: true,
                      onTap: () {
                        selectUserPic();
                      },
                      image: widget.userdata.identificationImage,
                      selectedUserPic: selectedUserPic,
                      onTapClose: () {
                        setState(() {
                          selectedUserPic = null;
                        });
                      },
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(top: 5),
                    child: Text(
                      widget.userdata.firstName ?? "Some thing wrong",
                      style: _textStyleforName,
                    ),
                  ),
                ],
              ),
              // SocialMediaRowList(),
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
                          inputType: TextInputType.number,
                          padding: EdgeInsets.all(10),
                          validators: (String value) {
                            if (value.isEmpty) return 'Required field';
                            return null;
                          },
                          hintText: 'Height',
                          suffixIcon: Text("cm  "),
                        ),
                        InputField(
                          onTap: () {},
                          controller: _weightCtrl,
                          padding: EdgeInsets.all(10),
                          inputType: TextInputType.number,
                          validators: (String value) {
                            if (value.isEmpty) return 'Required field';
                            return null;
                          },
                          hintText: 'Weight',
                          suffixIcon: Text("kg  "),
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 10, top: 5, bottom: 5),
                                child: Text(
                                  "Gender",
                                  style: _textForsubHeading,
                                )),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: FutureBuilder(
                            future: _future,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                List<GenderModel> genderdata = snapshot.data;
                                if (time == 0) {
                                  _selectedGenderid = widget.userdata.gender;
                                  genderdetail = genderdata.firstWhere(
                                      (element) =>
                                          element.id == widget.userdata.gender);
                                  print("inga na select pannathu varuthaa");
                                  print(_selectedGenderid);
                                  print(genderdetail);
                                }
                                return GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 0.0,
                                            mainAxisSpacing: 0.0,
                                            crossAxisCount: 3,
                                            childAspectRatio: 2.8),
                                    itemCount: genderdata.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GenderEditCard(
                                        data: genderdata[index],
                                        id: _selectedGenderid,
                                        onTap: () async {
                                          setState(() {
                                            _selectedGenderid =
                                                genderdata[index].id;
                                            genderdetail = genderdata[index];
                                          });
                                          time++;
                                        },
                                      );
                                    });
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
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
                                      interestSelected.remove(
                                          snapshot.data[index].interest_id);

                                      interestSelected1
                                          .remove(snapshot.data[index].toMap());
                                    } else {
                                      setState(() {
                                        interestBool[index] = true;
                                      });
                                      interestSelected.add(
                                          snapshot.data[index].interest_id);

                                      interestSelected1
                                          .add(snapshot.data[index].toMap());
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
                                      hobbieSelected.remove(
                                          snapshot.data[index].hobby_id);
                                      var val = {
                                        "hobby_id":
                                            snapshot.data[index].hobby_id,
                                        "title": snapshot.data[index].title
                                      };
                                      hobbieSelected1.remove(val);
                                    } else {
                                      setState(() {
                                        hobbieBool[index] = true;
                                      });
                                      hobbieSelected
                                          .add(snapshot.data[index].hobby_id);
                                      var val = {
                                        "hobby_id":
                                            snapshot.data[index].hobby_id,
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
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                        child: Text("Album", style: _textForsubHeading)),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                    color: Colors.grey[200],
                    height: MediaQuery.of(context).size.height / 2.7,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 3,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return AlbumImageCard(
                          alreadyimage: alreadyimage[index],
                          onTap: () async {
                            selectalbumImage(index);
                          },
                          selectedUserAvatar: selectedalbumAvatar[index],
                          onTapClose: () {
                            setState(() {
                              alreadyimage[index] = null;
                              selectedalbumAvatar[index] = null;
                            });
                          },
                        );
                      },
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                    )),
              ),
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
                  name: loading ? "Loading..." : "Confirm",
                  gradient: MainTheme.loginBtnGradient,
                  active: true,
                  isLoading: loading,
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
                      String result;
                      try {
                        result = selectedUserPic == null
                            ? widget.userdata.identificationImage
                            : await UploadImage()
                                .uploadImage(selectedUserPic.path);
                      } on DioError catch (e) {
                        setState(() {
                          loading = false;
                        });
                      }
                      try {
                        await goToLookingForPagePage();
                      } on DioError catch (e) {
                        setState(() {
                          loading = false;
                        });
                      }

                      print("album enna varuthu");
                      print(uploadedImages);
                      List<String> albumimage = uploadedImages.length == 0
                          ? widget.userdata.profileImage
                          : uploadedImages;
                      var userData = {
                        "first_name": _firstNameCtrl.text,
                        "last_name":
                            _lastNameCtrl.text, //"email":_emailCtrl.text,
                        "profession": ["$dropdownProfessionValue"],
                        "dob": selectedDate.toString(),
                        "gender_id": _selectedGenderid.toString(),
                        "gender_details": [genderdetail.toMap()],
                        "height": int.parse(_heightCtrl.text),
                        "weight": int.parse(_weightCtrl.text),
                        "bio": _bioCtrl.text,
                        "interests": interestSelected,
                        "hobbies": hobbieSelected,
                        "hobby_details": hobbieSelected1,
                        "interest_details": interestSelected1,
                        "identification_image": result,
                        "profile_image": albumimage,
                      };
                      print("edit profile userdata");
                      print(userData);
                      try {
                        UserModel data =
                            await UserNetwork().patchUserData(userData);
                        data != null
                            ? await context
                                .read<HomeProvider>()
                                .replaceData(data)
                            : null;
                        print("ool");
                        Navigator.pop(context);
                      } on DioError catch (e) {
                        setState(() {
                          loading = false;
                        });
                      }
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }

  goToLookingForPagePage() async {
    try {
      var network = UploadImage();
      print("kl1");
      for (int i = 0; i < 6; i++) {
        if (selectedalbumAvatar[i] != null) {
          String result =
              await network.uploadImage(selectedalbumAvatar[i].path);
          print("output velia varuthaaa");
          print(result);
          uploadedImages.add(result);
        } else {
          if (alreadyimage[i] != null) {
            uploadedImages.add(alreadyimage[i]);
          }
        }
      }
    } catch (e) {
      throw e;
    }
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

  void selectalbumImage(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ImageUploadAlert(
            onImagePicked: (XFile imageData) {
              setState(() {
                selectedalbumAvatar[index] = imageData;
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
