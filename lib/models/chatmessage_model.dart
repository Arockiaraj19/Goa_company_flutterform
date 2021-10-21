import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChatMessage {
  String id;
  String groupid;
  String message;
  List<String> readByRecipients;
  List<Details> senderDetails;
  List<Details> receiverDetails;
  DateTime createdAt;
  DateTime updatedAt;

  ChatMessage({
    this.id,
    this.groupid,
    this.message,
    this.readByRecipients,
    this.senderDetails,
    this.receiverDetails,
    this.createdAt,
    this.updatedAt,
  });

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
      createdAt: DateTime.parse(map['createdAt'].toString()),
      updatedAt: DateTime.parse(map['updatedAt'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));
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
      id: map['id'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      userId: map['user_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Details.fromJson(String source) =>
      Details.fromMap(json.decode(source));
}
