import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum SingleUserState { Initial, Loading, Loaded, Error }

class SingleUserProvider extends ChangeNotifier {
  SingleUserState _homeState = SingleUserState.Initial;

  UserModel _userData;

  SingleUserState get homeState => _homeState;
 
  UserModel get userData => _userData;
  bool _showstar = true;
  bool _showheart = true;

  bool get showstar => _showstar;
  bool get showheart => _showheart;
  String _errorText;
  String get errorText => _errorText;

  getData(String id) async {
    _homeState = SingleUserState.Loading;
    try {
      _userData = await UserNetwork().getSingleSuggestionData(id);
    } on DioError catch (e) {
      print("error provider kku varuthaa");
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
    loaded();
  }

  loaded() {
    _homeState = SingleUserState.Loaded;
    notifyListeners();
  }

  error() {
    _homeState = SingleUserState.Error;
    notifyListeners();
  }
}
