import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Forminput extends StatelessWidget {
  const Forminput(
      {Key key,
      @required this.emailController,
      @required this.placeholder,
      @required this.validation});

  final TextEditingController emailController;
  final String placeholder;
  final validation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
          controller: emailController,
          cursorColor: Colors.pink,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 40.sp,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400,
              color: MainTheme.enterTextColor),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                left: 18.0.w, bottom: 12.0.h, top: 12.0.h, right: 2.0.w),
            hintText: (placeholder),
            hintStyle: TextStyle(
                fontSize: 40.sp,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w400,
                color: Color(0xff8F96AD)),
            errorStyle: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.w400,
              color: Colors.pink,
            ),
            errorBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(
                  color: Colors.pink, width: 1, style: BorderStyle.solid),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.pink, width: 1, style: BorderStyle.solid),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xffEFEBEB), width: 1, style: BorderStyle.solid),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.pink, width: 1, style: BorderStyle.solid),
            ),
          ),
          validator: validation),
    );
  }
}

// class Searchtextinput extends StatelessWidget {
//   const Searchtextinput({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onChanged: (val) {
//         print(val);
//       },
//       decoration: InputDecoration(
//         prefixStyle: TextStyle(
//             fontSize: fontBody2,
//             fontWeight: FontWeight.w400,
//             color: Color(0xff8F96AD)),
//         prefixIcon: const Icon(
//           Icons.search,
//           color: Color(0xff8F96AD),
//         ),
//         contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//         hintText: "Search",
//         hintStyle: TextStyle(
//             fontSize: 18.sp,
//             letterSpacing: 1.0,
//             fontWeight: FontWeight.w600,
//             color: Color(colorText2)),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//               color: Color(0xffEFEBEB), width: 1, style: BorderStyle.solid),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//               color: Color(0xffEFEBEB), width: 1, style: BorderStyle.solid),
//         ),
//       ),
//       enableInteractiveSelection: true,
//     );
//   }
// }
