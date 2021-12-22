import 'dart:convert';
import 'package:dating_app/models/device_info.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/get_device_info.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'api_list.dart';

Future<Dio> apiClient() async {
  final _dio = Dio();
  _dio.interceptors.clear();
  _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
    // Do something before request is sent
    DeviceInfo deviceInfo = await getDeviceInfo();
    var accessToken = await getAccessToken();
    var headerData = deviceInfo.appType == "web"
        ? '{"app_type":"web","device_type": "desktop","browser": "${deviceInfo.browser.toString()}","browser_version": "${deviceInfo.browserVersion.toString()}"}'
        : deviceInfo.appType == "android"
            ? '{"device_model": "${deviceInfo.deviceName}","imei_no": "${deviceInfo.identifier}","app_type": "android","device_type": "mobile"}'
            : '{"device_model": "${deviceInfo.deviceName}","imei_no": "${deviceInfo.identifier}","app_type": "ios","device_type": "mobile"}';
    Response response;
    var decodeJson = jsonDecode(headerData);
    String encodedData = jsonEncode(decodeJson);
    print("before accesstoken");

    print(accessToken);
    print("after accesstoken");
    // options.headers['content-Type'] = 'application/json';
    options.headers["Authorization"] = accessToken;
    options.headers["user_device"] = encodedData;

    return handler.next(options);
  }, onResponse: (Response response, handler) {
    // Do something with response data
    return handler.next(response); // continue
  }, onError: (DioError error, handler) async {
    print(error.response);
    // print(error.response.statusCode);
    showtoast(DioException.fromDioError(error).toString());
    // Do something with response error
    if (error.response != null) {
      // print(error.response);

      // if (error.response.statusCode == 409) {
      //  showtoast(error.response.data["msg"]);
      // }
      if (error.response.statusCode == 410) {
        try {
          print("refersh");
          var refreshToken = await getRefreshToken();
          print(refreshToken);
          DeviceInfo deviceInfo = await getDeviceInfo();

          var headerData = deviceInfo.appType == "web"
              ? '{"app_type":"web","device_type": "desktop","browser": "${deviceInfo.browser.toString()}","browser_version": "${deviceInfo.browserVersion.toString()}"}'
              : deviceInfo.appType == "android"
                  ? '{"device_model": "${deviceInfo.deviceName}","imei_no": "${deviceInfo.identifier}","app_type": "android","device_type": "mobile"}'
                  : '{"device_model": "${deviceInfo.deviceName}","imei_no": "${deviceInfo.identifier}","app_type": "ios","device_type": "mobile"}';

          var decodeJson = jsonDecode(headerData);
          String encodedData = jsonEncode(decodeJson);
          final response1 = await Dio().get(baseUrl + refreshTokenEndpoint,
              options: Options(headers: {
                "Authorization": refreshToken,
                "user_device": encodedData
              }));
          print(response1.data);
          var accessToken;
          if (response1.statusCode == 200) {
            accessToken = response1.data['accessToken'];
            await saveAccessToken(accessToken);
          }
          error.requestOptions.headers["Authorization"] = accessToken;
          final opts = new Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers);
          final cloneReq = await _dio.request(error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);
          return handler.resolve(cloneReq);
        } catch (e) {
          saveLoginStatus(0);
          Modular.to.navigate(Navigate.loginPage);
        }
      } else {}
    } else {}
    return handler.next(error);
  }));
  _dio.options.baseUrl = baseUrl;
  _dio.options.connectTimeout = 60000;
  _dio.options.receiveTimeout = 60000;

  return _dio;
}

Future<Dio> authClient() async {
  final _dio = Dio();
  _dio.interceptors.clear();

  _dio.interceptors
    ..add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
      // Do something before request is sent
      // var accessToken = getAccessToken();

      options.headers['content-Type'] = 'application/json';
      // options.headers["Authorization"] = "Bearer" + accessToken;
      // options.headers["Accept-Language"] = "en";
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      // Do something with response data
      return handler.next(response); // continue
    }, onError: (DioError error, handler) async {
      print("ithu interceptor");
      print(error);
      showtoast(DioException.fromDioError(error).toString());
      return handler.next(error);
    }));
  _dio.options.baseUrl = baseUrl;
  _dio.options.connectTimeout = 60000;
  _dio.options.receiveTimeout = 60000;

  return _dio;
}
