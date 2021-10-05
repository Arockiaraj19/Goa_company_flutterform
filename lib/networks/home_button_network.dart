
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dio/dio.dart';

import 'client/apiClient.dart';
import 'client/api_list.dart';
import 'sharedpreference/sharedpreference.dart';

class HomeButtonNetwork{


  Future<bool> postLikeUnlike(String likedUser,likeType) async {
    Response response;
    try {
      final _dio = apiClient();
      String id=await getUserId();
      var data= _dio.then((value) async {
        response =await value.post(likeUnlikeEndpoint,data: {
          "user":id,
          "liked_user":likedUser,
           "like_type":likeType
        });
        print(response.data);
        if (response.statusCode == 200) {
          return true;
        }
      });
      return data;
    } catch (e) {
      print(e);
    }
  }


  Future<bool> postMatchRequest(String confirmedUser,UserModel userData) async {
    Response response;
    try {
      final _dio = apiClient();
      String id=await getUserId();
      var data= _dio.then((value) async {
        response =await value.post(matchRequestEndpoint,data: {
          "requested_user":id,
          "confirmed_user":confirmedUser,
          "user_details": userData
        });
        print(response.data);
        if (response.statusCode == 200) {
          return true;
        }
      });
      return data;
    } catch (e) {
      print(e);
    }
  }
}