import 'package:firebase_auth/firebase_auth.dart';

class OtpModel {
  String value;
  String id;
  bool isMob;
  bool isSignUp;


  OtpModel({this.value,this.id,this.isMob,this.isSignUp});

  OtpModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    id = json['id'];
    isMob = json['isMob'];
    isSignUp = json['isSignUp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['id'] = this.id;
    data['isMob'] = this.isMob;
    data['isSignUp'] = this.isSignUp;
    return data;
  }
}
