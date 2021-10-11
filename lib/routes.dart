import 'package:dating_app/models/otp_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/pages/Interest_hobbies_page/interest_hobbies_page.dart';
import 'package:dating_app/pages/add_profile_pic_page/add_profile_pic.dart';
import 'package:dating_app/pages/chatting_page/chatting_page.dart';
import 'package:dating_app/pages/comment_page/comment_page.dart';
import 'package:dating_app/pages/create_profile_page/Create_profile_page.dart';
import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:dating_app/pages/edit_profile_page.dart/edit_profile_page.dart';
import 'package:dating_app/pages/find_match_page/find_match_page.dart';
import 'package:dating_app/pages/gender_select_page/gender_select_page.dart';
import 'package:dating_app/pages/home_page/home_page.dart';
import 'package:dating_app/pages/home_page_grid_view_page/home_page_grid_view_page.dart';
import 'package:dating_app/pages/like_match_list_page/like_match_list.dart';
import 'package:dating_app/pages/login_otp_page/login_otp_page.dart';
import 'package:dating_app/pages/login_page/login_page.dart';
import 'package:dating_app/pages/login_with/login_with.dart';
import 'package:dating_app/pages/looking_for_page/looking_for_page.dart';
import 'package:dating_app/pages/matches_page/matches_page.dart';
import 'package:dating_app/pages/onboarding_page/onboarding_page.dart';
import 'package:dating_app/pages/otp_page/otp_page.dart';
import 'package:dating_app/pages/partner_type_page.dart/partner_type_page.dart';
import 'package:dating_app/pages/payment_page/payment_page.dart';
import 'package:dating_app/pages/perfect_match_page/perfect_match_page.dart';
import 'package:dating_app/pages/quiz_game_page/quiz_game_page.dart';
import 'package:dating_app/pages/quiz_sucess_page/quiz_sucess_page.dart';
import 'package:dating_app/pages/sign_up_page/sign_up_page.dart';
import 'package:dating_app/pages/profile_page/profile_page.dart';
import 'package:dating_app/pages/signup_with_email_page/adding_password_for_signUp.dart';
import 'package:dating_app/pages/signup_with_email_page/signup_with_email_page.dart';
import 'package:dating_app/pages/signup_with_mobile_page/signup_with_mobile_page.dart';
import 'package:dating_app/pages/splash_screen/splash_screen.dart';
import 'package:dating_app/shared/helpers/google_map.dart';
import 'package:sailor/sailor.dart';

import 'models/user_suggestion.dart';
import 'pages/add_album_page/add_album_page.dart';
import 'pages/imagecheck.dart';
import 'pages/meet_page/meetup_page.dart';
import 'pages/subscriptions/subscription_page.dart';

class Routes {
  // RouteNames
  static String splashScreen = 'splash_screen';
  static String homePage = 'home_page';
  static String signUpPage = 'sign_up_page';
  static String profilePage = 'profile_page';
  static String commentPage = 'comment_page';
  static String signUpWithMobilePage = 'signup_with_mobile_page';
  static String signUpWithEmailPage = 'signup_with_email_page';
  static String otpPage = 'otp_page';
  static String createProfilePage = 'create_profile_page';
  static String addingPasswordPage = 'adding_password_page';
  static String interestHobbiesPage = 'interest_Hobbies_Page';
  static String addAlbumPage = 'add_Album_page';
  static String addProfilePicPage = 'add_Profile_pic_page';
  static String lookingForPage = 'looking_for_page';
  static String findMatchPage = 'find_match_page';
  static String detailPage = 'detail_page';
  static String onboardingPage = 'onboarding_page';
  static String chattingPage = 'chatting_page';
  static String matchPage = 'match_page';
  static String perfectMatchPage = 'perfect_match_page';
  static String loginPage = 'login_page';
  static String loginWith = 'login_with';
  static String loginOtpPage = 'login_otp_page';
  static String quizGamePage = 'quiz_game_page';
  static String quizSucessPage = 'quiz_sucess_page';
  static String homePageGridViewPage = 'home_page_grid_view_Page';
  static String editProfilePage = 'edit_profile_page';
  static String partnerTypePage = 'partner_type_page';
  static String locationPage = 'location_page';
  static String likeMatchListPage = 'like_match_list_page';
  static String meetuppage = 'meet_up_page';
  static String subscription = "subscription";
  static String payment = "payment";
  static String imagecheck = "imagecheck";

  static final sailor = Sailor();

