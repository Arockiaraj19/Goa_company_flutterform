//Main URL_0
const String baseUrl = "http://65.2.144.252:3000";

//Socket Url
const String socketUrl = "http://13.126.21.212:3008";

//authentication_email
const String verifyEmailForSignupEndpoint = "/user/verifyemail"; //1
const String signUpEmailEndpoint = "/user/emailsignup"; //1
const String verifyOtpEndpoint = "/user/otp"; //3
const String resendOtpEndpoint = "/user/resendotp"; //3

const String signInEmailEndpoint = "/user/emaillogin"; //2

//authentication_mobile
const String verifyMobileNoForSignupEndpoint = "/user/verifymobile"; //1
const String signUpMobileEndpoint = "/user/mobilesignup"; //1

const String signInMobileEndpoint = "/user/mobilelogin"; //2

//user
const String userDetailsEndpoint = "/user"; //5
const String userInterestEndpoint = "/user/utils/interests"; //5
const String userHobbiesEndpoint = "/user/utils/hobbies"; //5
const String userSuggestionsEndpoint = "/suggestions"; //55
const String userLikeCountEndpoint = "/likecount"; //33
const String userLikeListEndpoint = "/likelists"; //33
const String userMatchCountEndpoint = "/matchcount"; //34
const String userMatchListEndpoint = "/user/matchedlists"; //16

//blind
const String blindRequestEndpoint = "/user/blinddaterequest"; //30
const String blindMatchesEndpoint = "/blinddatematches"; //38

//token
const String refreshTokenEndpoint = "/user/refreshtoken"; //5

//image_upload
const String url_image_upload = "/user/uploadurl";

//home_button
const String likeUnlikeEndpoint = "/user/like";
const String matchRequestEndpoint = "/user/requestmatch";

//notification_3
const String url_get_notification = "";

//get gender api

const String url_get_gender = "/user/utils/genders";

//chat create group
const String create_group = "/chats/group";
const String new_message = "/chats/entry";

//forget password to get otp with email
const String forget_password_getotp = "/user/forgotpassword";

//forget password to get resentotp with email;

const String forget_password_resentotp = "/user/resendpasswordotp";

//verify otp
const String forget_verify_otp = "/user/checkforgotpasswordotp";

//forget reset password

const String forget_reset_password = "/user/resetpassword";

//block user
const String block_user = "/user/chatblock";

//subscription plan
const String subscription_plan = "/user/utils/subscriptionplans";

//get country code

const String country_code = "/user/utils/mobilecodes";

//games part
const String getall_games = "/user/games";

const String create_game_request = "/user/gamerequest";

const String gameaction = "/user/gamerequestaction/";

const String gameanswer = "/user/gameanswer";

const String getgamesquestion = "/user/gamequestions/";
