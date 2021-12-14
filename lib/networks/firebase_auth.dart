import 'package:dating_app/models/otp_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/signin_network.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../routes.dart';
import 'signup_network.dart';
import 'user_network.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

FirebaseAuth _auth = FirebaseAuth.instance;

Future registerUser(String mobile, BuildContext context, bool isSignUp,
    Function callback) async {
  TextEditingController _codeController = TextEditingController();
  if (kIsWeb) {
    _auth.signInWithPhoneNumber(mobile).then((value) {
      OtpModel data = OtpModel.fromJson({
        "value": mobile,
        "id": value.verificationId.toString(),
        "isMob": true,
        "isSignUp": isSignUp
      });
      Routes.sailor(Routes.otpPage,
          params: {"otpData": data, "isforget": false});
    }).catchError((exception) {
      showtoast(exception.toString());
      callback(exception.toString());
    });
  } else {
    _auth
        .verifyPhoneNumber(
            phoneNumber: mobile,
            timeout: Duration(seconds: 60),
            verificationCompleted: (AuthCredential authcredential) {
              Master_function(
                  context, authcredential, mobile, isSignUp, callback);
            },
            verificationFailed: (FirebaseAuthException exception) {
              // if (exception.code == "invalid-phone-number") {
              //   print("exception la correct a varuthaa");
              //   print(exception.message);
              // }
              // print("verify phone number la enna error varuthu");
              // print(exception);
              // print(exception.code);
              showtoast(exception.message);
              callback(exception.message);
              throw Exception(exception.message);
            },
            codeSent: (String verificationId, [int forceResendingToken]) {
              // var dataa=jsonEncode({"value":"+91$mobile","id":verificationId,
              //   "isMob":true,"isSignUp":true });
              OtpModel data = OtpModel.fromJson({
                "value": mobile,
                "id": verificationId,
                "isMob": true,
                "isSignUp": isSignUp
              });
              Routes.sailor(Routes.otpPage,
                  params: {"otpData": data, "isforget": false});
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              verificationId = verificationId;
              print(verificationId);
              print("Timout");
            })
        .catchError((e) {
      print("inga yaachum enna varuthu");
      throw Exception("Some thing wrong");
    });
  }
}

Future Master_function(BuildContext context, var cred, String mob,
    bool isSignUp, Function callback) async {
  _auth.signInWithCredential(cred).then((dynamic result) async {
    print("done");
    try {
      if (isSignUp == true) {
        try {
          var network = MobileSignUpNetwork();
          bool res = await network.signUpWithMobile(mob);
          var network1 = UserNetwork();
          UserModel userData = res ? await network1.getUserData() : null;
          userData != null ? onboardingCheck(userData) : null;
        } catch (e) {
          throw e;
        }
      } else {
        var network = SignInNetwork();
        var network1 = UserNetwork();
        try {
          bool result = await network.signInWithMobile(mob);
          UserModel userData = result ? await network1.getUserData() : null;
          userData != null ? onboardingCheck(userData) : null;
        } catch (e) {
          throw e;
        }
      }
    } catch (e) {
      throw e;
    }
  }).catchError((e) {
    showtoast(e.message);
    callback(e.message);
  });
}
