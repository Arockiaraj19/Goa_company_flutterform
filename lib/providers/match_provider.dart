import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:flutter/material.dart';

enum HomeState{
  Initial,
  Loading,
  Loaded,
  Error
}


class MatchProvider extends ChangeNotifier{
  HomeState _homeState=HomeState.Initial;
  List<MatchListModel> _matchListData;
  List<LikeListModel> _likeListData;
  int currentpage =0,totalPage=1;

  HomeState get homeState=> _homeState;
  List<MatchListModel> get matchListData=> _matchListData;
  List<LikeListModel> get likeListData=>_likeListData;

  getMatchData()async{
    _homeState=HomeState.Loading;
    _matchListData=await UserNetwork().getUserMatchList();
    loaded();
  }

  getMatchLikeData()async{
    _homeState=HomeState.Loading;
    _matchListData=await UserNetwork().getUserMatchList();
    _likeListData = await UserNetwork().getUserLikeList();
    loaded();
    notifyListeners();
  }

  loaded(){
    _homeState=HomeState.Loaded;
    notifyListeners();
  }

  error(){
    _homeState=HomeState.Error;
    notifyListeners();
  }
  nextPage(){
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