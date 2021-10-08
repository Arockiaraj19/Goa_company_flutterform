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
    return TextFormField(
        controller: emailController,
        cursorColor: Colors.pink,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          hintText: (placeholder),
          hintStyle: TextStyle(
              fontSize: 40.sp,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400,
              color: Color(0xffC4C4C4)),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.pink, width: 1, style: BorderStyle.solid),
          ),
          errorStyle: TextStyle(
            fontSize: 40.sp,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w400,
            color: Colors.pink,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.pink, width: 1, style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xffC4C4C4), width: 1, style: BorderStyle.solid),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.pink, width: 1, style: BorderStyle.solid),
          ),
        ),
        enableInteractiveSelection: true,
        validator: validation);
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
