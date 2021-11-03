import 'package:dating_app/models/forgetresponse_model.dart';
import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/networks/client/apiClient.dart';
import 'package:dating_app/networks/client/api_list.dart';
import 'package:dio/dio.dart';

import 'sharedpreference/sharedpreference.dart';

class ForgetPassword {
//forget password get otp
  Future forgetGetOtp(String email) async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.post(forget_password_getotp, data: {
          "email": email,
        });
        print(response.data);
        final comingdata = new Map<String, dynamic>.from(response.data);

        ResponseForgetOtp result = ResponseForgetOtp.fromMap(comingdata);
        return result;
      });
      return data;
    } catch (e) {
     throw e;
    }
  }

//get resentotp
  Future forgetGetresentOtp(String email) async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.post(forget_password_resentotp, data: {
          "email": email,
        });
        print("response from resent  password");
        print(response.data["msg"]);
        return response.data["msg"].toString();
      });
      return data;
    } catch (e) {
    throw e;
    }
  }

//submit otp
  Future forgetSubmitOtp(String otp, String email, String id) async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.post(forget_verify_otp,
            data: {"otp": otp, "email": email, "user_id": id});

        final comingdata = new Map<String, dynamic>.from(response.data);

        ResponseSubmitOtp result = ResponseSubmitOtp.fromMap(comingdata);
        return result;
      });
      return data;
    } catch (e) {
     throw e;
    }
  }

//reset password otp
  Future forgetResetPassword(
      String otpid, String userid, String password) async {
    Response response;
    try {
      final _dio = apiClient();

      var data = _dio.then((value) async {
        response = await value.post(forget_reset_password,
            data: {"otp_id": otpid, "user_id": userid, "password": password});
        print("response from forget password");
        saveUser(response.data["user_id"]);
        saveToken(response.data["accessToken"], response.data["accessToken"]);
        return true;
      });
      return data;
    } catch (e) {
     throw e;
    }
  }
}
