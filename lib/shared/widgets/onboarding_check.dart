import 'package:dating_app/models/user.dart';
import '../../routes.dart';

onboardingCheck(UserModel userData) {
  if (userData.dob == null || userData.location.coordinates.length == 0) {
    Routes.sailor(Routes.createProfilePage, params: {"userData": userData});
  } else if (userData.interestDetails.length == 0 ||
      userData.hobbyDetails.length == 0) {
    Routes.sailor(Routes.interestHobbiesPage);
  } else if (userData.identificationImage == null) {
    Routes.sailor(Routes.addProfilePicPage);
  } else if (userData.profileImage.length == 0) {
    Routes.sailor(Routes.addAlbumPage);
  } else if (userData.sexualOrientation == null) {
    Routes.sailor(Routes.lookingForPage);
  } else if (userData.partnerType == null) {
    Routes.sailor(Routes.partnerTypePage);
  } else {
    Routes.sailor(Routes.findMatchPage);
  }
}
