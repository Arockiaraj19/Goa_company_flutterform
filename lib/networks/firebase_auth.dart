import 'package:dating_app/models/otp_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/networks/signin_network.dart';
import 'package:dating_app/shared/widgets/onboarding_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../routes.dart';
import 'signup_network.dart';
import 'user_network.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future registerUser(String mobile, BuildContext context, bool isSignUp) async {
  TextEditingController _codeController = TextEditingController();

  _auth.verifyPhoneNumber(
      phoneNumber: "+91$mobile",
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential authcredential) {
        Master_function(context, authcredential, mobile, isSignUp);
      },
      verificationFailed: (FirebaseAuthException exception) {
        return "error";
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        // var dataa=jsonEncode({"value":"+91$mobile","id":verificationId,
        //   "isMob":true,"isSignUp":true });
        OtpModel data = OtpModel.fromJson({
          "value": "+91$mobile",
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
      });
}

Master_function(BuildContext context, var cred, String mob, bool isSignUp) {
  _auth.signInWithCredential(cred).then((dynamic result) async {
    print("done");
    if (isSignUp == true) {
      var network = MobileSignUpNetwork();
      bool res = await network.signUpWithMobile(mob);
      var network1 = UserNetwork();
      UserModel userData = res ? await network1.getUserData() : null;
      userData != null ? onboardingCheck(userData) : null;
    } else {
      var network = SignInNetwork();
      var network1 = UserNetwork();
      bool result = await network.signInWithMobile(mob);
      UserModel userData = result ? await network1.getUserData() : null;
      userData != null ? onboardingCheck(userData) : null;
    }
  }).catchError((e) {
    print(e);
  });
}
