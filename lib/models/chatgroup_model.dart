import 'dart:convert';

import 'package:dating_app/models/user.dart';

class ChatGroup {
  String id;
  String user_id_1;
  String user_id_2;
  String type;
  int chat_count;
  String chat_time;
  List<UserModel> user_id_2_details;
  ChatGroup({
    this.id,
    this.user_id_1,
    this.user_id_2,
    this.type,
    this.chat_count,
    this.chat_time,
    this.user_id_2_details,
  });

  factory ChatGroup.fromMap(Map<String, dynamic> map) {
    return ChatGroup(
      id: map['_id'],
      user_id_1: map['user_id_1'],
      user_id_2: map['user_id_2'],
      type: map['type'],
      chat_count: map['chat_count'],
      chat_time: map['chat_time'],
      user_id_2_details: List<UserModel>.from(
          map['user_id_2_details']?.map((x) => UserModel.fromJson(x))),
    );
  }

  factory ChatGroup.fromJson(String source) =>
      ChatGroup.fromMap(json.decode(source));
}
