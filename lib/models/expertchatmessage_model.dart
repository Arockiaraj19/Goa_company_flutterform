import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'chatmessage_model.dart';
part 'expertchatmessage_model.g.dart';

@HiveType(typeId: 3)
class ExpertChatMessage {
  @HiveField(0)
  String id;
  @HiveField(1)
  String userid;
  @HiveField(2)
  String expertid;
  @HiveField(3)
  String groupid;
  @HiveField(4)
  String message;
  @HiveField(5)
  List<String> readByRecipients;
  @HiveField(6)
  List<Details> venderDetails;
  @HiveField(7)
  DateTime createdAt;
  @HiveField(8)
  DateTime updatedAt;
  @HiveField(9)
  List<String> images;
  @HiveField(10)
  String userType;
  ExpertChatMessage(
      {this.id,
      this.userid,
      this.expertid,
      this.groupid,
      this.message,
      this.readByRecipients,
      this.venderDetails,
      this.createdAt,
      this.updatedAt,
      this.images,
      this.userType});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupid': groupid,
      'message': message,
      'readByRecipients': readByRecipients,
      'receiverDetails': venderDetails?.map((x) => x.toMap())?.toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ExpertChatMessage.fromMap(Map<String, dynamic> map) {
    return ExpertChatMessage(
        id: map['_id'],
        userid: map["user_id"],
        expertid: map["expert_id"],
        groupid: map['group_id'],
        message: map['message'],
        readByRecipients: List<String>.from(map['readByRecipients']),
        venderDetails: map['vendor_details'] != null
            ? List<Details>.from(
                map['vendor_details']?.map((x) => Details.fromMap(x)))
            : null,
        createdAt: DateTime.parse(map['createdAt'].toString()).toLocal(),
        updatedAt: DateTime.parse(map['updatedAt'].toString()).toLocal(),
        images: map["image"] == null ? [] : List<String>.from(map["image"]),
        userType: map["user_type"].toString());
  }

  String toJson() => json.encode(toMap());

  factory ExpertChatMessage.fromJson(String source) =>
      ExpertChatMessage.fromMap(json.decode(source));
}
