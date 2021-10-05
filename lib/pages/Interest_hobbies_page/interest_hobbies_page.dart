import 'dart:async';
import 'package:dating_app/models/hobby.dart';
import 'package:dating_app/models/interest.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/pages/home_page/widget/interest_box.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/interest_card_list.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterestHobbiesPage extends StatefulWidget {
  InterestHobbiesPage({Key key}) : super(key: key);

  @override
  _InterestHobbiesPageState createState() => _InterestHobbiesPageState();
}

class _InterestHobbiesPageState extends State<InterestHobbiesPage> {
  Future<List<InterestModel>> interestData;
  Future<List<HobbyModel>> hobbyData;
  List<String>interestSelected=[];
  List<String>hobbieSelected=[];
  List<String>interestSelected1=[];
  List<String>hobbieSelected1=[];
  List<bool>interestBool=[];
  List<bool>hobbieBool=[];
  bool loading =false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  addInterestBool(int count){
    for(int i=0;i<count;i++){
      interestBool.add(false);
    }
  }
  addHobbyBool(int count){
    for(int i=0;i<count;i++){
      hobbieBool.add(false);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(interestData==null){
      interestData=UserNetwork().getUserInterests();
      hobbyData=UserNetwork().getUserHobbies();
    }
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
    var _textForsubHeading = TextStyle(
        color: MainTheme.leadingHeadings,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(MainTheme.mSecondarySubHeadingfontSize),
        fontFamily: "lato");
    return SafeArea(
        child: Scaffold(
          bottomSheet: Container(height: 100,color:Colors.white,child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                height: 40,
                name: loading?"Saving..":"Continue",
                gradient: MainTheme.loginBtnGradient,
                active: true,
                isLoading: loading,
                color: Colors.white,
                width: ScreenUtil().setWidth(400),
                fontWeight: FontWeight.w600,
                onPressed: () {
                  if(hobbieSelected.length<2&&interestSelected.length<2){
                    showtoast("Please choose minimum 2 interests & hobbies");
                  }else if(hobbieSelected.length<2){
                    showtoast("Please choose minimum 2 hobbies");
                  }else if(interestSelected.length<2){
                    showtoast("Please choose minimum 2 interests");
                  }else{
                  goToAddYourProfilePicPage();
                  }
                },
              ),
            ],
          ),),
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
                  child: Text("Add your Interest & Hobbies",
                      style: _textStyleforHeading)),
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 10, end: 10),
                    width: 150,
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
                  builder: (context,AsyncSnapshot<List<InterestModel>> snapshot) {
                  if(snapshot.hasData) {
                    addInterestBool(snapshot.data.length);
                    return Container(
                        padding: EdgeInsetsDirectional.only(start: 20, end: 20),
                        child: Column(children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 0.0,
                                mainAxisSpacing: 0.0,
                                crossAxisCount: 3,
                                childAspectRatio: 2.8),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InterestBox(
                                fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
                                fillColor: interestBool[index]?MainTheme.primaryColor:
                                Colors.white,
                                color: MainTheme.primaryColor,
                                title: snapshot.data[index].title,
                                onTap: () {
                                 if(interestBool[index]==true){
                                   setState(() {
                                     interestBool[index]=false;
                                   });
                                   interestSelected.remove(snapshot.data[index].id);
                                   interestSelected1.remove(snapshot.data[index].toString());
                                 }else {
                                   setState(() {
                                     interestBool[index]=true;
                                   });
                                   interestSelected.add(snapshot.data[index].id);
                                   interestSelected1.add(snapshot.data[index].toString());
                                 }
                                },
                              );
                            },
                          )
                        ]));
                  }
                  else return Container(height: 500,alignment: Alignment.center,
                    child: CircularProgressIndicator(),);
                }
              ),
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
                      builder: (context,AsyncSnapshot<List<HobbyModel>> snapshot) {
                        if(snapshot.hasData){
                          addHobbyBool(snapshot.data.length);
                          return Container(
                              padding: EdgeInsetsDirectional.only(start: 20, end: 20),
                              child: Column(children: [
                                GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 0.0,
                                    mainAxisSpacing: 0.0,
                                    crossAxisCount: 3,
                                    childAspectRatio: 2.8),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InterestBox(
                                    fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
                                    fillColor: hobbieBool[index]?MainTheme.primaryColor:
                                    Colors.white,
                                    color: MainTheme.primaryColor,
                                    title: snapshot.data[index].title,
                                    onTap: () {
                                      if(hobbieBool[index]==true){
                                        setState(() {
                                          hobbieBool[index]=false;
                                        });
                                        hobbieSelected.remove(snapshot.data[index].id);
                                        hobbieSelected1.remove(snapshot.data[index].toString());
                                      }else {
                                        setState(() {
                                          hobbieBool[index]=true;
                                        });
                                        hobbieSelected.add(snapshot.data[index].id);
                                        hobbieSelected1.add(snapshot.data[index].toString());
                                      }
                                    },
                                  );
                                },
                              )
                              ]));}
                        else return Container(height: 500,alignment: Alignment.center,
                          child: CircularProgressIndicator(),);
                      }
                  ),
            ]))));
  }

  goToAddYourProfilePicPage() async {
    setState(() {
      loading=true;
    });
    print(hobbieSelected1);
    var network = UserNetwork();
    var userData={"interests":interestSelected,"hobbies":hobbieSelected,
    "hobby_details":hobbieSelected1,"interest_details":interestSelected1};
    Timer(Duration(seconds: 3), ()=>offLoading());
    UserModel result =await network.patchUserData(userData);
    result != null? onboardingCheck(result):null;
  }

  offLoading(){
    setState(() {
      loading=false;
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
                              "Add your Interest & Hobbies",
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
                              width: _width / 4,
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

                        Row(
                          children: [
                            Container(
                                padding: EdgeInsetsDirectional.only(
                                    top: 10, bottom: 20),
                                child: Text(
                                  "Interest",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: "Inter"),
                                )),
                          ],
                        ),

                        // Container(
                        //     height: 210,
                        //     width: _width,
                        //     child:

                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                              crossAxisCount: 3,
                              childAspectRatio: 2.8),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return InterestBox(
                              fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
                              color: MainTheme.primaryColor,
                              title: "snapshot.data[index].title",
                              onTap: () {

                              },
                            );
                          },
                        )

                        // StaggeredGridView.countBuilder(
                        //   crossAxisCount: 4,
                        //   itemCount: 18,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return InterestBox(
                        //       fontSize: 12,
                        //     );
                        //   },
                        //   staggeredTileBuilder: (int index) =>
                        //       StaggeredTile.fit(1),
                        //   mainAxisSpacing: 10.0,
                        //   crossAxisSpacing: 10.0,
                        // )
                        // )
                        ,

                        Row(
                          children: [
                            Container(
                                padding: EdgeInsetsDirectional.only(
                                    top: 5, bottom: 20),
                                child: Text(
                                  "Hobbies",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: "Inter"),
                                )),
                          ],
                        ),

                        // Container(
                        //     height: 200,
                        //     width: _width,
                        //     child:

                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                              crossAxisCount: 3,
                              childAspectRatio: 2.8),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return InterestBox(
                              fontSize: ScreenUtil().setSp(MainTheme.mPrimaryContentfontSize),
                              color: MainTheme.primaryColor,
                              title: "snapshot.data[index].title",
                              onTap: () {

                              },
                            );
                          },
                        )

                        // StaggeredGridView.countBuilder(
                        //   crossAxisCount: 4,
                        //   itemCount: 18,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return InterestBox(
                        //       fontSize: 12,
                        //     );
                        //   },
                        //   staggeredTileBuilder: (int index) =>
                        //       StaggeredTile.fit(1),
                        //   mainAxisSpacing: 10.0,
                        //   crossAxisSpacing: 10.0,
                        // )

                        // )

                        ,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientButton(
                              name: loading?"Saving..":"Continue",
                              gradient: MainTheme.loginBtnGradient,
                              height: 35,
                              fontSize: 14,
                              isLoading: loading,
                              width: _width / 6,
                              active: true,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              onPressed: () {
                                if(hobbieSelected.length==0&&interestSelected.length==0){
                                showtoast("Please choose your interests & hobbies");
                              }else if(hobbieSelected.length==0){
                                showtoast("Please choose your hobbies");
                              }else if(interestSelected.length==0){
                                showtoast("Please choose your interests");
                              }else{
                                goToAddYourProfilePicPage();
                              }
                              },
                            ),
                          ],
                        ),
                        // Container(
                        //     padding: EdgeInsetsDirectional.only(
                        //       top: 10,
                        //     ),
                        //     child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Container(
                        //               child: Text("Already have account?",
                        //                   style: _textStyleforAlreadyHave)),
                        //           Text("Log In", style: _textStyleforLogin),
                        //         ])),
                      ],
                    ))))
      ]),
    ));
  }
}
