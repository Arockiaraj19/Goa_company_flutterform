import 'dart:convert';

class ResponseData {
  String msg;
  String id;
  DateTime date;
  int statusDetails;

  ResponseData({this.msg, this.id, this.date, this.statusDetails});

  ResponseData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    id = json["_id"];
    date = DateTime.parse(json["updatedAt"].toString()).toLocal();
    statusDetails = json['status_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['_id'] = this.id;
    data['updatedAt'] = this.date;
    data['status_details'] = this.statusDetails;
    return data;
  }
}




class ResponseData2 {
  String msg;
  String path;

  ResponseData2({this.msg, this.path});

  ResponseData2.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['path'] = this.path;
    return data;
  }
}

class Responsestorageimage {
  String uploadUrl;
  String downloadUrl;
  Responsestorageimage({
    this.uploadUrl,
    this.downloadUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uploadUrl': uploadUrl,
      'downloadUrl': downloadUrl,
    };
  }

  factory Responsestorageimage.fromMap(Map<String, dynamic> map) {
    return Responsestorageimage(
      uploadUrl: map['uploadUrl'],
      downloadUrl: map['downloadUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Responsestorageimage.fromJson(String source) =>
      Responsestorageimage.fromMap(json.decode(source));
}
