import 'package:dating_app/models/subscription_model.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/subscription.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum SubscriptionState { Initial, Loading, Loaded, Error }

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionState _subscriptionState = SubscriptionState.Initial;

  SubscriptionState get subscriptionState => _subscriptionState;

  List<SubscriptionModel> _subscriptionData = [];
  List<ChecklistModel> _checklistData = [];
  String _count;
  String get count => _count;

  List<SubscriptionModel> get subscriptionData => _subscriptionData;
  List<ChecklistModel> get checklistData => _checklistData;
  String _plan;
  String get plan => _plan;
  String _errorText;
  String get errorText => _errorText;
  getdata() async {
    _subscriptionState = SubscriptionState.Loading;
    _checklistData = await Subscription().getChecklistData();
    _subscriptionData = await Subscription().getSubscriptinPlans();

    loaded();
  }

  getprofilecount() async {
    _subscriptionState = SubscriptionState.Loading;
    try {
      _count = await Subscription().getProfileCount();
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }

    loaded();
  }

  loaded() {
    _subscriptionState = SubscriptionState.Loaded;
    notifyListeners();
  }

  checkplans() async {
    _subscriptionState = SubscriptionState.Loading;
    try {
      _plan = await Subscription().checkPlans();
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }

    loaded();
  }

  error() {
    _subscriptionState = SubscriptionState.Error;
    notifyListeners();
  }
}
