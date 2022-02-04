import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';


part 'expertGroup_model.g.dart';

@HiveType(typeId: 4)
class ExpertGroup {
  @HiveField(0)
  String id;
  @HiveField(1)
  String firstname;
  @HiveField(2)
  String lastname;
  @HiveField(3)
  int onlinestatus;
  @HiveField(4)
  List<String> profileImage;
  ExpertGroup(
      {this.id,
      this.firstname,
      this.lastname,
      this.onlinestatus,
      this.profileImage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'onlinestatus': onlinestatus,
    };
  }

  factory ExpertGroup.fromMap(Map<String, dynamic> map) {
    return ExpertGroup(
        id: map['_id'],
        firstname: map['first_name'],
        lastname: map['last_name'],
        onlinestatus: map['online_status'],
        profileImage: map["profile_images"] == null
            ? []
            : List<String>.from(map["profile_images"]));
  }

  String toJson() => json.encode(toMap());

  factory ExpertGroup.fromJson(String source) =>
      ExpertGroup.fromMap(json.decode(source));
}