  static void createRoutes() {
    Duration _defaultSlideUpDuration = Duration(milliseconds: 300);

    sailor.addRoutes(<SailorRoute>[
      // Home

      SailorRoute(
          name: splashScreen,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return SplashScreen();
          }),

      SailorRoute(
          name: homePage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return HomePage();
          }),

      SailorRoute(
          name: loginOtpPage,
          defaultTransitions: [SailorTransition.fade_in],
          params: [SailorParam<OtpModel>(name: "otpData")],
          builder: (context, args, params) {
            OtpModel otpData = Sailor.param<OtpModel>(context, "otpData");
            return LoginOtpPage(
              otpData: otpData,
            );
          }),

      //login

      SailorRoute(
          name: loginPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return LoginPage();
          }),

      SailorRoute(
          name: loginWith,
          defaultTransitions: [SailorTransition.fade_in],
          params: [SailorParam<String>(name: 'name')],
          builder: (context, args, params) {
            String _loginWithName = Sailor.param<String>(context, "name");
            return LoginWith(
              name: _loginWithName,
            );
          }),

      SailorRoute(
          name: signUpPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return SignUpPage();
          }),

      SailorRoute(
          name: profilePage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return ProfilePage();
          }),

      SailorRoute(
          name: commentPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return CommentPage();
          }),
      SailorRoute(
          name: matchPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return MatchesPage();
          }),
      SailorRoute(
          name: signUpWithEmailPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return SignUpWithEmailPage();
          }),
      SailorRoute(
          name: signUpWithMobilePage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return SignUpWithMobilePage();
          }),

      SailorRoute(
          name: otpPage,
          defaultTransitions: [SailorTransition.fade_in],
          params: [SailorParam<OtpModel>(name: "otpData")],
          builder: (context, args, params) {
            OtpModel otpData = Sailor.param<OtpModel>(context, "otpData");
            return OtpPage(
              otpData: otpData,
            );
          }),

      SailorRoute(
          name: addingPasswordPage,
          defaultTransitions: [SailorTransition.fade_in],
          params: [SailorParam<String>(name: 'email')],
          builder: (context, args, params) {
            String email = Sailor.param<String>(context, "email");
            return AddingPasswordForSignUp(
              email: email,
            );
          }),

      SailorRoute(
          name: createProfilePage,
          defaultTransitions: [SailorTransition.fade_in],
          params: [SailorParam<UserModel>(name: 'userData')],
          builder: (context, args, params) {
            UserModel userData = Sailor.param<UserModel>(context, "userData");
            return CreateProfilePage(userData: userData);
          }),

      SailorRoute(
          name: interestHobbiesPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return InterestHobbiesPage();
          }),

      SailorRoute(
          name: addAlbumPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return AddAlbumPicPage();
          }),
      SailorRoute(
          name: addProfilePicPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return AddProfilePic();
          }),

      SailorRoute(
          name: lookingForPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return LookingForPage();
          }),

      SailorRoute(
          name: findMatchPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return FindMatchPage();
          }),

      SailorRoute(
          name: locationPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return GoogleMapDisplay();
          }),

      SailorRoute(
          name: detailPage,
          params: [SailorParam<Responses>(name: 'userDetails')],
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            Responses userDetail =
                Sailor.param<Responses>(context, "userDetails");
            return DetailPage(userDetails: userDetail);
          }),

      SailorRoute(
          name: onboardingPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return OnboardingPage();
          }),

      SailorRoute(
          name: chattingPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return ChattingPage();
          }),

      SailorRoute(
          name: perfectMatchPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return PerfectMatchPage();
          }),

      SailorRoute(
          name: quizGamePage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return QuizGamePage();
          }),

      SailorRoute(
          name: quizSucessPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return QuizSucessPage();
          }),

      SailorRoute(
          name: homePageGridViewPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return HomePageGridViewPage();
          }),

      SailorRoute(
          name: editProfilePage,
          params: [SailorParam<UserModel>(name: 'userDetails')],
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            UserModel userDetail =
                Sailor.param<UserModel>(context, "userDetails");
            return EditProfilePage(userdata: userDetail);
          }),

      SailorRoute(
          name: partnerTypePage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return PartnerTypePage();
          }),

      SailorRoute(
          name: likeMatchListPage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return LikeMatchListPage();
          }),
      SailorRoute(
          name: meetuppage,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return MeetupPage();
          }),
      SailorRoute(
          name: subscription,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return Subscription();
          }),
      SailorRoute(
          name: payment,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return PaymentPage();
          }),

      SailorRoute(
          name: imagecheck,
          defaultTransitions: [SailorTransition.fade_in],
          builder: (context, args, params) {
            return Imagecheck();
          }),
    ]);
  }
}

class Detailparams {
  Detailparams({this.responses});
  Responses responses;
}
