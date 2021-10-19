import 'dart:convert';

class ImageModel {
  String uploadUrl;
  String viewUrl;
  ImageModel({
    this.uploadUrl,
     this.viewUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uploadUrl': uploadUrl,
      'viewUrl': viewUrl,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      uploadUrl: map['uploadUrl'],
      viewUrl: map['viewUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) => ImageModel.fromMap(json.decode(source));
}
