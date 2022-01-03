import 'dart:convert';

import 'package:dating_app/models/forgetresponse_model.dart';
import 'package:dating_app/models/matchuser_model.dart';
import 'package:dating_app/models/otp_model.dart';
import 'package:dating_app/models/question_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/pages/Interest_hobbies_page/interest_hobbies_page.dart';
import 'package:dating_app/pages/about_page/aboutUs_page.dart';
import 'package:dating_app/pages/add_profile_pic_page/add_profile_pic.dart';
import 'package:dating_app/pages/album_view_page/album_view_page.dart';
import 'package:dating_app/pages/chatting_page/chatting_page.dart';
import 'package:dating_app/pages/comment_page/comment_page.dart';
import 'package:dating_app/pages/create_profile_page/Create_profile_page.dart';
import 'package:dating_app/pages/crypto.dart';
import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:dating_app/pages/edit_profile_page.dart/edit_profile_page.dart';
import 'package:dating_app/pages/expert_ChatGroup/expertChatGroup.dart';
import 'package:dating_app/pages/expert_ChatGroup/expertChattingPage.dart';
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
import 'package:dating_app/pages/notFoundPage.dart';
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
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sailor/sailor.dart';

import 'models/user_suggestion.dart';
import 'pages/add_album_page/add_album_page.dart';
import 'pages/googleAdsCheck.dart';
import 'pages/imagecheck.dart';
import 'pages/meet_page/meetup_page.dart';
import 'pages/notification/notification_page.dart';
import 'pages/subscriptions/subscription_page.dart';
import 'pages/success/Success_page.dart';
import 'shared/helpers/route_restriction.dart';

