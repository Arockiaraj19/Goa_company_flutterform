import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:dating_app/providers/blind_provider.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/shared/helpers/websize.dart';

import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/gradient_button.dart';
import 'package:dating_app/shared/widgets/input_field.dart';
import 'package:dating_app/shared/widgets/main_appbar.dart';
// import 'package:dating_app/shared/widgets/radio_button_row.dart';
import 'package:dating_app/shared/widgets/sliders_feilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class FilterBottomSheet1 extends StatefulWidget {
  final bool onWeb;
  FilterBottomSheet1({Key key, this.onWeb = false}) : super(key: key);

  @override
  _FilterBottomSheet1State createState() => _FilterBottomSheet1State();
}

class _FilterBottomSheet1State extends State<FilterBottomSheet1> {
  TextEditingController _firstNameCtrl = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  double _currentSliderValue = 20;
  List type = ["", "Mesomorph", "Endomorph", "Ectomorph"];
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderThemeData(
          trackHeight: 1,
          activeTrackColor: MainTheme.primaryColor,
        ),
        child: Consumer<HomeProvider>(
          builder: (context, data, child) {
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(start: 20),
                      child: Text("Age",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "OpenSans",
                            fontSize: widget.onWeb ? 14 : 35.sp,
                          )),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.only(end: 50),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                                '${_currentRangeValues.start.round().toString()} - ',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ),
                          Container(
                            child: Text(
                                '${_currentRangeValues.end.round().toString()}',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                    child: RangeSlider(
                  activeColor: MainTheme.primaryColor,
                  inactiveColor: Colors.grey,
                  values: _currentRangeValues,
                  min: 0,
                  max: 100,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(
                        start: 20,
                      ),
                      child: Text("Distance",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "OpenSans",
                            fontSize: widget.onWeb ? 14 : 35.sp,
                          )),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.only(end: 50),
                      child: Text(
                          '${_currentSliderValue.round().toString()} Km',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ),
                  ],
                ),
                Container(
                    child: Slider(
                  value: _currentSliderValue,
                  activeColor: MainTheme.primaryColor,
                  inactiveColor: Colors.grey,
                  min: 0,
                  max: 100,
                  divisions: 5,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                )),
                // Container(
                //     padding: EdgeInsetsDirectional.only(start: 10, end: 10),
                //     child: InputField(
                //       onTap: () {},
                //       controller: _firstNameCtrl,
                //       padding: EdgeInsets.all(10),
                //       validators: (String value) {
                //         if (value.isEmpty) return 'Required field';
                //         return null;
                //       },
                //       hintText: 'location',
                //     )),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsetsDirectional.only(start: 20),
                  child: Text("Type",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                        fontSize: widget.onWeb ? 14 : 35.sp,
                      )),
                ),
                Container(
                  height: 60.h,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                                child: Row(
                              children: [
                                Radio<int>(
                                  activeColor: MainTheme.primaryColor,
                                  value: 1,
                                  groupValue: data.view,
                                  onChanged: (int value) {
                                    setState(() {
                                      data.view = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Mesomorph',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "OpenSans",
                                    fontSize: widget.onWeb ? 14 : 35.sp,
                                  ),
                                ),
                              ],
                            )),
                            Container(
                                child: Row(
                              children: [
                                Radio<int>(
                                  activeColor: MainTheme.primaryColor,
                                  value: 2,
                                  groupValue: data.view,
                                  onChanged: (int value) {
                                    setState(() {
                                      data.view = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Endomorph',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "OpenSans",
                                    fontSize: widget.onWeb ? 14 : 35.sp,
                                  ),
                                ),
                              ],
                            )),
                            Container(
                                child: Row(
                              children: [
                                Radio<int>(
                                  activeColor: MainTheme.primaryColor,
                                  value: 3,
                                  groupValue: data.view,
                                  onChanged: (int value) {
                                    setState(() {
                                      data.view = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Ectomorph',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "OpenSans",
                                    fontSize: widget.onWeb ? 14 : 35.sp,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GradientButton(
                      height: widget.onWeb ? 35 : 110.w,
                      fontSize: widget.onWeb ? inputFont : 40.sp,
                      width: widget.onWeb ? 130 : 500.w,
                      name: "Cancel",
                      buttonColor: Colors.white,
                      active: true,
                      color: MainTheme.primaryColor,
                      borderRadius: BorderRadius.circular(5),
                      fontWeight: FontWeight.bold,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    GradientButton(
                      height: widget.onWeb ? 35 : 110.w,
                      fontSize: widget.onWeb ? inputFont : 40.sp,
                      width: widget.onWeb ? 130 : 500.w,
                      name: "Find",
                      gradient: MainTheme.loginBtnGradient,
                      active: true,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      borderRadius: BorderRadius.circular(5),
                      onPressed: () async {
                        String id = await getUserId();
                        var lat = await getLat();
                        var lng = await getLng();
                        var postData = {
                          "user": id,
                          "min_age": _currentRangeValues.start.toInt(),
                          "max_age": _currentRangeValues.end.toInt(),
                          "type": "1",
                          "body_type": type[data.view],
                          "distance": "${_currentSliderValue.toInt()}000",
                          "latitude": lat.toString(),
                          "longitude": lng.toString()
                        };
                        Navigator.pop(context);
                        context
                            .read<BlindProvider>()
                            .postData(context, postData);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          },
        ));
  }
}

//   Widget _buildWeb() {
//     return SafeArea(
//       child: Scaffold(),
//     );
//   }
// }
