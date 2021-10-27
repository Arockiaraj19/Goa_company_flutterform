import 'dart:convert';

class CheckRequestModel {
  String id;
  String gameId;
  List<String> questions;
  CheckRequestModel({
    this.id,
    this.gameId,
    this.questions,
  });



  factory CheckRequestModel.fromMap(Map<String, dynamic> map) {
    return CheckRequestModel(
      id: map['_id'],
      gameId: map['game_id'],
      questions: List<String>.from(map['questions']),
    );
  }



}
