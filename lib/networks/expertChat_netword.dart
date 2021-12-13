import 'package:dating_app/models/expertChatGroupCato_model.dart';
import 'package:dating_app/models/expertGroup_model.dart';
import 'package:dating_app/models/expertchatmessage_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/client/apiClient.dart';

import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';

class ExpertNetwork {
  Future createGroup(String expertid, UserModel userdata) async {
    print("user data correct a varuthaa");
    print(userdata.firstName);
    print(expertid);

    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      print("user Id" + id);
      var data = _dio.then((value) async {
        response = await value.post("/chats/expertgroup", data: {
          "user_id": id,
          "expert_id": expertid,
          "type": "personal",
          "user_details": userdata,
        });
        print("group aakuthaa  create method");
        print(response.data);

        return response.data["response"]["_id"].toString();
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future createMessage(String receiverid, String message, String groupid,
      List<String> image) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      print("user id");
      print(id);
      var data = _dio.then((value) async {
        response = await value.post("/user/expertchats/entry", data: {
          "sender_id": id,
          "receiver_id": receiverid,
          "message": message,
          "group_id": groupid,
          "user_id": id,
          "image": image,
          "expert_id": receiverid,
          "user_type": "2",
        });
        print("response message method");
        print(response.data);

        return;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future getGrouplist(String id, String searchKey) async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.get("/user/vendorexpertlists", queryParameters: {
          "skip": 0,
          "limit": 200,
          "chat_category": id,
          "searchkey": searchKey
        });
        final results = List<Map<String, dynamic>>.from(response.data);
        print("get group data");
        print(response.data);
        List<ExpertGroup> chatgroups =
            results.map((movieData) => ExpertGroup.fromMap(movieData)).toList();

        return chatgroups;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future getGroupCatolist() async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      print("user id");
      print(id);
      var data = _dio.then((value) async {
        response = await value.get("/user/utils/expertchatcategories");

        print("response group cato");
        print(response.data);
        final results = List<Map<String, dynamic>>.from(response.data);
        print(response.data);
        List<ExpertChatGroup> chatgroups = results
            .map((movieData) => ExpertChatGroup.fromMap(movieData))
            .toList();
        print("group list correct a varuthaa");

        return chatgroups;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future getMessagelist(String groupId) async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response =
            await value.get("/user/expertchats/$groupId", queryParameters: {
          "skip": 0,
          "limit": 200,
        });
        print("response message  list");
        print(response.data);
        final results = List<Map<String, dynamic>>.from(response.data);
        // print("response message last ");
        // print(results[results.length - 1]);
        // print("response message last munthunathu");
        // print(results[results.length - 2]);

        List<ExpertChatMessage> chatmessage = results
            .map((movieData) => ExpertChatMessage.fromMap(movieData))
            .toList(growable: false);

        return chatmessage;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }
}
