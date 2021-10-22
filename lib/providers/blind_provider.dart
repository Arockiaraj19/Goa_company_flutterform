import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/blind_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:flutter/material.dart';

enum HomeState { Initial, Loading, Loaded, Error }

class BlindProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  List<ResponseData> _blindData;
  int currentpage = 0, totalPage = 1;

  HomeState get homeState => _homeState;
  List<ResponseData> get blindData => _blindData;

  getData() async {
    _homeState = HomeState.Loading;
    _blindData = await BlindNetwork().getblindMatches();

    loaded();
  }

  postData(BuildContext context, var data) async {
   
    var res = await BlindNetwork().postBlindRequest(data);
    res ? getData() : null;
  }

  loaded() {
    _homeState = HomeState.Loaded;
    notifyListeners();
  }

  error() {
    _homeState = HomeState.Error;
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
