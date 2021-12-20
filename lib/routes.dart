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
import 'pages/imagecheck.dart';
import 'pages/meet_page/meetup_page.dart';
import 'pages/notification/notification_page.dart';
import 'pages/subscriptions/subscription_page.dart';
import 'pages/success/Success_page.dart';

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
        ChildRoute(Modular.initialRoute,
            child: (_, args) => const SplashScreen()),
        ChildRoute(homePage, child: (_, args) => HomePage()),
        ChildRoute(loginPage, child: (_, args) => LoginPage()),
        ChildRoute(loginWith,
            child: (context, args) => LoginWith(
                  name: args.queryParams["name"],
                )),
        ChildRoute(signUpPage, child: (_, args) => SignUpPage()),
        ChildRoute(profilePage, child: (_, args) => ProfilePage()),
        ChildRoute(commentPage, child: (_, args) => CommentPage()),
        ChildRoute(matchPage, child: (_, args) => MatchesPage()),
        ChildRoute(signUpWithEmailPage,
            child: (_, args) => SignUpWithEmailPage(
                  isforget: args.queryParams["isforget"] as bool,
                )),
        ChildRoute(signUpWithMobilePage,
            child: (_, args) => SignUpWithMobilePage()),
        ChildRoute(interestHobbiesPage,
            child: (_, args) => InterestHobbiesPage()),
        ChildRoute(addAlbumPage, child: (_, args) => AddAlbumPicPage()),
        ChildRoute(addProfilePicPage, child: (_, args) => AddProfilePic()),
        ChildRoute(lookingForPage, child: (_, args) => LookingForPage()),
        ChildRoute(findMatchPage, child: (_, args) => FindMatchPage()),
        ChildRoute(likeMatchListPage,
            child: (_, args) => LikeMatchListPage(
                  index: int.parse(args.queryParams["index"]),
                )),
        ChildRoute(meetuppage, child: (_, args) => MeetupPage()),
        ChildRoute(subscription,
            child: (_, args) => Subscription(
                  swiperIndex: int.parse(args.queryParams["swiperIndex"]),
                  onboard: args.queryParams["onboard"] as bool,
                )),
        ChildRoute(payment, child: (_, args) => PaymentPage()),
        ChildRoute(imagecheck, child: (_, args) => Imagecheck()),
        ChildRoute(success, child: (_, args) => SuccessPage()),
        ChildRoute(albumview,
            child: (_, args) => AlbumView(
                  galleryItems: args.params["galleryItems"],
                )),
        ChildRoute(notification, child: (_, args) => Notification()),
        ChildRoute(aboutus, child: (_, args) => AboutUs()),
        ChildRoute(expertGroup, child: (_, args) => ExpertGroup()),
        ChildRoute(editProfilePage,
            child: (_, args) =>
                EditProfilePage(userdata: args.params["userDetail"])),
        ChildRoute(partnerTypePage,
            child: (_, args) =>
                PartnerTypePage(userData: args.params["userDetail"])),
        ChildRoute(createProfilePage,
            child: (_, args) =>
                CreateProfilePage(userData: args.params["userData"])),
        ChildRoute(detailPage,
            child: (_, args) =>
                DetailPage(userDetails: args.params["userDetails"])),
        ChildRoute(onboardingPage, child: (_, args) => OnboardingPage()),
        ChildRoute(otpPage,
            child: (_, args) => OtpPage(
                  otpData: args.params["otpData"],
                  isforget: args.params["isforget"],
                )),
        ChildRoute(addingPasswordPage,
            child: (_, args) => AddingPasswordForSignUp(
                  email: args.params["email"],
                  otpdata: args.params["otpdata"],
                  isforget: args.params["isforget"],
                )),
        ChildRoute(expertchat,
            child: (_, args) => ExpertChattingPage(
                  groupid: args.queryParams["groupid"],
                  id: args.queryParams["id"],
                  name: args.queryParams["name"],
                  status: args.queryParams["status"] as int,
                  image: [args.queryParams["image"]],
                  onWeb: args.queryParams["onWeb"] as bool,
                )),
        ChildRoute(chattingPage,
            child: (_, args) => ChattingPage(
                  groupid: args.queryParams["groupid"],
                  id: args.queryParams["id"],
                  name: args.queryParams["name"],
                  image: args.queryParams["image"],
                )),
        ChildRoute(perfectMatchPage,
            child: (_, args) => PerfectMatchPage(
                  user1: args.params["user1"],
                  user2: args.params["user2"],
                )),
        ChildRoute(quizGamePage,
            child: (_, args) => QuizGamePage(
                  questions: args.params["questions"],
                  playid: args.params["playid"],
                  user1: args.params["user1"],
                  user2: args.params["user2"],
                  istrue: args.params["istrue"],
                  user1name: args.params["user1name"],
                  user2name: args.params["user2name"],
                )),
        ChildRoute(quizSucessPage,
            child: (_, args) => QuizSucessPage(
                  user1image: args.params["user1image"],
                  user2image: args.params["user2image"],
                  user1name: args.params["user1name"],
                  user2name: args.params["user2name"],
                  score: args.params["score"],
                  length: args.params["length"],
                )),
      ];
}
