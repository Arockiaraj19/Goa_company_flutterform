import 'package:dating_app/models/user.dart';

class MatchListModel {
  String id;
  bool isMatched;
  int gameScore;
  int matchScore;
  bool isDeleted;
  String requestedUser;
  String confirmedUser;
  String requestedDevice;
  String createdAt;
  String updatedAt;
  int matchNo;
  int iV;
  String unmatchedDate;
  String unmatchedUser;
  List<UserDetails> userDetails;

  MatchListModel(
      {this.id,
      this.isMatched,
      this.gameScore,
      this.matchScore,
      this.isDeleted,
      this.requestedUser,
      this.confirmedUser,
      this.requestedDevice,
      this.createdAt,
      this.updatedAt,
      this.matchNo,
      this.iV,
      this.unmatchedDate,
      this.unmatchedUser,
      this.userDetails});

  MatchListModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    isMatched = json['is_matched'];
    gameScore = json['game_score'];
    matchScore = json['match_score'];
    isDeleted = json['is_deleted'];
    requestedUser = json['requested_user'];
    confirmedUser = json['confirmed_user'];
    requestedDevice = json['requested_device'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    matchNo = json['match_no'];
    iV = json['__v'];
    unmatchedDate = json['unmatched_date'];
    unmatchedUser = json['unmatched_user'];
    if (json['user_details'] != null) {
      userDetails = new List<UserDetails>();
      json['user_details'].forEach((v) {
        userDetails.add(new UserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['is_matched'] = this.isMatched;
    data['game_score'] = this.gameScore;
    data['match_score'] = this.matchScore;
    data['is_deleted'] = this.isDeleted;
    data['requested_user'] = this.requestedUser;
    data['confirmed_user'] = this.confirmedUser;
    data['requested_device'] = this.requestedDevice;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['match_no'] = this.matchNo;
    data['__v'] = this.iV;
    data['unmatched_date'] = this.unmatchedDate;
    data['unmatched_user'] = this.unmatchedUser;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDetails {
  String sId;
  Location location;
  String gender;
  List<dynamic> profileImage;
  List<dynamic> profession;
  List<dynamic> interests;
  List<dynamic> hobbies;
  String relationshipStatus;
  List<String> religion;
  bool isBlocked;
  bool isDeleted;
  bool isDeactivated;
  int matchCount;
  int badCount;
  String userId;
  String firstName;
  String lastName;
  String mobileNumber;
  int sexualOrientation;
  String createdAt;
  String updatedAt;
  int iV;
  String dob;

  UserDetails(
      {this.sId,
      this.location,
      this.gender,
      this.profileImage,
      this.profession,
      this.interests,
      this.hobbies,
      this.relationshipStatus,
      this.religion,
      this.isBlocked,
      this.isDeleted,
      this.isDeactivated,
      this.matchCount,
      this.badCount,
      this.userId,
      this.firstName,
      this.lastName,
      this.mobileNumber,
      this.sexualOrientation,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.dob});

  UserDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    gender = json['gender'].toString();
    profileImage = json['profile_image'] == null
        ? null
        : json['profile_image'].cast<String>();
    profession =
        json['profession'] == null ? null : json['profession'].cast<String>();
    interests =
        json['interests'] == null ? null : json['interests'].cast<String>();
    hobbies = json['hobbies'] == null ? null : json['hobbies'].cast<String>();
    relationshipStatus = json['relationship_status'];
    religion =
        json['religion'] == null ? null : json['religion'].cast<String>();
    isBlocked = json['is_blocked'];
    isDeleted = json['is_deleted'];
    isDeactivated = json['is_deactivated'];
    matchCount = json['match_count'];
    badCount = json['bad_count'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    sexualOrientation = json['sexual_orientation'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['profession'] = this.profession;
    data['interests'] = this.interests;
    data['hobbies'] = this.hobbies;
    data['relationship_status'] = this.relationshipStatus;
    data['religion'] = this.religion;
    data['is_blocked'] = this.isBlocked;
    data['is_deleted'] = this.isDeleted;
    data['is_deactivated'] = this.isDeactivated;
    data['match_count'] = this.matchCount;
    data['bad_count'] = this.badCount;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_number'] = this.mobileNumber;
    data['sexual_orientation'] = this.sexualOrientation;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['dob'] = this.dob;
    return data;
  }
}
