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
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';

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
      throw e;
    }
  }
Future<UserModel> getSingleSuggestionData(String id) async {
    Response response;
    try {
      final _dio = apiClient();

      print("user id correct varuthaa");
      print(id);
      var data = await _dio.then((value) async {
        response = await value.get(userDetailsEndpoint + "/" + id);

        if (response.statusCode == 200) {
          return (response.data as List)
              .map((x) => UserModel.fromJson(x))
              .toList();
        }
      });
      return data[0];
    } catch (e) {
      print("front la catch kku data varuthu");
      throw e;
    }
  }

  Future<UserModel> getUserData() async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      print("user id correct varuthaa");
      print(id);
      var data = await _dio.then((value) async {
        response = await value.get(userDetailsEndpoint + "/" + id);

        if (response.statusCode == 200) {
          return (response.data as List)
              .map((x) => UserModel.fromJson(x))
              .toList();
        }
      });
      return data[0];
    } catch (e) {
      print("front la catch kku data varuthu");
      throw e;
    }
  }

  Future<List<Responses>> getUserSuggestionsData(
      bool apply, String age, distance, lat, lng, type, int skip) async {
    Response response;
    try {
      var query;
      if (true) {
        print("ll888888");
        query = {
          "age": age,
          "distance": distance,
          "longitude": lng,
          "latitude": lat,
          "type": type,
          "skip": skip * 2,
          "limit": 2,
        };
        Logger().e(query);
      }
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.get(
            userDetailsEndpoint + "/" + id + userSuggestionsEndpoint,
            queryParameters: query);
        print(response.requestOptions.queryParameters);

        final results =
            List<Map<String, dynamic>>.from(response.data["response"]);
        Logger().v(results);

        if (response.statusCode == 200) {
          return (results as List).map((x) => Responses.fromJson(x)).toList();
        }
      });
      return data;
    } catch (e) {
      throw e;
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
      throw e;
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
      throw e;
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
      throw e;
    }
  }

  Future<List<LikeListModel>> getUserLikeList(int skip) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.get(
            userDetailsEndpoint + "/" + id + userLikeListEndpoint,
            queryParameters: {
              "skip": skip * 20,
              "limit": 20,
            });
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
      throw e;
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
      throw e;
    }
  }

  Future<List<MatchListModel>> getUserMatchList(searchKey, int skip) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response =
            await value.get(userMatchListEndpoint + "/" + id, queryParameters: {
          "searchkey": searchKey,
          "skip": skip * 20,
          "limit": 20,
        });
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
      throw e;
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
        return Modular.to.pushNamed(
          Navigate.detailPage + "?id=${finaldata[0].id}",
        );

      });

      return data;
    } catch (e) {
      throw e;
    }
  }
}
