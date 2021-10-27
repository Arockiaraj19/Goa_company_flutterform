import 'package:dating_app/models/hobby.dart';
import 'package:dating_app/models/interest.dart';
import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
// import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/routes.dart';
import 'package:dio/dio.dart';

import 'client/apiClient.dart';
import 'client/api_list.dart';

class UserNetwork {
  Future<UserModel> patchUserData(var userData) async {
    Response response;
    try {
      final _dio = apiClient();
      var id = await getUserId();
      print("ithu funtion kulla varuthaaa");
      print(userData);
      var data = await _dio.then((value) async {
        response =
            await value.patch(userDetailsEndpoint + "/" + id, data: userData);
        print("response");
        print(response.data);

        if (response.statusCode == 200) {
          return (response.data as List)
              .map((x) => UserModel.fromJson(x))
              .toList();
        }
      });
      return data[0];
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> getUserData() async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = await _dio.then((value) async {
        response = await value.get(userDetailsEndpoint + "/" + id);
        print("oops");
        print(response.data);

        print("hobbie details");
        if (response.statusCode == 200) {
          return (response.data as List)
              .map((x) => UserModel.fromJson(x))
              .toList();
        }
      });
      return data[0];
    } catch (e) {
      print(e);
    }
  }

  Future<UsersSuggestionModel> getUserSuggestionsData(
      bool apply, String age, distance, lat, lng, type, int skip) async {
    Response response;
    try {
      var query;
      if (apply == true) {
        print("ll888888");
        query = {
          "age": age,
          "distance": distance,
          "longitude": lng,
          "latitude": lat,
          "type": type,
          "skip": skip
        };
        print(query);
      }
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.get(
            userDetailsEndpoint + "/" + id + userSuggestionsEndpoint,
            queryParameters: query);
        print(response.requestOptions.queryParameters);
        print(response.data);
        print("ll88");
        if (response.statusCode == 200) {
          return UsersSuggestionModel.fromJson(response.data);
        }
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<List<InterestModel>> getUserInterests() async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value.get(userInterestEndpoint);
        print("user interest response data");
        print(response.data);
        final results = List<Map<String, dynamic>>.from(response.data);

        List<InterestModel> interest = results
            .map((hobbieData) => InterestModel.fromMap(hobbieData))
            .toList(growable: false);
        return interest;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<List<HobbyModel>> getUserHobbies() async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value.get(userHobbiesEndpoint);
        // print("user hobbies data");
        // print(response.data);
        final results = List<Map<String, dynamic>>.from(response.data);

        List<HobbyModel> hobbies = results
            .map((hobbieData) => HobbyModel.fromMap(hobbieData))
            .toList(growable: false);
        // print(hobbies);
        return hobbies;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getUserLikeCount() async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value
            .get(userDetailsEndpoint + "/" + id + userLikeCountEndpoint);
        print(response.data);
        if (response.statusCode == 200) {
          return response.data;
        }
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<List<LikeListModel>> getUserLikeList() async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value
            .get(userDetailsEndpoint + "/" + id + userLikeListEndpoint);
        print("oop1");
        print(response.data);
        if (response.statusCode == 200) {
          return (response.data as List)
              .map((x) => LikeListModel.fromJson(x))
              .toList();
        }
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getUserMatchCount() async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value
            .get(userDetailsEndpoint + "/" + id + userMatchCountEndpoint);
        print(response.data);
        if (response.statusCode == 200) {
          return response.data;
        }
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<List<MatchListModel>> getUserMatchList() async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.get(userMatchListEndpoint + "/" + id);
        print("match list data");
        print(response.data);
        if (response.statusCode == 200) {
          return (response.data as List)
              .map((x) => MatchListModel.fromJson(x))
              .toList();
        }
      });
      return data;
    } catch (e) {
      print("d");
      print(e);
    }
  }

  Future getMatchedprofiledata(userid) async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.get("/user/$userid/profile");
        print("get match user list data");
        print(response.data);
        final results = List<Map<String, dynamic>>.from(response.data);

        List<Responses> finaldata = results
            .map((hobbieData) => Responses.fromJson(hobbieData))
            .toList(growable: false);
        return Routes.sailor(Routes.detailPage,
            params: {"userDetails": finaldata[0]});
      });

      return data;
    } catch (e) {
      print("d");
      print(e);
    }
  }
}
