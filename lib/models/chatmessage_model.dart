import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'chatmessage_model.g.dart';

@HiveType(typeId: 1)
class ChatMessage {
  @HiveField(0)
  String id;
  @HiveField(1)
  String groupid;
  @HiveField(2)
  String message;
  @HiveField(3)
  List<String> readByRecipients;
  @HiveField(4)
  List<Details> senderDetails;
  @HiveField(5)
  List<Details> receiverDetails;
  @HiveField(6)
  DateTime createdAt;
  @HiveField(7)
  DateTime updatedAt;
  @HiveField(8)
  List<String> images;
  @HiveField(9)
  ChatMessage(
      {this.id,
      this.groupid,
      this.message,
      this.readByRecipients,
      this.senderDetails,
      this.receiverDetails,
      this.createdAt,
      this.updatedAt,
      this.images});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupid': groupid,
      'message': message,
      'readByRecipients': readByRecipients,
      'senderDetails': senderDetails?.map((x) => x.toMap())?.toList(),
      'receiverDetails': receiverDetails?.map((x) => x.toMap())?.toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
        id: map['_id'],
        groupid: map['group_id'],
        message: map['message'],
        readByRecipients: List<String>.from(map['readByRecipients']),
        senderDetails: map['sender_details'] != null
            ? List<Details>.from(
                map['sender_details']?.map((x) => Details.fromMap(x)))
            : null,
        receiverDetails: map['receiver_details'] != null
            ? List<Details>.from(
                map['receiver_details']?.map((x) => Details.fromMap(x)))
            : null,
        createdAt: DateTime.parse(map['createdAt'].toString()).toLocal(),
        updatedAt: DateTime.parse(map['updatedAt'].toString()).toLocal(),
        images: map["image"] == null ? [] : List<String>.from(map["image"]));
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));
}

@HiveType(typeId: 2)
class Details {
  @HiveField(0)
  String id;
  @HiveField(1)
  String firstname;
  @HiveField(2)
  String lastname;
  @HiveField(3)
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
      firstname: map['firstname'],
      lastname: map['lastname'],
      userId: map['user_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Details.fromJson(String source) =>
      Details.fromMap(json.decode(source));
}
