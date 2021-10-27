import 'package:dating_app/networks/client/api_list.dart';
import 'package:dio/dio.dart';

import 'client/apiClient.dart';

class Subscription {
  Future getSubscriptinPlans() async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.get(subscription_plan);
        print("response get all subscription plan   list");
        print(response.data);
      });
      return data;
    } catch (e) {
      print(e);
    }
  }
}
