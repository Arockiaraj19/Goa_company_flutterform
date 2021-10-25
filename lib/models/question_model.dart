import 'dart:convert';

class Getquestion {
  int type;
  bool isDeleted;
  bool isBlocked;
  String id;
  String game;
  String question;
  int questionNo;
  String option1;
  String option2;
  String option3;
  String option4;
  DateTime createdAt;
  DateTime updatedAt;
  Getquestion({
    this.type,
    this.isDeleted,
    this.isBlocked,
    this.id,
    this.game,
    this.question,
    this.questionNo,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'isDeleted': isDeleted,
      'isBlocked': isBlocked,
      'id': id,
      'game': game,
      'question': question,
      'questionNo': questionNo,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Getquestion.fromMap(Map<String, dynamic> map) {
    return Getquestion(
      type: map['type'],
      isDeleted: map['is_deleted'],
      isBlocked: map['is_blocked'],
      id: map['_id'],
      game: map['game'],
      question: map['question'],
      questionNo: map['question_no'],
      option1: map['option_1'],
      option2: map['option_2'],
      option3: map['option_3'],
      option4: map['option_4'],
      createdAt: DateTime.parse(map['createdAt'].toString()).toLocal(),
      updatedAt: DateTime.parse(map['updatedAt'].toString()).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Getquestion.fromJson(String source) =>
      Getquestion.fromMap(json.decode(source));
}
