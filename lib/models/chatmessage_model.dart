import 'dart:convert';

class ChatMessage {
  String id;
  String groupid;
  String message;
  List<String> readByRecipients;
  List<Details> senderDetails;
  List<Details> receiverDetails;

  ChatMessage({
    this.id,
    this.groupid,
    this.message,
    this.readByRecipients,
    this.senderDetails,
    this.receiverDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupid': groupid,
      'message': message,
      'readByRecipients': readByRecipients,
      'senderDetails': senderDetails?.map((x) => x.toMap())?.toList(),
      'receiverDetails': receiverDetails?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      groupid: map['groupid'],
      message: map['message'],
      readByRecipients: List<String>.from(map['readByRecipients']),
      senderDetails: List<Details>.from(
          map['sender_details'].map((x) => Details.fromMap(x))),
      receiverDetails: List<Details>.from(
          map['receiver_details'].map((x) => Details.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));
}

class Details {
  String id;
  String firstname;
  String lastname;
  Details({
    this.id,
    this.firstname,
    this.lastname,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      id: map['_id'],
      firstname: map['first_name'],
      lastname: map['last_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Details.fromJson(String source) =>
      Details.fromMap(json.decode(source));
}
