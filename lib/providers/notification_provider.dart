import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/notification_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/notification_network.dart';
import 'package:dating_app/networks/notification_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:flutter/material.dart';

enum NotificationState { Initial, Loading, Loaded, Error }

class NotificationProvider extends ChangeNotifier {
  NotificationState _notificationState = NotificationState.Initial;

  List<NotificationModel> _notificationData = [];

  NotificationState get notificationState => _notificationState;

  List<NotificationModel> get notificationData => _notificationData;

  getData() async {
    _notificationState = NotificationState.Loading;
    _notificationData = await NotificationNetwork().getData();

    loaded();
  }

  loaded() {
    _notificationState = NotificationState.Loaded;
    notifyListeners();
  }

  error() {
    _notificationState = NotificationState.Error;
    notifyListeners();
  }
}
