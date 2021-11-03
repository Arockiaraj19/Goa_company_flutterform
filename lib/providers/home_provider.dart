import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum HomeState { Initial, Loading, Loaded, Error }

class HomeProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  UsersSuggestionModel _usersSuggestionData;
  UserModel _userData;
  bool _apply = false;
  int _currentpage = 0, _type = 2;
  int view = 1;
  String _age = "", _distance = "", _lat = "", _lng = "";
  HomeState get homeState => _homeState;
  UsersSuggestionModel get usersSuggestionData => _usersSuggestionData;
  UserModel get userData => _userData;
  bool _showstar = true;
  bool _showheart = true;

  bool get showstar => _showstar;
  bool get showheart => _showheart;
  String _errorText;
  String get errorText => _errorText;

  getData() async {
    _usersSuggestionData = null;
    _currentpage = 0;
    _homeState = HomeState.Loading;
    try {
      _userData = await UserNetwork().getUserData();
      _usersSuggestionData = await UserNetwork().getUserSuggestionsData(
          _apply, _age, _distance, _lat, _lng, _type, _currentpage);
    } on DioError catch (e) {
      print("error provider kku varuthaa");
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
    print("user data");
    print(_userData);

    loaded();
  }

  getFilteredData(String age, distance, lat, lng) async {
    _age = age;
    _distance = distance;
    _lat = lat;
    _lng = lng;
    _apply = true;
    _homeState = HomeState.Loading;
    _usersSuggestionData = null;
    _type = lat == "0" ? 2 : 1;
    try {
      _usersSuggestionData = await UserNetwork().getUserSuggestionsData(
          _apply, _age, _distance, _lat, _lng, _type, _currentpage);
    } on DioError catch (e) {
      print("error provider kku varuthaa");
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
    print("ll22");
    loaded();
  }

  reload() async {
    _homeState = HomeState.Loading;
    notifyListeners();
    try {
      _usersSuggestionData = await UserNetwork().getUserSuggestionsData(
          _apply, _age, _distance, _lat, _lng, _type, _currentpage);
    } on DioError catch (e) {
      print("error provider kku varuthaa");
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
    loaded();
  }

  loaded() {
    _homeState = HomeState.Loaded;
    notifyListeners();
  }

  changeView(int val) {
    view = val;
    notifyListeners();
  }

  error() {
    _homeState = HomeState.Error;
    notifyListeners();
  }

  nextPage() {
    _currentpage++;
    notifyListeners();
  }

  replaceData(UserModel data) {
    print("yss");
    print(_userData.hobbyDetails);
    _userData = data;
    print(_userData);
    notifyListeners();
  }

  changeheart() async {
    _showheart = !_showheart;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    _showheart = !_showheart;
    notifyListeners();
  }

  changestar() async {
    print("star clicked");
    _showstar = !_showstar;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    _showstar = !_showstar;
    notifyListeners();
  }
}
