import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/models/chatmessage_model.dart';
import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:logger/logger.dart';

enum ChatState { Initial, Loading, Loaded, Error }
enum ChatMessageState { Initial, Loading, Loaded, Error }

class ChatProvider extends ChangeNotifier {
  ChatState _chatState = ChatState.Initial;
  ChatMessageState _chatMessageState = ChatMessageState.Initial;

  List<ChatGroup> _chatGroupData = [];

  ChatState get chatState => _chatState;
  ChatMessageState get chatMessageState => _chatMessageState;

  List<ChatGroup> get chatGroupData => _chatGroupData;

  List<ChatMessage> _chatMessageData;
  List<ChatMessage> get chatMessageData => _chatMessageData;
  String _errorText;
  String get errorText => _errorText;
  int groupindex = 0;
  List<ChatGroup> chatgroupdata = [];
  getGroupData(keyWord, int skip) async {
    if (groupindex == 0) {
      _chatState = ChatState.Loading;
    }

    groupindex++;
    try {
      chatgroupdata = await ChatNetwork().getGrouplist(keyWord, skip);
      if (skip == 0) {
        _chatGroupData = chatgroupdata;
      } else {
        // _chatGroupData = chatgroupdata;
        _chatGroupData.addAll(chatgroupdata);
      }
      loaded();
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }
  }

  List<ChatMessage> chatData = [];
  storecache(id, int skip) async {
    var box = Hive.box<ChatMessage>('chat_$id');
    try {
      if (skip == 0) {
        chatData = await ChatNetwork().getMessagelist(id, skip);
      } else {
        chatData =
            await ChatNetwork().getMessagelist(id, box.values.toList().length);
      }
      if (skip == 0) {
        await box.clear();
      }
      box.addAll(chatData);
      if (chatData.length != 0) {
        _chatMessageData = box.values.toList();
        loaded1();
      }
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return showtoast(_errorText);
      // return error1();
    }
  }

  getMessageData(id, skip) async {
    print(id);
    _chatMessageState = ChatMessageState.Loading;

    if (Hive.isBoxOpen('chat_$id') == false) {
      var openbox = await Hive.openBox<ChatMessage>('chat_$id');
      print("ithu call aakuthaa irukka ...");
    }
    var box = Hive.box<ChatMessage>('chat_$id');

    try {
      _chatMessageData = box.values.toList();
      loaded1();
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
    }
    storecache(id, skip);
  }

  loaded() {
    _chatState = ChatState.Loaded;
    notifyListeners();
  }

  error() {
    _chatState = ChatState.Error;
    notifyListeners();
  }

  loaded1() {
    _chatMessageState = ChatMessageState.Loaded;
    notifyListeners();
  }

  error1() {
    _chatMessageState = ChatMessageState.Error;
    notifyListeners();
  }

  addsocketmessage(ChatMessage data, String id) async {
    print(id);

    _chatMessageData = [..._chatMessageData, data];

    notifyListeners();
    if (Hive.isBoxOpen('chat_$id') == false) {
      var openbox = await Hive.openBox<ChatMessage>('chat_$id');
      print("ithu call aakuthaa irukka ...");
    }
    var box = await Hive.openBox<ChatMessage>('chat_$id');

    box.add(data);
  }
}
