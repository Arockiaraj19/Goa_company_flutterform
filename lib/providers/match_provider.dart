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
  List<MatchListModel> _matchListData = [];
  List<LikeListModel> _likeListData = [];
  int currentpage = 0, totalPage = 1;

  MatchState get matchState => _matchState;
  List<MatchListModel> get matchListData => _matchListData;
  List<LikeListModel> get likeListData => _likeListData;
  String _errorText;
  String get errorText => _errorText;
  int matchIndex = 0;
  List<MatchListModel> matchData = [];
  List<MatchListModel> matchData1 = [];
  getMatchData(String searchKey, int skip) async {
    if (matchIndex == 0) {
      _matchState = MatchState.Loading;
    }
    matchIndex++;

    try {
      matchData = await UserNetwork().getUserMatchList(searchKey, skip);
      _matchListData.addAll(matchData);
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
      _matchListData = await UserNetwork().getUserMatchList("", 0);
      _likeListData = await UserNetwork().getUserLikeList(0);
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
    loaded();
  }

  getMatchOnlyData(int skip) async {
    try {
      matchData1 = await UserNetwork().getUserMatchList("", skip);
      _matchListData.addAll(matchData1);
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
    loaded();
  }

  List<LikeListModel> likeData = [];
  getLikesOnlyData(int skip) async {
    try {
      likeData = await UserNetwork().getUserLikeList(skip);
      _likeListData.addAll(likeData);
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
