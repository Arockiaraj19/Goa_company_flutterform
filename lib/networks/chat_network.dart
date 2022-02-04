import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/models/chatmessage_model.dart';
import 'package:dating_app/models/creategroup_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/client/apiClient.dart';
import 'package:dating_app/networks/client/api_list.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dio/dio.dart';

class ChatNetwork {
  Future createGroup(String userid2, UserModel userdata) async {
    print("user data correct a varuthaa");
    print(userdata);
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.post(create_group, data: {
          "user_id_1": id,
          "user_id_2": userid2,
          "type": "personal",
          "user_details": userdata,
        });
        print("response create method");
        print(response.data["response"]);

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
      var data = _dio.then((value) async {
        response = await value.post(new_message, data: {
          "sender_id": id,
          "receiver_id": receiverid,
          "message": message,
          "image": image,
          "group_id": groupid
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

  Future getGrouplist(String searchKeyWord, int skip) async {
    Response response;
    try {
      final _dio = apiClient();
      String id = await getUserId();
      print("user id");
      print(id);
      print(skip.toString());
      var data = _dio.then((value) async {
        response = await value.get("/chats/$id/grouplists", queryParameters: {
          "skip": skip * 20,
          "limit": 20,
          "searchkey": searchKeyWord,
        });
        final results = List<Map<String, dynamic>>.from(response.data);
        print("get group data");
        print(response.data);
        List<ChatGroup> chatgroups =
            results.map((movieData) => ChatGroup.fromMap(movieData)).toList();
        print("group list correct a varuthaa");

        return chatgroups;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future getMessagelist(String groupId, int skip) async {
    Response response;
    print(" skip id enna varuthu");
    print(skip);
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.get("/chats/$groupId", queryParameters: {
          "skip": skip,
          "limit": 20,
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
      throw e;
    }
  }

  Future<bool> blockuser(
      String user1, String user2, String groupid, bool isblocked) async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.patch(block_user, data: {
          "blocking_user": user1,
          "blocked_user": user2,
          "group_id": groupid,
          "is_blocked": isblocked //true or false
        });
        print("response message  block user");
        print(response.data);
        return true;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future getblocklist() async {
    Response response;
    try {
      final _dio = apiClient();
      final id = await getUserId();
      var data = _dio.then((value) async {
        response = await value.get("/user/$id/chatblocklists");
        print("response get block   list");
        print(response.data);
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> updateUserCount() async {
    Response response;
    try {
      final _dio = apiClient();
      String userId = await getUserId();
      var data = _dio.then((value) async {
        response = await value.patch("/user/daychatcount/" + userId,
            queryParameters: {"type": "1"});
        print("response chat update");
        print(response.data);
        return true;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future patchUnreadMessage(String groupId) async {
    Response response;
    try {
      final _dio = apiClient();
      String userId = await getUserId();
      var data = _dio.then((value) async {
        response = await value.patch("/user/chatreadstatus", data: {
          "group_id": groupId,
          "user_id": userId,
        });
        print("response patch unreadmessage");
        print(response.data);

        return;
      });
      return data;
    } catch (e) {
      throw e;
    }
  }
}
