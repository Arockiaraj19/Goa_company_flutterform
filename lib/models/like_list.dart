class LikeListModel {
  String id;
  List<LikedUser> likedUser;
  List<User> user;
  int likeCount;
  List<String> hobbies;
  List<String> interests;

  LikeListModel(
      {this.id,
        this.likedUser,
        this.user,
        this.likeCount,
        this.hobbies,
        this.interests});

  LikeListModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['liked_user'] != null) {
      likedUser = new List<LikedUser>();
      json['liked_user'].forEach((v) {
        likedUser.add(new LikedUser.fromJson(v));
      });
    }
    if (json['user'] != null) {
      user = new List<User>();
      json['user'].forEach((v) {
        user.add(new User.fromJson(v));
      });
    }
    likeCount = json['like_count'];
    hobbies = json['hobbies'].cast<String>();
    interests = json['interests'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    if (this.likedUser != null) {
      data['liked_user'] = this.likedUser.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.map((v) => v.toJson()).toList();
    }
    data['like_count'] = this.likeCount;
    data['hobbies'] = this.hobbies;
    data['interests'] = this.interests;
    return data;
  }
}

class LikedUser {
  String sId;
  int gender;
  List<String> profileImage;
  String relationshipStatus;
  int sexualOrientation;
  String firstName;
  String lastName;

  LikedUser(
      {this.sId,
        this.gender,
        this.relationshipStatus,
        this.sexualOrientation,
        this.firstName,
        this.lastName});

  LikedUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gender = json['gender'];
    profileImage = json['profile_image']==null?null:json['profile_image'].cast<String>();
    relationshipStatus = json['relationship_status'];
    sexualOrientation = json['sexual_orientation'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['relationship_status'] = this.relationshipStatus;
    data['sexual_orientation'] = this.sexualOrientation;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class User {
  String id;

  User({this.id});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    return data;
  }
}
