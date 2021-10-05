class ResponseData {
  String msg;
  String id;
  String date;
  int statusDetails;


  ResponseData({this.msg, this.id, this.date, this.statusDetails});

  ResponseData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    id = json["_id"];
    date = json["updatedAt"];
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
