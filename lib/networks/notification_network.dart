import 'package:dating_app/models/notification_model.dart';
import 'package:dating_app/networks/client/apiClient.dart';
import 'package:dio/dio.dart';

import 'sharedpreference/sharedpreference.dart';

class NotificationNetwork {
  Future<List<NotificationModel>> getData() async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = await _dio.then((value) async {
        response = await value.get("/user/notifications/" + id);
        print("notification data varuthaaa");
        print(response.data);
        final results = List<Map<String, dynamic>>.from(response.data);

        List<NotificationModel> finaldata = results
            .map((mappingData) => NotificationModel.fromMap(mappingData))
            .toList(growable: false);
        return finaldata;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> deleteData(List<String> deleteid) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = await _dio.then((value) async {
        response = await value.patch("/user/notificationstatus/" + id, data: {
          "notifications": deleteid,
        });

        return true;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }
}