class Navigate extends Module {
  @override
  List<Bind> get binds => [];
  static String splashScreen = '/splash_screen';
  static String homePage = '/home_page';
  static String signUpPage = '/sign_up_page';
  static String profilePage = '/profile_page';
  static String commentPage = '/comment_page';
  static String signUpWithMobilePage = '/signup_with_mobile_page';
  static String signUpWithEmailPage = '/signup_with_email_page';
  static String otpPage = '/otp_page';
  static String createProfilePage = '/create_profile_page';
  static String addingPasswordPage = '/adding_password_page';
  static String interestHobbiesPage = '/interest_Hobbies_Page';
  static String addAlbumPage = '/add_Album_page';
  static String addProfilePicPage = '/add_Profile_pic_page';
  static String lookingForPage = '/looking_for_page';
  static String findMatchPage = '/find_match_page';
  static String detailPage = '/detail_page';
  static String onboardingPage = '/onboarding_page';
  static String chattingPage = '/chatting_page';
  static String matchPage = '/match_page';
  static String perfectMatchPage = '/perfect_match_page';
  static String loginPage = '/login_page';
  static String loginWith = '/login_with';
  static String loginOtpPage = '/login_otp_page';
  static String quizGamePage = '/quiz_game_page';
  static String quizSucessPage = '/quiz_sucess_page';
  static String homePageGridViewPage = '/home_page_grid_view_Page';
  static String editProfilePage = '/edit_profile_page';
  static String partnerTypePage = '/partner_type_page';
  static String locationPage = '/location_page';
  static String likeMatchListPage = '/like_match_list_page';
  static String meetuppage = '/meet_up_page';
  static String subscription = "/subscription";
  static String payment = "/payment";
  static String imagecheck = "/imagecheck";
  static String success = "/success";
  static String albumview = "/albumview";
  static String notification = "/notification";
  static String aboutus = "/aboutus";
  static String crypto = "/crypto";
  static String expertGroup = "/expertGroup";
  static String expertchat = "/expertchat";

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => SplashScreen()),
        ChildRoute(homePage,
            child: (_, args) => HomePage(), guards: [AuthGuard()]),
        ChildRoute(loginPage, child: (_, args) => LoginPage()),
        ChildRoute(loginWith,
            child: (context, args) => LoginWith(
                  name: args.queryParams["name"],
                )),
        ChildRoute(signUpPage, child: (_, args) => SignUpPage()),
        ChildRoute(profilePage,
            child: (_, args) => ProfilePage(), guards: [AuthGuard()]),
        ChildRoute(commentPage,
            child: (_, args) => CommentPage(), guards: [AuthGuard()]),
        ChildRoute(matchPage,
            child: (_, args) => MatchesPage(), guards: [AuthGuard()]),
        ChildRoute(signUpWithEmailPage,
            child: (_, args) => SignUpWithEmailPage(
                  isforget: args.queryParams["isforget"] == "true",
                )),
        ChildRoute(signUpWithMobilePage,
            child: (_, args) => SignUpWithMobilePage()),
        ChildRoute(interestHobbiesPage,
            child: (_, args) => InterestHobbiesPage(), guards: [AuthGuard1()]),
        ChildRoute(addAlbumPage,
            child: (_, args) => AddAlbumPicPage(), guards: [AuthGuard1()]),
        ChildRoute(addProfilePicPage,
            child: (_, args) => AddProfilePic(), guards: [AuthGuard1()]),
        ChildRoute(lookingForPage,
            child: (_, args) => LookingForPage(), guards: [AuthGuard1()]),
        ChildRoute(findMatchPage, child: (_, args) => FindMatchPage()),
        ChildRoute(likeMatchListPage,
            child: (_, args) => LikeMatchListPage(
                  index: int.parse(args.queryParams["index"]),
                ),
            guards: [AuthGuard()]),
        ChildRoute(meetuppage,
            child: (_, args) => MeetupPage(), guards: [AuthGuard()]),
        ChildRoute(subscription,
            child: (_, args) => Subscription(
                  swiperIndex: args.queryParams["swiperIndex"] == null
                      ? null
                      : int.parse(args.queryParams["swiperIndex"]),
                  onboard: args.queryParams["onboard"] == "true",
                )),
        ChildRoute(payment,
            child: (_, args) => PaymentPage(), guards: [AuthGuard()]),
        ChildRoute(imagecheck,
            child: (_, args) => Imagecheck(), guards: [AuthGuard()]),
        ChildRoute(success, child: (_, args) => SuccessPage()),
        ChildRoute(albumview,
            child: (_, args) => AlbumView(
                  galleryItems: args.data["galleryItems"],
                ),
            guards: [AuthGuard()]),
        ChildRoute(notification,
            child: (_, args) => NotificationPage(), guards: [AuthGuard()]),
        ChildRoute(aboutus,
            child: (_, args) => AboutUs(), guards: [AuthGuard()]),
        ChildRoute(expertGroup,
            child: (_, args) => ExpertGroup(), guards: [AuthGuard()]),
        ChildRoute(editProfilePage, child: (_, args) {
          return EditProfilePage();
        }, guards: [AuthGuard()]),
        ChildRoute(partnerTypePage,
            child: (_, args) => PartnerTypePage(), guards: [AuthGuard1()]),
        ChildRoute(createProfilePage,
            child: (_, args) => CreateProfilePage(), guards: [AuthGuard1()]),
        ChildRoute(detailPage,
            child: (_, args) => DetailPage(
                userDetails:
                    args.data["userDetails"]), //itha final la try pannanum
            guards: [AuthGuard()]),
        ChildRoute(onboardingPage, child: (_, args) => OnboardingPage()),
        ChildRoute(otpPage,
            child: (_, args) => OtpPage(
                  isforget: args.queryParams["isforget"] == "true",
                  oid: args.queryParams["oid"],
                  oisMob: args.queryParams["oisMob"] == "true",
                  oisSignUp: args.queryParams["oisSignUp"] == "true",
                  ovalue: args.queryParams["ovalue"],
                )),
        ChildRoute(addingPasswordPage,
            child: (_, args) => AddingPasswordForSignUp(
                  email: args.queryParams["email"],
                  isforget: args.queryParams["isforget"] == "true",
                  oemail: args.queryParams["oemail"],
                  omsg: args.queryParams["omsg"],
                  ootp_id: args.queryParams["ootp_id"],
                  ouser_id: args.queryParams["ouser_id"],
                )),
        ChildRoute(expertchat,
            child: (_, args) => ExpertChattingPage(
                  groupid: args.queryParams["groupid"],
                  id: args.queryParams["id"],
                  name: args.queryParams["name"],
                  status: int.parse(args.queryParams["status"]),
                  image: [args.queryParams["image"]],
                  onWeb: true,
                ),
            guards: [AuthGuard()]),
        ChildRoute(chattingPage,
            child: (_, args) => ChattingPage(
                  groupid: args.queryParams["groupid"],
                  id: args.queryParams["id"],
                  name: args.queryParams["name"],
                  image: args.queryParams["image"],
                  onWeb: true,
                ),
            guards: [AuthGuard()]),
        ChildRoute(perfectMatchPage,
            child: (_, args) => PerfectMatchPage(
                  user1: args.data["user1"],
                  user2: args.data["user2"],
                ),
            guards: [AuthGuard()]),
        ChildRoute(quizGamePage,
            child: (_, args) => QuizGamePage(
                  questionid: args.queryParams["questionid"],
                  playid: args.queryParams["playid"],
                  user1: args.queryParams["user1"],
                  user2: args.queryParams["user2"],
                  istrue: args.queryParams["istrue"] == "true",
                  user1name: args.queryParams["user1name"],
                  user2name: args.queryParams["user2name"],
                ),
            guards: [AuthGuard()]),
        ChildRoute(quizSucessPage,
            child: (_, args) => QuizSucessPage(
                  user1image: args.queryParams["user1image"],
                  user2image: args.queryParams["user2image"],
                  user1name: args.queryParams["user1name"],
                  user2name: args.queryParams["user2name"],
                  score: int.parse(args.queryParams["score"]),
                  length: int.parse(args.queryParams["length"]),
                ),
            guards: [AuthGuard()]),
        WildcardRoute(child: (context, args) => NotFoundPage()),
      ];
}

class NavigateFunction {
  withoutquery(path, Map<String, dynamic> argument) {
    return Modular.to.pushNamed(path, arguments: argument);
  }

  withquery(path) {
    return Modular.to.pushNamed(path);
  }

  withqueryReplace(path) {
    return Modular.to.pushReplacementNamed(path);
  }

  withoutqueryReplace(path, argument) {
    return Modular.to.pushReplacementNamed(path, arguments: argument);
  }
}
