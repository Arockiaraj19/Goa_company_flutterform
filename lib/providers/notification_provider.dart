import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/notification_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/notification_network.dart';
import 'package:dating_app/networks/notification_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum NotificationState { Initial, Loading, Loaded, Error }

class NotificationProvider extends ChangeNotifier {
  NotificationState _notificationState = NotificationState.Initial;

  List<NotificationModel> _notificationData = [];

  NotificationState get notificationState => _notificationState;

  List<NotificationModel> get notificationData => _notificationData;
  String _errorText;
  String get errorText => _errorText;
  int index = 0;
  getData() async {
    if (index == 0) {
      _notificationState = NotificationState.Loading;
    }
    index++;

    try {
      _notificationData = await NotificationNetwork().getData();
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
    loaded();
  }

  loaded() {
    _notificationState = NotificationState.Loaded;
    notifyListeners();
  }

  empty() {
    _notificationData = [];
  }

  error() {
    _notificationState = NotificationState.Error;
    notifyListeners();
  }
}
