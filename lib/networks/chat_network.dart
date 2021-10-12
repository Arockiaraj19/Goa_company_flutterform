import 'package:dating_app/models/creategroup_model.dart';
import 'package:dating_app/networks/client/apiClient.dart';
import 'package:dating_app/networks/client/api_list.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';

class ChatNetwork {
  Future createGroup(String userid2) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.post(create_group, data: {
          "user_id_1": id,
          "user_id_2": userid2,
          "type": "personal",
          "user_details": "hello bro"
        });
        print("response create method");
        print(response.data["response"]);

        return response.data["response"]["_id"].toString();
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future createMessage(
      String receiverid, String message, String groupid) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.post(new_message, data: {
          "sender_id": id,
          "receiver_id": receiverid,
          "message": message,
          "image": "",
          "group_id": groupid
        });
        print("response create method");
        print(response.data);

        return;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }
}
