import 'package:dating_app/models/user.dart';
import '../../routes.dart';

onboardingCheck(UserModel userData) {
  if (userData.firstName == null) {
    NavigateFunction()
        .withoutquery(Navigate.createProfilePage, {"userData": userData});
  } else if (userData.interests.length == 0 || userData.hobbies.length == 0) {
    NavigateFunction().withquery(Navigate.interestHobbiesPage);
  } else if (userData.identificationImage == null) {
    NavigateFunction().withquery(Navigate.addProfilePicPage);
  } else if (userData.profileImage.length == 0) {
    // Routes.sailor(Routes.addProfilePicPage);

    NavigateFunction().withquery(Navigate.addAlbumPage);
  } else if (userData.sexualOrientation == null) {
    NavigateFunction().withquery(Navigate.lookingForPage);
  } else if (userData.partnerType == null ||
      userData.verificationImage == null) {
    NavigateFunction().withquery(Navigate.partnerTypePage);
  } else {
    NavigateFunction().withquery(Navigate.findMatchPage);
  }
}
