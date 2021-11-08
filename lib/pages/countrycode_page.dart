import 'package:dating_app/models/country_code_model.dart';
import 'package:dating_app/networks/countrycode_network.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryCodePage extends StatefulWidget {
  @override
  _CountryCodePageState createState() => _CountryCodePageState();
}

class _CountryCodePageState extends State<CountryCodePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                DropdownSearch<CountryCode>(
                  mode: Mode.MENU,
                  showAsSuffixIcons: false,
                  showClearButton: false,
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 18.0.w, bottom: 0.0.h, top: 0.0.h, right: 2.0.w),
                    hintText: "Choose Country Code",
                    hintStyle: TextStyle(
                        fontSize: 40.sp,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffC4C4C4)),
                    errorStyle: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w400,
                      color: MainTheme.primaryColor,
                    ),
                    errorBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(
                          color: MainTheme.primaryColor,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: MainTheme.primaryColor,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xffC4C4C4),
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: MainTheme.primaryColor,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "* Required";
                    } else {
                      return null;
                    }
                  },
                  showSearchBox: true,
                  isFilteredOnline: true,
                  itemAsString: (CountryCode u) => u.telephonecode,
                  onFind: (String filter) async {
                    print("on find eppu work aakuthu");
                    print(filter);
                    List<CountryCode> response =
                        await CountryCodeNetwork().getcountrycode(filter);

                    return response;
                  },
                  onChanged: (CountryCode data) {
                    Navigator.pop(context, data.telephonecode);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
