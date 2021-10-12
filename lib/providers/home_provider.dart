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


class HomeProvider extends ChangeNotifier{
  HomeState _homeState=HomeState.Initial;
  UsersSuggestionModel _usersSuggestionData;
  UserModel _userData;
  bool _apply=false;
  int _currentpage =0,_type=2;
  int view=1;String _age="",_distance="",_lat="",_lng="";
  HomeState get homeState=> _homeState;
  UsersSuggestionModel get usersSuggestionData=> _usersSuggestionData;
  UserModel get userData=>_userData;



  getData() async {
    _usersSuggestionData=null;_currentpage=0;
    _homeState=HomeState.Loading;
    _userData=await UserNetwork().getUserData();
    _usersSuggestionData=await UserNetwork().getUserSuggestionsData(_apply,_age,_distance,_lat,_lng,_type,_currentpage);
    loaded();
  }

  getFilteredData(String age,distance,lat,lng)async{
   _age=age;_distance=distance;_lat=lat;_lng=lng;_apply=true;
    _homeState=HomeState.Loading;
    _usersSuggestionData=null;
    _type =lat=="null"?2:1;
    _usersSuggestionData=await UserNetwork().getUserSuggestionsData(_apply,_age,_distance,_lat,_lng,_type,_currentpage);
    print("ll22");
    loaded();
  }

  reload() async {
    _homeState=HomeState.Loading;
    notifyListeners();
    _usersSuggestionData=await UserNetwork().getUserSuggestionsData(_apply,_age,_distance,_lat,_lng,_type,_currentpage);
    loaded();
  }

  loaded(){
    _homeState=HomeState.Loaded;
    notifyListeners();
  }

  changeView(int val){
    view=val;
    notifyListeners();
  }
  error(){
    _homeState=HomeState.Error;
    notifyListeners();
  }

  nextPage(){
    _currentpage++;
    notifyListeners();
  }

  replaceData(UserModel data){
    print("yss");
    print(_userData.hobbyDetails);
    _userData=data;
    print(_userData);
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