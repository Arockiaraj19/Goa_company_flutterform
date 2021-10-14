import 'package:dating_app/models/chatgroup_model.dart';
import 'package:dating_app/models/chatmessage_model.dart';
import 'package:dating_app/models/like_list.dart';
import 'package:dating_app/models/match_list.dart';
import 'package:dating_app/models/user.dart';
import 'package:dating_app/models/user_suggestion.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/user_network.dart';
import 'package:flutter/material.dart';

enum ChatState { Initial, Loading, Loaded, Error }

class ChatProvider extends ChangeNotifier {
  ChatState _chatState = ChatState.Initial;

  List<ChatGroup> _chatGroupData;

  ChatState get chatState => _chatState;

  List<ChatGroup> get chatGroupData => _chatGroupData;

  List<ChatMessage> _chatMessageData;
  List<ChatMessage> get chatMessageData => _chatMessageData;




  getGroupData() async {
    _chatState = ChatState.Loading;
    _chatGroupData = await ChatNetwork().getGrouplist();

    loaded();
  }

  getMessageData(id) async {
    _chatState = ChatState.Loading;
    _chatMessageData = await ChatNetwork().getMessagelist(id);
    loaded();
  }

  loaded() {
    _chatState = ChatState.Loaded;
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
