import 'dart:convert';

class GamesModel {
  bool isdeleted;
  String id;
  String gamename;
  GamesModel({
    this.isdeleted,
     this.id,
    this.gamename,
  });

  Map<String, dynamic> toMap() {
    return {
      'isdeleted': isdeleted,
      'id': id,
      'gamename': gamename,
    };
  }

  factory GamesModel.fromMap(Map<String, dynamic> map) {
    return GamesModel(
      isdeleted: map['is_deleted'],
      id: map['_id'],
      gamename: map['game_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GamesModel.fromJson(String source) => GamesModel.fromMap(json.decode(source));
}
