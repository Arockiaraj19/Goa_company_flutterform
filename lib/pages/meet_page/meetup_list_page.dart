import 'package:dating_app/shared/theme/theme.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'widgets/restarent_card.dart';

class MeetupList extends StatefulWidget {
  @override
  _MeetupListState createState() => _MeetupListState();
}

class _MeetupListState extends State<MeetupList> {
  bool _showbotton = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (val) {
                print(val);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffEAEAEA),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xff8F96AD),
                  size: 30,
                ),
                contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                hintText: "Search restaurants and bars...",
                hintStyle: TextStyle(
                    fontSize: 35.sp,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff666666)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: BorderSide(
                      color: Color(0xffEFEBEB),
                      width: 0,
                      style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: BorderSide(
                      color: Color(0xffEFEBEB),
                      width: 0,
                      style: BorderStyle.solid),
                ),
              ),
              enableInteractiveSelection: true,
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Choose any three Resturents",
                style: TextStyle(
                    fontSize: 40.sp,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff666666)),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              setState(() {
                                print("triggered");
                                _showbotton = !_showbotton;
                              });
                            },
                            child: RestorentCard());
                      }),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    bottom: _showbotton ? -100 : 10,
                    right: 250.w,
                    child: InkWell(
                      onTap: () => showPopup(context),
                      child: Container(
                        height: 40.h,
                        width: 400.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(235, 77, 181, 1),
                                Color.fromRGBO(239, 103, 152, 1)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Book Now",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  void showPopup(context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
      builder: (context) => Container(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text("Book your date and time",
                  style: TextStyle(
                      fontSize: 60.sp,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1B1116))),
            ),
            SizedBox(
              height: 30.h,
            ),
            TextFormField(
              readOnly: true,
              controller: _dateController,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xff8F96AD),
                ),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                hintText: "Booking date",
                hintStyle: TextStyle(
                  fontSize: 45.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8F96AD),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xffEFEBEB),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xffEFEBEB),
                      width: 1,
                      style: BorderStyle.solid),
                ),
              ),
              onTap: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2015),
                  lastDate: DateTime(2025),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    _dateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter date.';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              readOnly: true,
              controller: _timeController,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.timelapse_outlined,
                  color: Color(0xff8F96AD),
                ),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                hintText: "Booking time",
                hintStyle: TextStyle(
                  fontSize: 45.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8F96AD),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xffEFEBEB),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xffEFEBEB),
                      width: 1,
                      style: BorderStyle.solid),
                ),
              ),
              onTap: () async {
                Navigator.of(context).push(
                  showPicker(
                    context: context,
                    value: _time,
                    onChange: onTimeChanged,
                    minuteInterval: MinuteInterval.FIVE,
                    disableHour: false,
                    disableMinute: false,
                    minMinute: 7,
                    maxMinute: 56,
                    // Optional onChange to receive value as DateTime
                    onChangeDateTime: (DateTime dateTime) {
                      _timeController.text = dateTime.toIso8601String();
                      print(dateTime);
                    },
                  ),
                );
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter time';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () => print("hello"),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 40.h,
                  width: 400.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(235, 77, 181, 1),
                          Color.fromRGBO(239, 103, 152, 1)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Schedule Now",
                    style: TextStyle(color: Colors.white, fontSize: 40.sp),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
