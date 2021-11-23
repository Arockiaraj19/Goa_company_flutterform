import 'dart:convert';

import 'package:flutter/foundation.dart';

class ExpertChatMessage {
  String id;
  String userid;
  String expertid;
  String groupid;
  String message;
  List<String> readByRecipients;

  List<Details> venderDetails;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> images;
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

class Details {
  String id;
  String firstname;
  String lastname;
  String userId;
  Details({
    this.id,
    this.firstname,
    this.lastname,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'userId': userId,
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      id: map['_id'],
      firstname: map['first_name'],
      lastname: map['last_name'],
      userId: map['vender_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Details.fromJson(String source) =>
      Details.fromMap(json.decode(source));
}
