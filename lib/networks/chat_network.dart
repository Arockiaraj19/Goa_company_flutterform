import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/models/chatmessage_model.dart';
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

  Future getGrouplist() async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      print("user id");
      print(id);
      var data = _dio.then((value) async {
        response = await value.get("/chats/$id/grouplists", queryParameters: {
          "skip": 0,
          "limit": 200,
        });
        final results = List<Map<String, dynamic>>.from(response.data);
        print(response.data);
        List<ChatGroup> chatgroups = results
            .map((movieData) => ChatGroup.fromMap(movieData))
            .toList(growable: false);
        print("group list correct a varuthaa");
        print(chatgroups[0].id);
        return chatgroups;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future getMessagelist(String groupId) async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.get("/chats/$groupId", queryParameters: {
          "skip": 0,
          "limit": 200,
        });
        print("response message  list");
        print(response.data);
        final results = List<Map<String, dynamic>>.from(response.data);

        List<ChatMessage> chatmessage = results
            .map((movieData) => ChatMessage.fromMap(movieData))
            .toList(growable: false);

        return chatmessage;
      });
      return data;
    } catch (e) {
      print(e);
    }
  }
}
