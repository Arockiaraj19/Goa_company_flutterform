class HobbyModel {
  String id;
  String title;

  HobbyModel({this.id, this.title});

  HobbyModel.fromJson(Map<String, dynamic> json) {
    id = json['hobby_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hobby_id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
