class InterestModel {
  String id;
  String title;

  InterestModel({this.id, this.title});

  InterestModel.fromJson(Map<String, dynamic> json) {
    id = json['interest_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interest_id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
