import 'package:dating_app/models/user.dart';

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
}
