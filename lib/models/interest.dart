import 'dart:convert';

import 'package:dating_app/models/hobby.dart';




class InterestModel {
  String title;
  List<MainCategory> main_category_details;
  String interest_id;
  InterestModel({
    this.title,
    this.main_category_details,
    this.interest_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'main_category_details':
          main_category_details?.map((x) => x.toMap())?.toList().toString(),
      'interest_id': interest_id,
    };
  }

  factory InterestModel.fromMap(Map<String, dynamic> map) {
    return InterestModel(
      title: map['title'],
      main_category_details: List<MainCategory>.from(
          map['main_category_details']?.map((x) => MainCategory.fromMap(x))),
      interest_id: map['interest_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestModel.fromJson(String source) =>
      InterestModel.fromMap(json.decode(source));
}


class InterestUserModel {
  String title;
  String main_category_details;
  String interest_id;
  InterestUserModel({
    this.title,
    this.main_category_details,
    this.interest_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'main_category_details': main_category_details.toString(),
      'interest_id': interest_id,
    };
  }

  factory InterestUserModel.fromMap(Map<String, dynamic> map) {
    return InterestUserModel(
      title: map['title'],
      main_category_details: map['main_category_details'].toString(),
      interest_id: map['interest_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestUserModel.fromJson(String source) =>
      InterestUserModel.fromMap(json.decode(source));
}

