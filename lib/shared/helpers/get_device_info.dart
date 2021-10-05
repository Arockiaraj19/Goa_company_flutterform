import 'dart:io';
import 'package:dating_app/models/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


  Future<DeviceInfo>getDeviceInfo() async{
    DeviceInfo deviceInfo;
    DeviceInfoPlugin deviceData = DeviceInfoPlugin();
    try {
      if(kIsWeb){
        WebBrowserInfo webBrowserInfo = await deviceData.webBrowserInfo;
        final Map<String, String> data = {
          'browser': webBrowserInfo.browserName.toString(),
          'browserVersion': webBrowserInfo.appVersion,
          'appType': 'web',
          'deviceType': 'desktop',
        };
        deviceInfo= DeviceInfo.fromJson(data);
      }
      else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceData.androidInfo;
        final Map<String, String> data = {
          'deviceName': androidInfo.model,
          'deviceVersion': androidInfo.version.toString(),
          'identifier': androidInfo.androidId,
          'appType': 'android',
          'deviceType': 'mobile',
        };
        deviceInfo= DeviceInfo.fromJson(data);
        //UUID for Android
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceData.iosInfo;
        final Map<String, String> data = {
          'deviceName': iosInfo.model,
          'deviceVersion': iosInfo.systemVersion,
          'identifier': iosInfo.identifierForVendor,
          'appType': 'ios',
          'deviceType': 'mobile',
        };
        deviceInfo= DeviceInfo.fromJson(data);
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return deviceInfo;
  }
