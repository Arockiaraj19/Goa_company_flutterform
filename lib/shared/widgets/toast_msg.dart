import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dating_app/shared/theme/theme.dart';

showtoast(String content) {
  Fluttertoast.showToast(
      webBgColor: "linear-gradient(to right, #A18CD1, #A18CD1)",
      msg: "$content",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      webShowClose: true,
      backgroundColor: Color(0xffA18CD1),
      textColor: Colors.white,
      fontSize: 16.0);
}
