import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Api {
  var dio = Dio();

  Future getdata() async {
    print("funtion called");
    try {
      Response response = await dio.get("http://192.168.43.153:4000/");
      print(response.data);

      return response.data;
    } catch (e) {
      print("from cache");
      print(e);
    }
  }

  Future postdata(userdata) async {
    try {
      Response response =
          await dio.post("http://192.168.43.153:4000/", data: userdata);
      print(response);

      return response;
    } catch (e) {
      print("from cache");
      print(e);
    }
  }
}
