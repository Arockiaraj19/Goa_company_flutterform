import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/models/chatmessage_model.dart';
import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum ChatState { Initial, Loading, Loaded, Error }
enum ChatMessageState { Initial, Loading, Loaded, Error }

class ChatProvider extends ChangeNotifier {
  ChatState _chatState = ChatState.Initial;
  ChatState get chatState => _chatState;

  ChatMessageState _chatMessageState = ChatMessageState.Initial;
  ChatMessageState get chatMessageState => _chatMessageState;

  List<ChatGroup> _chatGroupData;

  List<ChatGroup> get chatGroupData => _chatGroupData;

  List<ChatMessage> _chatMessageData;
  List<ChatMessage> get chatMessageData => _chatMessageData;
  String _errorText;
  String get errorText => _errorText;
  getGroupData(keyWord) async {
    _chatState = ChatState.Loading;
    try {
      _chatGroupData = await ChatNetwork().getGrouplist(keyWord);
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }

    loaded();
  }

  getMessageData(id) async {
    _chatMessageState = ChatMessageState.Loading;

    try {
      _chatMessageData = await ChatNetwork().getMessagelist(id);
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }

    loaded1();
  }

  loaded() {
    _chatState = ChatState.Loaded;
    notifyListeners();
  }

  loaded1() {
    _chatMessageState = ChatMessageState.Loaded;
    notifyListeners();
  }

  error() {
    _chatState = ChatState.Error;
    notifyListeners();
  }

  addsocketmessage(ChatMessage data) {
    _chatMessageData = [..._chatMessageData, data];
    notifyListeners();
  }
}
