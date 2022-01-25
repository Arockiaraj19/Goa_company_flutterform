// import 'dart:async';
// import 'dart:convert';
// import 'package:dating_app/models/user_suggestion.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'dart:io';

// import 'dio_exception.dart';

// class Constants {
//   static String APP_ID = "1141908882883789";
//   static String APP_SECRET = "94a5761e24f4bab30558d9ac19d9ddbf";
// }

// Future<Token> getToken(String appId, String appSecret) async {
//   try {
//     Response responses = await Dio()
//         .get("https://api.instagram.com/oauth/authorize", queryParameters: {
//       "client_id": appId,
//       "redirect_uri": "https://sparksuser.com",
//       "scope": "user_profile",
//       "response_type": "code",
//     });
//     print(responses.data);
//   } on DioError catch (e) {
//     print(e);
//     print("inga error la enna varuthu");
//     print(DioException.fromDioError(e).toString());
//   }

//   // Response responses =
//   //     await Dio().post("https://api.instagram.com/oauth/access_token", data: {
//   //   "client_id": appId,
//   //   "redirect_uri": "https://sparksuser.com/",
//   //   "client_secret": appSecret,
//   //   "code": code,
//   //   "grant_type": "authorization_code"
//   // });

//   // return new Token.fromMap(jsonDecode(responses.data));
// }

// class Token {
//   String access;
//   String id;
//   String username;
//   String full_name;
//   String profile_picture;

//   Token.fromMap(Map json) {
//     access = json['access_token'];
//     id = json['user']['id'];
//     username = json['user']['username'];
//     full_name = json['user']['full_name'];
//     profile_picture = json['user']['profile_picture'];
//   }
// }
