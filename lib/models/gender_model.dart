import 'dart:convert';

class GenderModel {
  String id;
  String title;
  GenderModel({
    this.id,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory GenderModel.fromMap(Map<String, dynamic> map) {
    return GenderModel(
      id: map['_id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GenderModel.fromJson(String source) =>
      GenderModel.fromMap(json.decode(source));
}
