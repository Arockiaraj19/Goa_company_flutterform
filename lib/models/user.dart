import 'package:dating_app/models/interest.dart';

import 'hobby.dart';

class UserModel {
  String id;
  Location location;
  List<String> profileImage;
  List<String> profession;
  List<InterestUserModel> interestDetails;
  List<HobbyUserModel> hobbyDetails;
  List<String> hobbies;
  List<String> interests;
  bool isMobileVerified;
  bool isEmailVerified;
  List<String> religion;
  bool isBlocked;
  bool isDeleted;
  bool isDeactivated;
  int matchCount;
  int badCount;
  int height;
  int weight;
  String email;
  String dob;
  String bio;
  String firstName;
  String gender;
  String lastName;
  int sexualOrientation;
  String partnerType;
  String identificationImage;
  int onboardDetailsStatus;
  String userReferralCode;
  int ageInMillis;
  int age;
  int likeCount;
  int score;
  String facebookName;
  String facebookId;
  String coin;
  bool isVerified;
  int subCount;
  DateTime chatCountUpdate;
  String verificationImage;

  UserModel({
    this.id,
    this.location,
    this.profileImage,
    this.profession,
    this.interestDetails,
    this.hobbyDetails,
    this.hobbies,
    this.interests,
    this.isMobileVerified,
    this.isEmailVerified,
    this.religion,
    this.isBlocked,
    this.isDeleted,
    this.isDeactivated,
    this.matchCount,
    this.height,
    this.weight,
    this.badCount,
    this.email,
    this.dob,
    this.bio,
    this.firstName,
    this.gender,
    this.lastName,
    this.sexualOrientation,
    this.partnerType,
    this.identificationImage,
    this.onboardDetailsStatus,
    this.userReferralCode,
    this.ageInMillis,
    this.age,
    this.likeCount,
    this.score,
    this.facebookName,
    this.facebookId,
    this.coin,
    this.isVerified,
    this.subCount,
    this.chatCountUpdate,
    this.verificationImage,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    profileImage = json['profile_image'] != null
        ? json['profile_image'].cast<String>()
        : null;
    profession = json['profession'].cast<String>();
    hobbies = json['hobbies'].cast<String>();
    interests = json['interests'].cast<String>();
    interestDetails = json['interests_details'] == null
        ? []
        : List<InterestUserModel>.from(json['interests_details']
            ?.map((x) => InterestUserModel.fromMap(x)));
    hobbyDetails = json['hobbies_details'] == null
        ? []
        : List<HobbyUserModel>.from(
            json['hobbies_details']?.map((x) => HobbyUserModel.fromMap(x)));

    isMobileVerified = json['is_mobile_verified'];
    isEmailVerified = json['is_email_verified'];
    religion = json['religion'].cast<String>();
    isBlocked = json['is_blocked'];
    isDeleted = json['is_deleted'];
    isDeactivated = json['is_deactivated'];
    matchCount = json['match_count'];
    height = json['height'];
    weight = json['weight'];
    badCount = json['bad_count'];
    email = json['email'];
    dob = json['dob'].toString();
    bio = json['bio'];
    firstName = json['first_name'] != null ? json['first_name'] : null;
    gender = json['gender'].toString();
    lastName = json['last_name'];
    sexualOrientation =
        json['sexual_orientation'] != null ? json['sexual_orientation'] : null;
    partnerType = json['partner_type'] != null ? json['partner_type'] : null;
    identificationImage = json['identification_image'];
    onboardDetailsStatus = json['onboard_details_status'];
    userReferralCode = json['user_referral_code'];
    ageInMillis = json['ageInMillis'];
    age = json['age'];
    likeCount = json['like_count'];
    score = json['score'];
    facebookName = json["facebook_username"];
    facebookId = json["facebook_link"];
    coin = json["coin_value"].toString();
    isVerified = json["is_user_verified"];
    subCount = json["profile_visit_count"];
    chatCountUpdate =
        DateTime.parse(json['chat_count_update'].toString()).toLocal();
    verificationImage = json['verification_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['profile_image'] = this.profileImage;
    data['profession'] = this.profession;
    data['interests'] = this.interests;
    data['hobbies'] = this.hobbies;
    if (this.interestDetails != null) {
      data['interests_details'] =
          this.interestDetails.map((v) => v.toJson()).toList();
    }
    if (this.hobbyDetails != null) {
      data['hobbies_details'] =
          this.hobbyDetails.map((v) => v.toJson()).toList();
    }
    data['is_mobile_verified'] = this.isMobileVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['religion'] = this.religion;
    data['is_blocked'] = this.isBlocked;
    data['is_deleted'] = this.isDeleted;
    data['is_deactivated'] = this.isDeactivated;
    data['match_count'] = this.matchCount;
    data['bad_count'] = this.badCount;
    data['email'] = this.email;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['dob'] = this.dob;
    data['bio'] = this.bio;
    data['first_name'] = this.firstName;
    data['gender'] = this.gender;
    data['last_name'] = this.lastName;
    data['sexual_orientation'] = this.sexualOrientation;
    data['partner_type'] = this.partnerType;
    data['identification_image'] = this.identificationImage;
    data['onboard_details_status'] = this.onboardDetailsStatus;
    data['user_referral_code'] = this.userReferralCode;
    data['ageInMillis'] = this.ageInMillis;
    data['age'] = this.age;
    data['like_count'] = this.likeCount;
    data['score'] = this.score;
    return data;
  }
}

class Location {
  String type;
  List<double> coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates =
        (json['coordinates'] as List).map((e) => e as double).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
