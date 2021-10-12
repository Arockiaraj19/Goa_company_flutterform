import 'dart:convert';

class CreateGroup {
  String id;
  CreateGroup({
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory CreateGroup.fromMap(Map<String, dynamic> map) {
    return CreateGroup(
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateGroup.fromJson(String source) =>
      CreateGroup.fromMap(json.decode(source));
}
