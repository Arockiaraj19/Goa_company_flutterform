import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/models/chatmessage_model.dart';
import 'package:dating_app/models/expertChatGroupCato_model.dart';
import 'package:dating_app/models/expertGroup_model.dart';
import 'package:dating_app/models/expertchatmessage_model.dart';

import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/expertChat_netword.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum ExpertChatState { Initial, Loading, Loaded, Error }

class ExpertChatProvider extends ChangeNotifier {
  ExpertChatState _chatState = ExpertChatState.Initial;

  List<ExpertGroup> _chatGroupData;

  ExpertChatState get chatState => _chatState;

  List<ExpertGroup> get chatGroupData => _chatGroupData;

  List<ExpertChatMessage> _chatMessageData;
  List<ExpertChatMessage> get chatMessageData => _chatMessageData;

  List<ExpertChatGroup> _chatGroupCato;
  List<ExpertChatGroup> get chatGroupCato => _chatGroupCato;

  String _errorText;
  String get errorText => _errorText;
  getGroupCatoData() async {
    _chatState = ExpertChatState.Loading;
    try {
      _chatGroupCato = await ExpertNetwork().getGroupCatolist();
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }

    loaded();
  }

  getGroupData(id,searchKey) async {
    _chatState = ExpertChatState.Loading;
    try {
      _chatGroupData = await ExpertNetwork().getGrouplist(id,searchKey);
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }

    loaded();
  }

  getMessageData(id) async {
    _chatState = ExpertChatState.Loading;

    try {
      _chatMessageData = await ExpertNetwork().getMessagelist(id);
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }

    loaded();
  }

  loaded() {
    _chatState = ExpertChatState.Loaded;
    notifyListeners();
  }

  error() {
    _chatState = ExpertChatState.Error;
    notifyListeners();
  }

  addsocketmessage(ExpertChatMessage data) {
    _chatMessageData = [..._chatMessageData, data];
    notifyListeners();
  }
}
