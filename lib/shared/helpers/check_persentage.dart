import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';

class Persentage {
  Future<double> checkPresentage(UserModel userdata) async {
    double _persentage = 0;
    if (userdata.identificationImage != null) {
      print("1");
      _persentage += 0.1;
    }
    if (userdata.firstName != null) {
      print("2");
      _persentage += 0.06;
    }
    if (userdata.lastName != null) {
      print("3");
      _persentage += 0.06;
    }
    if (userdata.bio != null) {
      print("4");
      _persentage += 0.06;
    }
    if (userdata.dob != null) {
      print("5");
      _persentage += 0.06;
    }
    if (userdata.profession.length != 0) {
      print("6");
      _persentage += 0.06;
    }

    if (userdata.weight != null) {
      print("7");
      _persentage += 0.06;
    }
    if (userdata.height != null) {
      print("8");
      _persentage += 0.06;
    }
    if (userdata.gender != null) {
      print("9");
      _persentage += 0.06;
    }
    if (userdata.partnerType != null) {
      print("13");
      _persentage += 0.06;
    }
    if (userdata.interests.length != 0) {
      print("10");
      _persentage += 0.06;
    }
    if (userdata.hobbies.length != 0) {
      print("11");
      _persentage += 0.06;
    }
    if (userdata.profileImage.length != 0) {
      print("12");
      _persentage += 0.06;
    }
    print("persentage enna varuthu");
    print(_persentage.toString());
    return _persentage;
  }

  Future<double> checkSuggestionPresentage(
      UserModel userdata, Responses data) async {
    double _persentage = 0.6;
    if (userdata.sexualOrientation == data.sexualOrientation) {
      _persentage += 0.1;
    }
    if (userdata.partnerType == data.partnerType) {
      _persentage += 0.1;
    }

    if (userdata.hobbies.any((item) => data.hobbies.contains(item))) {
      print(data.firstName);
      print("hobbie1");
      _persentage += 0.08;
    }
    if (userdata.interests.any((item) => data.interests.contains(item))) {
      print(data.firstName);
      print("interest1");
      _persentage += 0.08;
    }
    if (userdata.interestDetails
        .any((item) => data.interestDetails.contains(item))) {
      print(data.firstName);
      print("match detail ");
      _persentage += 0.02;
    }
    if (userdata.hobbyDetails.any((item) => data.hobbyDetails.contains(item))) {
      print(data.firstName);
      print("match detail ");
      _persentage += 0.02;
    }
    print("persentage enna varuthu");
    print(_persentage.toString());
    return _persentage;
  }
}
