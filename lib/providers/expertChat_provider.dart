import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/models/chatmessage_model.dart';
import 'package:dating_app/models/expertChatGroupCato_model.dart';
import 'package:dating_app/models/expertGroup_model.dart';
import 'package:dating_app/models/expertchatmessage_model.dart';

import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/expertChat_netword.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum ExpertChatState { Initial, Loading, Loaded, Error }

class ExpertChatProvider extends ChangeNotifier {
  ExpertChatState _chatState = ExpertChatState.Initial;

  List<ExpertGroup> _chatGroupData = [];

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

  List<String> ids = [];
  int groupIndex = 0;
  List<ExpertGroup> chatgroupdatas;
  getGroupData(id, searchKey, int skip) async {
    _chatState = ExpertChatState.Loading;

    try {
      chatgroupdatas = await ExpertNetwork().getGrouplist(id, searchKey, skip);

      if (skip == 0) {
        _chatGroupData = chatgroupdatas;
      } else {
        // _chatGroupData = chatgroupdata;
        _chatGroupData.addAll(chatgroupdatas);
      }
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }

    loaded();
  }

  List<ExpertChatMessage> chatData = [];
  getCacheMessageData(id, int skip) async {
    var box = Hive.box<ExpertChatMessage>('expertchat_$id');
    try {
      if (skip == 0) {
        chatData = await ExpertNetwork().getMessagelist(id, skip);
      } else {
        chatData = await ExpertNetwork()
            .getMessagelist(id, box.values.toList().length);
      }
      if (skip == 0) {
        await box.clear();
      }
      box.addAll(chatData);
      if (chatData.length != 0) {
        _chatMessageData = box.values.toList();
        loaded();
      }
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return showtoast(_errorText);
      // return error1();
    }
  }

  getMessageData(id, int skip) async {
    _chatState = ExpertChatState.Loading;
    if (Hive.isBoxOpen('expertchat_$id') == false) {
      var openbox = await Hive.openBox<ExpertChatMessage>('expertchat_$id');
      print("ithu call aakuthaa irukka ...");
    }
    var box = Hive.box<ExpertChatMessage>('expertchat_$id');

    try {
      _chatMessageData = box.values.toList();
      loaded();
    } on DioError catch (e) {
      _errorText = DioException.fromDioError(e).toString();
      print(_errorText);
      return error();
    }

    getCacheMessageData(id, skip);
  }

  loaded() {
    _chatState = ExpertChatState.Loaded;
    notifyListeners();
  }

  error() {
    _chatState = ExpertChatState.Error;
    notifyListeners();
  }

  addsocketmessage(ExpertChatMessage data, String id) async {
    print(id);

    _chatMessageData = [..._chatMessageData, data];

    notifyListeners();

    var box = await Hive.openBox<ExpertChatMessage>('expertchat_$id');

    box.add(data);
  }
}
