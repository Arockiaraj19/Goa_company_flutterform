import 'dart:async';

import 'package:dating_app/models/gender_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/gender_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/pages/create_profile_page/widget/gender_card.dart';
import 'package:dating_app/pages/gender_select_page/gender_select_page.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/date_picker_input.dart';
import 'package:dating_app/shared/helpers.dart';
import 'package:dating_app/shared/helpers/get_loc_name.dart';
import 'package:dating_app/shared/helpers/google_map.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/input_field.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateProfilePage extends StatefulWidget {
  final UserModel userData;
  CreateProfilePage({Key key, this.userData}) : super(key: key);

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  bool loading = false, validate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameCtrl = TextEditingController();
  TextEditingController _lastNameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _dobInputCtrl = TextEditingController();
  List<dynamic> location = [];
  String locationName;
  DateTime selectedDate;
  int selectedMenuIndex = 0;

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
      "gender": "More",
      "image": "null",
      'isActive': false,
    }
  ];
  Future _future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fill();
    _future = GenderNetwork().getGenderData();
  }

  String _selectedGender;
  String _selectedGenderid;
  fill() {
    setState(() {
      _emailCtrl.text = widget.userData.email;
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
    var _textStyleforHeading = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");

    var _textForEnterMobile = TextStyle(
        color: MainTheme.enterTextColor,
        fontWeight: FontWeight.w500,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    var _textForCodeIs = TextStyle(
        color: MainTheme.codeIsSendTextColor,
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
        fontFamily: "lato");

    var _textForGender = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mTertiarySubHeadingfontSize),
        fontFamily: "lato");

    return SafeArea(
      child: Scaffold(
          bottomSheet: Container(
            height: 100,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientButton(
                  height: 40,
                  name: loading ? "Saving.." : "Continue",
                  gradient: MainTheme.loginBtnGradient,
                  active: true,
                  color: Colors.white,
                  isLoading: loading,
                  width: ScreenUtil().setWidth(400),
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    setState(() {
                      validate = true;
                    });
                    if (_formKey.currentState.validate() &&
                        location.length > 0 &&
                        selectedDate != null) {
                      if (loading != true) {
                        goToInterestHobbiesPage();
                      }
                    }
                  },
                ),
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Container(
                child: Text("Create Profile", style: _textStyleforHeading)),
          ),
          body: SingleChildScrollView(
              child: Column(children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(start: 10, end: 10),
                  width: 100,
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
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsetsDirectional.only(
                  start: 10,
                  end: 10,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        onTap: () {},
                        //labelBehavior: FloatingLabelBehavior.never,
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
                        // labelBehavior: FloatingLabelBehavior.never,
                        controller: _lastNameCtrl,
                        padding: EdgeInsets.all(10),
                        validators: (String value) {
                          if (value.isEmpty) return 'Required field';
                          return null;
                        },
                        hintText: 'Your last name',
                      ),
                      InputField(
                        onTap: () {},
                        labelBehavior: FloatingLabelBehavior.never,
                        controller: _emailCtrl,
                        padding: EdgeInsets.all(10),
                        validators: (String value) {
                          if (value.isEmpty) return 'Required field';
                          return null;
                        },
                        hintText: 'Email',
                      ),
                      DatePickerInput(
                        hintText: selectedDate == null ? 'DD-MM-YYYY' : '',
                        controller: _dobInputCtrl,
                        onSelect: (DateTime date) {
                          removeFocus(context);
                          setState(() {
                            selectedDate = date;
                          });
                          print(selectedDate);
                        },
                      ),
                      validate == true && selectedDate == null
                          ? Text(
                              "    Please enter your DOB",
                              style: TextStyle(color: Colors.red),
                            )
                          : Text(""),
                      Container(
                          margin: EdgeInsets.all(5),
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
                              print(dropdownProfessionValue);
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
                      SizedBox(
                        height: 5,
                      ),
                      validate == true && dropdownProfessionValue == null
                          ? Text(
                              "    Please choose your profession",
                              style: TextStyle(color: Colors.red),
                            )
                          : Text(""),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                              padding:
                                  EdgeInsetsDirectional.only(start: 5, top: 10),
                              child: Text("Gender", style: _textForGender)),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        child: FutureBuilder(
                          future: _future,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              List<GenderModel> genderdata = snapshot.data;
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    dynamic item = itemGender[index];
                                    return GenderCard(
                                      name: item["gender"],
                                      image: item["image"],
                                      isActive: item["isActive"],
                                      onTap: () async {
                                        if (mounted) {
                                          setState(() {
                                            selectedMenuIndex = index;
                                            itemGender = itemGender.map<
                                                    Map<String, dynamic>>(
                                                (Map<String, dynamic> item) {
                                              item['isActive'] = false;
                                              return item;
                                            }).toList();
                                            itemGender[index]['isActive'] =
                                                true;
                                          });
                                        }
                                        _selectedGender = item["gender"];
                                        print('${item["gender"]}');
                                        if (item["gender"] == "More") {
                                          final result = await Navigator.push(
                                            context,
                                            // Create the SelectionScreen in the next step.
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GenderPage(snapshot.data)),
                                          );
                                          _selectedGender =
                                              result.title.toString();
                                          setState(() {
                                            itemGender[index]["gender"] =
                                                result.title.toString();
                                          });
                                          print(_selectedGender);
                                        }
                                        print("selected gender");
                                        print(_selectedGender);
                                        _selectedGenderid = genderdata
                                            .firstWhere((element) =>
                                                element.title ==
                                                _selectedGender)
                                            .id;

                                        print("its id");
                                        print(_selectedGenderid);
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
                      GestureDetector(
                        onTap: () async {
                          await getLoc();
                          locationName = location.length > 0
                              ? await getLocName(location[0], location[1])
                              : "Try again";
                          setState(() {
                            locationName = locationName;
                          });
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          width: MediaQuery.of(context).size.width,
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
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  locationName == null
                                      ? "Tap to get your location"
                                      : locationName,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey,
                                )
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      validate == true && location.length == 0
                          ? Text(
                              "    Please tap to get the current location",
                              style: TextStyle(color: Colors.red),
                            )
                          : Text(""),
                      SizedBox(
                        height: 150.h,
                      )
                    ],
                  ),
                ))
          ]))),
    );
  }

  getLoc() async {
    location = await GoogleMapDisplay().createState().currentLocation();
  }

  goToInterestHobbiesPage() async {
    setState(() {
      loading = true;
    });
    var network = UserNetwork();
    var userData = {
      "first_name": _firstNameCtrl.text,
      "last_name": _lastNameCtrl.text,
      "email": _emailCtrl.text,
      "profession": ["$dropdownProfessionValue"],
      "dob": selectedDate.toString(),
      "gender": _selectedGenderid,
      "latitude": location[0].toString(),
      "longitude": location[1].toString(),
    };
    Timer(Duration(seconds: 3), () => offLoading());
    UserModel result = await network.patchUserData(userData);
    result != null ? onboardingCheck(result) : null;
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
                      end: _width / 5,
                      start: _width / 5,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                child: Text(
                              "Create Profile",
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
                              width: _width / 5,
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
                              InputField(
                                onTap: () {},
                                controller: _emailCtrl,
                                padding: EdgeInsets.all(10),
                                validators: (String value) {
                                  if (value.isEmpty) return 'Required field';
                                  return null;
                                },
                                hintText: 'Email',
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
                              validate == true && selectedDate == null
                                  ? Text(
                                      "    Please enter your DOB",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : Text(""),
                              Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsetsDirectional.only(
                                      start: 10, end: 10),
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
                                    items: itemdate
                                        .map<DropdownMenuItem<dynamic>>(
                                            (dynamic value) {
                                      return DropdownMenuItem<dynamic>(
                                        value: value,
                                        child: Text(value
                                            // style: TextStyle(fontSize: 28.sp),
                                            ),
                                      );
                                    }).toList(),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              validate == true &&
                                      dropdownProfessionValue == null
                                  ? Text(
                                      "    Please choose your proffession",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : Text(""),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 5, top: 10),
                                      child: Text(
                                        "Gender",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(12),
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      dynamic item = itemGender[index];
                                      return GenderCard(
                                        name: item["gender"],
                                        image: item["image"],
                                        isActive: item["isActive"],
                                        onTap: () async {
                                          // print(itemGender[index]["gender"]);

                                          if (mounted) {
                                            setState(() {
                                              selectedMenuIndex = index;
                                              itemGender = itemGender.map<
                                                      Map<String, dynamic>>(
                                                  (Map<String, dynamic> item) {
                                                item['isActive'] = false;
                                                return item;
                                              }).toList();
                                              itemGender[index]['isActive'] =
                                                  true;
                                            });
                                          }
                                        },
                                      );
                                    }),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await getLoc();
                                  locationName = location.length > 0
                                      ? await getLocName(
                                          location[0], location[1])
                                      : "Try again";
                                  setState(() {
                                    locationName = locationName;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  width: MediaQuery.of(context).size.width,
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
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          locationName == null
                                              ? "Tap to get your location"
                                              : locationName,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.grey,
                                        )
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              validate == true && location.length == 0
                                  ? Text(
                                      "    Please tap to get the current location",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : Text(""),
                            ],
                          ),
                        )),
                        Container(
                          height: _height / 20,
                          width: _width / 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientButton(
                              name: loading ? "Saving.." : "Continue",
                              gradient: MainTheme.loginBtnGradient,
                              height: 35,
                              fontSize: 14,
                              width: _width / 6,
                              active: true,
                              isLoading: loading,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              onPressed: () {
                                setState(() {
                                  validate = true;
                                });
                                if (_formKey.currentState.validate() &&
                                    location.length > 0 &&
                                    selectedDate != null) {
                                  if (loading != true) {
                                    goToInterestHobbiesPage();
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                        // Container(
                        //     child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //       Container(
                        //           child: Text("Already have account?",
                        //               style: _textStyleforAlreadyHave)),
                        //       Text("Log In", style: _textStyleforLogin),
                        //     ])),
                      ],
                    ))))
      ]),
    ));
  }
}
