import 'dart:convert';

class ResponseForgetOtp {
  String msg;
  String user_id;
  String email;
  ResponseForgetOtp({
    this.msg,
    this.user_id,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'msg': msg,
      'user_id': user_id,
      'email': email,
    };
  }

  factory ResponseForgetOtp.fromMap(Map<String, dynamic> map) {
    return ResponseForgetOtp(
      msg: map['msg'],
      user_id: map['user_id'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseForgetOtp.fromJson(String source) =>
      ResponseForgetOtp.fromMap(json.decode(source));
}

class ResponseSubmitOtp {
  String msg;
  String email;
  String otp_id;
  String user_id;
  ResponseSubmitOtp({
     this.msg,
     this.email,
    this.otp_id,
    this.user_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'msg': msg,
      'email': email,
      'otp_id': otp_id,
      'user_id': user_id,
    };
  }

  factory ResponseSubmitOtp.fromMap(Map<String, dynamic> map) {
    return ResponseSubmitOtp(
      msg: map['msg'],
      email: map['email'],
      otp_id: map['otp_id'],
      user_id: map['user_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseSubmitOtp.fromJson(String source) => ResponseSubmitOtp.fromMap(json.decode(source));
}
