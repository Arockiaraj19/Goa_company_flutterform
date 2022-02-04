import 'package:dating_app/models/subscription_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/client/api_list.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';

import 'client/apiClient.dart';
import 'package:logger/logger.dart';

class Subscription {
  Future getSubscriptinPlans() async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.get(subscription_plan);
        print("response get all subscription plan   list");
        print(response.data);
        Logger().i(response.data);
        final results = List<Map<String, dynamic>>.from(response.data);

        List<SubscriptionModel> finaldata = results
            .map((mappingData) => SubscriptionModel.fromMap(mappingData))
            .toList(growable: false);
        return finaldata;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future getChecklistData() async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.get("/user/utils/subscriptionchecklists");
        print("response get all check list data");
        print(response.data);
        final results = List<Map<String, dynamic>>.from(response.data);

        List<ChecklistModel> finaldata = results
            .map((mappingData) => ChecklistModel.fromMap(mappingData))
            .toList(growable: false);
        return finaldata;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future getProfileCount() async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.get("/user/utils/profilevisitlimit");
        print("response profile count");
        print(response.data);
        return response.data.toString();
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future updateCount(type) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response =
            await value.patch("/user/profilevisit/" + id, queryParameters: {
          "type": type,
        });
        print("update count");
        print(response.data);

        if (response.statusCode == 200) {
          return (response.data as List)
              .map((x) => UserModel.fromJson(x))
              .toList();
        }
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future checkPlans() async {
    Response response;
    String userId = await getUserId();
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.get("/user/subscriptions/" + userId);
        print("response check plans ");
        print(response.data);
        if (response.data == null) {
          return response.data;
        }
        return response.data["plan"];
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future addPlan(
      String id, int validity, int durationType, int coins, String type) async {
    Response response;

    try {
      final _dio = apiClient();
      String userId = await getUserId();
      print(id.toString() +
          validity.toString() +
          durationType.toString() +
          coins.toString() +
          type.toString());
      var data = _dio.then((value) async {
        response = await value.post("/user/subscription", data: {
          "user": userId,
          "plan": id.toString(),
          "validity": validity.toString(),
          "duration_type": durationType.toString(),
          "payment_by_coins": coins.toString(),
          "subscription_type": type.toString()
        });
        print("response check plans ");
        print(response.data);
        return response.data;
      });
      return data;
    } catch (e) {
      print("error subscription page la fron la varuthaaa");
      throw e;
    }
  }
}
