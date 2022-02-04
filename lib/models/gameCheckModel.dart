import 'dart:convert';

class GameCheckModel {
  int score;
  GameCheckModel({
   this.score,
  });

  Map<String, dynamic> toMap() {
    return {
      'score': score,
    };
  }

  factory GameCheckModel.fromMap(Map<String, dynamic> map) {
    return GameCheckModel(
      score: map['score']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameCheckModel.fromJson(String source) => GameCheckModel.fromMap(json.decode(source));
}
