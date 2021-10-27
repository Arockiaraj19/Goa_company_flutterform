import 'dart:convert';

import 'package:dating_app/models/chatmessage_model.dart';
import 'package:dating_app/models/user.dart';

class ChatGroup {
  String id;
  String user_id_1;
  String user_id_2;
  String type;
  int chat_count;
  String chat_time;
  List<UserDetail> user_id_1_details;
  List<UserDetail> user_id_2_details;

  List<ChatMessage> chat_details;
  List<dynamic> block_details;
  ChatGroup({
    this.id,
    this.user_id_1,
    this.user_id_2,
    this.type,
    this.chat_count,
    this.chat_time,
    this.user_id_1_details,
    this.user_id_2_details,
    this.chat_details,
    this.block_details,
  });

  factory ChatGroup.fromMap(Map<String, dynamic> map) {
    return ChatGroup(
      id: map['_id'],
      user_id_1: map['user_id_1'],
      user_id_2: map['user_id_2'],
      type: map['type'],
      chat_count: map['chat_count'],
      chat_time: map['chat_time'],
      user_id_1_details: List<UserDetail>.from(
          map['user_id_1_details']?.map((x) => UserDetail.fromMap(x))),
      user_id_2_details: List<UserDetail>.from(
          map['user_id_2_details']?.map((x) => UserDetail.fromMap(x))),
      chat_details: List<ChatMessage>.from(
          map['chat_entries']?.map((x) => ChatMessage.fromMap(x))),
      block_details: List<dynamic>.from(map['block_details']),
    );
  }

  factory ChatGroup.fromJson(String source) =>
      ChatGroup.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id_1': user_id_1,
      'user_id_2': user_id_2,
      'type': type,
      'chat_count': chat_count,
      'chat_time': chat_time,
      'user_id_1_details': user_id_1_details?.map((x) => x.toMap())?.toList(),
      'user_id_2_details': user_id_2_details?.map((x) => x.toMap())?.toList(),
      'chat_details': chat_details?.map((x) => x.toMap())?.toList(),
      'block_details': block_details,
    };
  }

  String toJson() => json.encode(toMap());
}

class UserDetail {
  String firstname;
  String lastname;
  String userid;
  String identificationImage;

  UserDetail({
    this.firstname,
    this.lastname,
    this.userid,
    this.identificationImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'userid': userid,
      'identificationImage': identificationImage,
    };
  }

  factory UserDetail.fromMap(Map<String, dynamic> map) {
    return UserDetail(
      firstname: map['first_name'],
      lastname: map['last_name'],
      userid: map['user_id'],
      identificationImage: map['identification_image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetail.fromJson(String source) =>
      UserDetail.fromMap(json.decode(source));
}
