import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:dating_app/providers/home_provider.dart';

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

class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet({Key key}) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  TextEditingController _firstNameCtrl = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderThemeData(
          trackHeight: 1,
          activeTrackColor: MainTheme.primaryColor,
        ),
        child: Consumer<HomeProvider>(builder: (context, data, child) {
          return Column(
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 20),
                    child: Text("Age", style: MainTheme.subHeading),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(end: 50),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                              '${_currentRangeValues.start.round().toString()} - ',
                              style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ),
                        Container(
                          child: Text('${_currentRangeValues.end.round().toString()}',
                              style: TextStyle(color: Colors.grey, fontSize: 12)),
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
                    child: Text("Distance", style: MainTheme.subHeading),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(end: 50),
                    child: Text('${_currentSliderValue.round().toString()} Km',
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
              Container(
                  padding: EdgeInsetsDirectional.only(start: 10, end: 10),
                  child: InputField(
                    onTap: () {},
                    controller: _firstNameCtrl,
                    padding: EdgeInsets.all(10),
                    validators: (String value) {
                      if (value.isEmpty) return 'Required field';
                      return null;
                    },
                    hintText: 'location',
                  )),
            Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(start: 20),
              child: Text("View", style: MainTheme.subHeading),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                      width: 120,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: const Text(
                          'Single',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: "OpenSans",
                            fontSize: 12,
                          ),
                        ),
                        leading: Radio<int>(
                          activeColor: MainTheme.primaryColor,
                          value: 1,
                          groupValue: data.view,
                          onChanged: (int value) {
                            setState(() {
                              data.view = value;
                            });
                          },
                        ),
                      )),
                  Container(
                      width: 100,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: const Text('Grid',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: "OpenSans",
                              fontSize: 12,
                            )),
                        leading: Radio<int>(
                          activeColor: MainTheme.primaryColor,
                          value: 2,
                          groupValue: data.view,
                          onChanged: (int value) {
                            setState(() {
                              data.view = value;
                            });
                          },
                        ),
                      )),
                ],
              ),
            )
          ],
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GradientButton(
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
                    height: MediaQuery.of(context).size.height / 20,
                    name: "Confirm",
                    gradient: MainTheme.loginBtnGradient,
                    active: true,
                    color: Colors.white,
                    width: ScreenUtil().setWidth(300),
                    fontWeight: FontWeight.bold,
                    borderRadius: BorderRadius.circular(5),
                    onPressed: () async{
                      var _lat = await getLat();
                      var _lng = await getLng();
                      context.read<HomeProvider>().getFilteredData('${_currentRangeValues.start.toInt()}-${_currentRangeValues.end.toInt()}',
                          _currentSliderValue.toInt().toString(), _lat.toString(), _lng.toString());
                      context.read<HomeProvider>().changeView(data.view);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );},
        ));
  }
}

//   Widget _buildWeb() {
//     return SafeArea(
//       child: Scaffold(),
//     );
//   }
// }
