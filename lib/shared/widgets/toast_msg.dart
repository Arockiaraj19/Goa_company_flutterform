import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dating_app/shared/theme/theme.dart';

showtoast(String content){
  Fluttertoast.showToast(
      msg: "$content",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      webShowClose: true,
      backgroundColor: Color.fromRGBO(239, 103, 144, 1).withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16.0
  );
}