import 'dart:convert';

import 'package:dating_app/pages/notification/notification_page.dart';

class NotificationModel {
  List<String> receiver;
  String content;
  bool status;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  NotificationUserModel sender;
  String header;
  NotificationModel(
      {this.receiver,
      this.content,
      this.status,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.sender,
      this.header});

  Map<String, dynamic> toMap() {
    return {
      'receiver': receiver,
      'content': content,
      'status': status,
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'sender': sender.toMap(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      receiver: List<String>.from(map['receiver']),
      content: map['content'],
      status: map['read_status'],
      id: map['_id'],
      createdAt: DateTime.parse(map['createdAt'].toString()).toLocal(),
      updatedAt: DateTime.parse(map['updatedAt'].toString()).toLocal(),
      sender: map["sender"] == null
          ? null
          : NotificationUserModel.fromMap(map['sender']),
      header: map['header'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}

class NotificationUserModel {
  List<String> profileImage;
  String id;
  String firstname;
  String lastname;
  String identificationImage;
  NotificationUserModel({
    this.profileImage,
    this.id,
    this.firstname,
    this.lastname,
    this.identificationImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage,
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'identificationImage': identificationImage,
    };
  }

  factory NotificationUserModel.fromMap(Map<String, dynamic> map) {
    return NotificationUserModel(
      profileImage: List<String>.from(map['profile_image']),
      id: map['_id'],
      firstname: map['first_name'],
      lastname: map['last_name'],
      identificationImage: map['identification_image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationUserModel.fromJson(String source) =>
      NotificationUserModel.fromMap(json.decode(source));
}
