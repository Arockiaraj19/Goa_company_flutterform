import 'dart:convert';

class HobbyModel {
  String title;
  List<MainCategory> main_category_details;
  String hobby_id;
  HobbyModel({
    this.title,
    this.main_category_details,
    this.hobby_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'main_category_details':
          main_category_details?.map((x) => x.toMap())?.toList().toString(),
      'hobby_id': hobby_id,
    };
  }

  factory HobbyModel.fromMap(Map<String, dynamic> map) {
    return HobbyModel(
      title: map['title'],
      main_category_details: List<MainCategory>.from(
          map['main_category_details']?.map((x) => MainCategory.fromMap(x))),
      hobby_id: map['hobby_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HobbyModel.fromJson(String source) =>
      HobbyModel.fromMap(json.decode(source));
}

class MainCategory {
  String id;
  String title;
  MainCategory({
    this.id,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory MainCategory.fromMap(Map<String, dynamic> map) {
    return MainCategory(
      id: map['_id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MainCategory.fromJson(String source) =>
      MainCategory.fromMap(json.decode(source));
}

class HobbyUserModel {
  String title;
  String main_category_details;
  String hobby_id;
  HobbyUserModel({
    this.title,
    this.main_category_details,
    this.hobby_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'main_category_details': main_category_details.toString(),
      'hobby_id': hobby_id,
    };
  }

  factory HobbyUserModel.fromMap(Map<String, dynamic> map) {
    return HobbyUserModel(
      title: map['title'],
      main_category_details: map['main_category_details'].toString(),
      hobby_id: map['hobby_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HobbyUserModel.fromJson(String source) =>
      HobbyUserModel.fromMap(json.decode(source));
}


