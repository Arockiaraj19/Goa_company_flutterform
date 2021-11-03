import 'package:dating_app/models/matchuser_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:dio/dio.dart';

import 'client/apiClient.dart';
import 'client/api_list.dart';
import 'sharedpreference/sharedpreference.dart';

class HomeButtonNetwork {
  Future<bool> postLikeUnlike(String likedUser, likeType) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.post(likeUnlikeEndpoint,
            data: {"user": id, "liked_user": likedUser, "like_type": likeType});
        print(response.data);
        if (response.statusCode == 200) {
          return true;
        }
      });
      return data;
    } catch (e) {
     throw e;
    }
  }

  Future<bool> postMatchRequest(
      String confirmedUser, UserModel userData) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.post(matchRequestEndpoint, data: {
          "requested_user": id,
          "confirmed_user": confirmedUser,
          "user_details": userData
        });
        print("normal response");
        print(response.data);
        if (response.statusCode == 200) {
          if (response.data["type"] == 1) {
            print("response from 200");
            showtoast(response.data["msg"]);
            return true;
          } else {
            print("response from 201");
            showtoast(response.data["msg"]);
            final userdata = new Map<String, dynamic>.from(response.data);
            MatchUser matchdata = MatchUser.fromMap(userdata);
            Routes.sailor(Routes.perfectMatchPage,
                params: {"user1": userData, "user2": matchdata});
            return true;
          }
        }
      });
      return data;
    } catch (e) {
      throw e;
    }
  }
}
