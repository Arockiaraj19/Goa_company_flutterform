import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum MatchState { Initial, Loading, Loaded, Error }

class MatchProvider extends ChangeNotifier {
  MatchState _matchState = MatchState.Initial;
  List<MatchListModel> _matchListData;
  List<LikeListModel> _likeListData;
  int currentpage = 0, totalPage = 1;

  MatchState get matchState => _matchState;
  List<MatchListModel> get matchListData => _matchListData;
  List<LikeListModel> get likeListData => _likeListData;
  String _errorText;
  String get errorText => _errorText;
  getMatchData(String searchKey) async {
    _matchState = MatchState.Loading;

    try {
      _matchListData = await UserNetwork().getUserMatchList(searchKey);
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
    loaded();
  }

  getMatchLikeData() async {
    _matchState = MatchState.Loading;
    try {
      _matchListData = await UserNetwork().getUserMatchList("");
      _likeListData = await UserNetwork().getUserLikeList();
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
    loaded();
  }

  loaded() {
    _matchState = MatchState.Loaded;
    notifyListeners();
  }

  error() {
    _matchState = MatchState.Error;
    notifyListeners();
  }

  nextPage() {
    currentpage++;

    notifyListeners();
  }

  // addData(UserSuggestionModel content ){
  //   print("jdsf0");
  //   _usersData.add(content);
  //   notifyListeners();
  // }
  // add(){
  //   print("jdsf0");
  //   notifyListeners();
  // }
  //
  // deleteData(int index ){
  //   _usersData.value.content.removeAt(index);
  //   notifyListeners();
  // }
}
