import 'package:dating_app/models/question_model.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/games_network.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum GameState { Initial, Loading, Loaded, Error }

class GameProvider extends ChangeNotifier {
  GameState _gameState = GameState.Initial;
  GameState get gameState => _gameState;

  List<Getquestion> _gameData;

  List<Getquestion> get gameData => _gameData;

  String _errorText;
  String get errorText => _errorText;
  getQuestions(String gameId, String playId) async {
    _gameState = GameState.Loading;
    try {
      _gameData = await Games().getquestion(gameId, playId);
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }

    loaded();
  }

  loaded() {
    _gameState = GameState.Loaded;
    notifyListeners();
  }

  error() {
    _gameState = GameState.Error;
    notifyListeners();
  }
}
