import 'dart:convert';

import 'question_model.dart';

class User2Question {
  String playid;
  List<Getquestion> questions;
  String id;
  User2Question({
    this.playid,
    this.questions,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'playid': playid,
      'questions': questions?.map((x) => x.toMap())?.toList(),
    };
  }

  factory User2Question.fromMap(
      String id, List<Getquestion> question, String qid) {
    return User2Question(playid: id, questions: question, id: qid);
  }

  String toJson() => json.encode(toMap());
}
