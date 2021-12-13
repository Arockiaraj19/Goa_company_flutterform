import 'dart:convert';

class ImageCheckModel {
  double safe;
  double unsafe;
  ImageCheckModel({
    this.safe,
    this.unsafe,
  });

  Map<String, dynamic> toMap() {
    return {
      'safe': safe,
      'unsafe': unsafe,
    };
  }

  factory ImageCheckModel.fromMap(Map<String, dynamic> map) {
    return ImageCheckModel(
      safe: map['safe']?.toDouble() ?? 0.0,
      unsafe: map['unsafe']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageCheckModel.fromJson(String source) =>
      ImageCheckModel.fromMap(json.decode(source));
}
