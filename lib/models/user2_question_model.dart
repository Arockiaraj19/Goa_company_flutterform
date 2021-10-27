import 'dart:convert';

import 'question_model.dart';

class User2Question {
  String playid;
  List<Getquestion> questions;
  User2Question({
    this.playid,
    this.questions,
  });

  Map<String, dynamic> toMap() {
    return {
      'playid': playid,
      'questions': questions?.map((x) => x.toMap())?.toList(),
    };
  }

  factory User2Question.fromMap(String id, List<Getquestion> question) {
    return User2Question(
      playid: id,
      questions: question,
    );
  }

  String toJson() => json.encode(toMap());


}
