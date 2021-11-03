import 'package:dating_app/models/device_info.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../routes.dart';
import 'client/apiClient.dart';
import 'client/api_list.dart';

class SignInNetwork {
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        Response response = await value.post(signInEmailEndpoint,
            data: {"email": email, "password": password});
        print("before responce");
        print(response.data);
        print("After response");
        if (response.statusCode == 200) {
          saveUser(response.data["user_id"]);
          saveLoginStatus(1);
          saveToken(response.data["accessToken"], response.data["accessToken"]);
          return true;
        } else {
          return false;
        }
      });
      return data;
    } catch (e) {
   throw e;
    }
  }

  Future<bool> signInWithMobile(String mobile) async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value
            .post(signInMobileEndpoint, data: {"mobile_number": mobile});
        print(response.data);
        if (response.statusCode == 200) {
          saveUser(response.data["user_id"]);
          saveLoginStatus(1);
          saveToken(response.data["accessToken"], response.data["accessToken"]);
          return true;
        } else {
          return false;
        }
      });
      return data;
    } catch (e) {
    throw e;
    }
  }
}
