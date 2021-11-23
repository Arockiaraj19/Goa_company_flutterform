import 'dart:convert';

class ExpertChatGroup {
  String id;
  String title;
  String description;
  ExpertChatGroup({
    this.id,
    this.title,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'description': description,
    };
  }

  factory ExpertChatGroup.fromMap(Map<String, dynamic> map) {
    return ExpertChatGroup(
      id: map['_id'],
      title: map['title'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpertChatGroup.fromJson(String source) =>
      ExpertChatGroup.fromMap(json.decode(source));
}
