import 'dart:convert';

import 'package:dating_app/models/chatgroup_model.dart';

class MatchUser {
  UserDetail user2;
  MatchUser({
    this.user2,
  });

  Map<String, dynamic> toMap() {
    return {
      'user2': user2.toMap(),
    };
  }

  factory MatchUser.fromMap(Map<String, dynamic> map) {
    return MatchUser(
      user2: UserDetail.fromMap(map['user_2_details']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchUser.fromJson(String source) =>
      MatchUser.fromMap(json.decode(source));
}
