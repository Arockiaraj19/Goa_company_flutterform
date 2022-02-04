import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/response_model.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/blind_network.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum BlindState { Initial, Loading, Loaded, Error }

class BlindProvider extends ChangeNotifier {
  BlindState _blindState = BlindState.Initial;
  List<ResponseData> _blindData = [];
  int currentpage = 0, totalPage = 1;

  BlindState get blindState => _blindState;
  List<ResponseData> get blindData => _blindData;
  String _errorText;
  String get errorText => _errorText;
  int blindIndex = 0;
  getData() async {
    if (blindIndex == 0) {
      _blindState = BlindState.Loading;
    }

    blindIndex++;
    try {
      _blindData = await BlindNetwork().getblindMatches();
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();

      return error();
    }
    loaded();
  }

  postData(BuildContext context, var data) async {
    try {
      var res = await BlindNetwork().postBlindRequest(data);

      res ? getData() : null;
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();

      return error();
    }
  }

  loaded() {
    _blindState = BlindState.Loaded;
    notifyListeners();
  }

  error() {
    _blindState = BlindState.Error;
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
