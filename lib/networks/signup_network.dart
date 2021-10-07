import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:dio/dio.dart';

import 'client/apiClient.dart';
import 'client/api_list.dart';
import 'dio_exception.dart';

class EmailSignUpNetwork {
  Future<ResponseData> verifyEmailForSignup(String email) async {
    print(email);
    Response response;
    try {
      final _dio = authClient();
      var data = _dio.then((value) async {
        response = await value.post(verifyEmailForSignupEndpoint + "sdfsdf",
            data: {"email": email});
        print(response.data);
        if (response.statusCode == 200) {
          return ResponseData.fromJson(response.data);
        }
      });
      return data;
    } on DioError catch (dioerror) {
      print("error main la varuthaa");
      print(dioerror);
    }
  }

  Future<ResponseData> verifyOtpForSignup(String email, otp) async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value
            .post(verifyOtpEndpoint, data: {"otp": otp, "email": email});
        if (response.statusCode == 200) {
          return ResponseData.fromJson(response.data);
        }
      });
      return data;
    } catch (e) {
      print(e);
      showtoast(e["msg"]);
    }
  }

  Future<bool> resendOtpForEmail(String email) async {
    print(email);
    Response response;
    try {
      final _dio = authClient();
      var data = _dio.then((value) async {
        response = await value.post(resendOtpEndpoint, data: {"email": email});
        if (response.statusCode == 200) {
          return true;
        } else {
          // showtoast("Failed");
          return false;
        }
      });
      return data;
    } catch (e) {
      print(e);
      showtoast(e["msg"]);
      return false;
    }
  }

  Future<bool> signUpWithEmail(String email, password) async {
    print("$password$email");
    Response response;
    try {
      final _dio = authClient();
      var data = _dio.then((value) async {
        response = await value.post(signUpEmailEndpoint,
            data: {"email": email, "password": password});
        print(response.data);
        if (response.statusCode == 200) {
          saveLoginStatus(1);
          saveToken(
              response.data["accessToken"], response.data["refreshToken"]);
          saveUser(response.data["user_id"]);
          return true;
        } else {
          showtoast(ResponseData.fromJson(response.data).msg);
          return false;
        }
      });
      return data;
    } catch (e) {
      print(e);
      showtoast(e["msg"]);
      return false;
    }
  }
}

class MobileSignUpNetwork {
  Future<bool> verifyMobileNoForSignup(String mob) async {
    Response response;
    try {
      final _dio = authClient();
      print(mob);
      var data = _dio.then((value) async {
        response = await value.post(verifyMobileNoForSignupEndpoint,
            data: {"mobile_number": "9688399791"});
        if (response.statusCode == 200) {
          return true;
        }
      });
      return data;
    } catch (e) {
      print(e);
      showtoast(e["msg"]);
    }
  }

  Future<bool> signUpWithMobile(String mobile) async {
    Response response;
    try {
      final _dio = authClient();
      var data = _dio.then((value) async {
        response = await value
            .post(signUpMobileEndpoint, data: {"mobile_number": mobile});
        print(response.data);
        if (response.statusCode == 200) {
          saveLoginStatus(1);
          saveToken(
              response.data["accessToken"], response.data["refreshToken"]);
          saveUser(response.data["user_id"]);
          return true;
        } else {
          showtoast(ResponseData.fromJson(response.data).msg);
          return false;
        }
      });
      return data;
    } catch (e) {
      print(e);
      showtoast(e["msg"]);
      return false;
    }
  }
}
