import 'package:dating_app/models/hobby.dart';
import 'package:dating_app/models/user.dart';

import 'interest.dart';

class UsersSuggestionModel {
  List<Responses> response;

  UsersSuggestionModel({this.response});

  UsersSuggestionModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = new List<Responses>();
      json['response'].forEach((v) {
        response.add(new Responses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Responses {
  String id;
  Location location;
  String gender;
  List<dynamic> profileImage;
  List<dynamic> profession;
  List<String> interests;
  List<String> hobbies;
  bool isMobileVerified;
  bool isEmailVerified;
  String relationshipStatus;
  String bio;
  List<dynamic> religion;
  bool isBlocked;
  bool isDeleted;
  bool isDeactivated;
  int matchCount;
  int badCount;
  int age;
  String partnerType;
  int sexualOrientation;
  String email;
  String firstName;
  String lastName;
  String identificationImage;
  List<InterestUserModel> interestDetails;
  List<HobbyUserModel> hobbyDetails;
  bool isVerified;

  Responses(
      {this.id,
      this.location,
      this.gender,
      this.profileImage,
      this.profession,
      this.interests,
      this.hobbies,
      this.isMobileVerified,
      this.isEmailVerified,
      this.relationshipStatus,
      this.religion,
      this.isBlocked,
      this.bio,
      this.age,
      this.isDeleted,
      this.isDeactivated,
      this.matchCount,
      this.badCount,
      this.partnerType,
      this.sexualOrientation,
      this.email,
      this.firstName,
      this.lastName,
      this.identificationImage,
      this.interestDetails,
      this.hobbyDetails,
      this.isVerified});

  Responses.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    // gender = json['gender'].toString();
    profileImage = json['profile_image'];
    profession = json['profession'];
    hobbies = json['hobbies'].cast<String>();
    interests = json['interests'].cast<String>();
    isMobileVerified = json['is_mobile_verified'];
    isEmailVerified = json['is_email_verified'];
    relationshipStatus = json['relationship_status'];
    religion = json['religion'];
    bio = json['bio'];
    isBlocked = json['is_blocked'];
    isDeleted = json['is_deleted'];
    isDeactivated = json['is_deactivated'];
    age = json['age'];
    matchCount = json['match_count'];
    badCount = json['bad_count'];
    partnerType = json['partner_type'];
    sexualOrientation = json['sexual_orientation'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    identificationImage = json['identification_image'];
    interestDetails = json['interests_details'] == null
        ? []
        : List<InterestUserModel>.from(json['interests_details']
            ?.map((x) => InterestUserModel.fromMap(x)));
    hobbyDetails = json['hobbies_details'] == null
        ? []
        : List<HobbyUserModel>.from(
            json['hobbies_details']?.map((x) => HobbyUserModel.fromMap(x)));
    isVerified = json["is_user_verified"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    // data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['profession'] = this.profession;
    // if (this.interests != null) {
    //   data['interests'] = this.interests.map((v) => v.toJson()).toList();
    // }
    // if (this.hobbies != null) {
    //   data['hobbies'] = this.hobbies.map((v) => v.toJson()).toList();
    // }
    data['is_mobile_verified'] = this.isMobileVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['relationship_status'] = this.relationshipStatus;
    data['religion'] = this.religion;
    data['bio'] = this.bio;
    data['is_blocked'] = this.isBlocked;
    data['is_deleted'] = this.isDeleted;
    data['is_deactivated'] = this.isDeactivated;
    data['match_count'] = this.matchCount;
    data['bad_count'] = this.badCount;
    data['age'] = this.age;
    data['partner_type'] = this.partnerType;
    data['sexual_orientation'] = this.sexualOrientation;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['identification_image'] = this.identificationImage;
    return data;
  }
}
