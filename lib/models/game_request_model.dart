import 'dart:convert';

class GameRequest {
  String id;
  GameRequest({
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory GameRequest.fromMap(Map<String, dynamic> map) {
    return GameRequest(
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GameRequest.fromJson(String source) =>
      GameRequest.fromMap(json.decode(source));
}
