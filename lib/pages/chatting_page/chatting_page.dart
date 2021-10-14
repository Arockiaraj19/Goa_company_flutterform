import 'dart:async';

import 'package:dating_app/models/chatmessage_model.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/client/api_list.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/pages/chatting_page/wigets/chatt_box.dart';
import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:dating_app/providers/chat_provider.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/input_field.dart';
import 'package:dating_app/shared/widgets/no_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
// import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:web_socket_channel/status.dart' as status;

class ChattingPage extends StatefulWidget {
  final String groupid;
  final String id;
  final String image;
  final String name;
  final bool onWeb;
  final double chatBoxWidth;
  final double floatingActionButtonWidth;
  ChattingPage(
      {Key key,
      this.groupid,
      this.id,
      this.image,
      this.name,
      this.onWeb = false,
      this.chatBoxWidth,
      this.floatingActionButtonWidth})
      : super(key: key);

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  TextEditingController _firstNameCtrl = TextEditingController();

  String dropdownValue = null;

  List<String> itemdate = [
    "View profile",
    "Block",
    "Play",
    "Meetup",
    "Expert support"
  ];

  IO.Socket socket = IO.io(
      socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableForceNewConnection() // for Flutter or Dart VM
          .build());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("sender id corect a varuthaa");
    print(widget.id);
    IO.Socket socket = IO.io(
        socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    socket.onConnect((data) {
      print('connect' + data);
    });
    print("subscribe varuthaa");
    context.read<ChatProvider>().getMessageData(widget.groupid);
    get();
  }

  get()async{
    await createGroupEmit();
    socket.on("group_${widget.groupid}", (data) {
      print(data);
      final result = new Map<String, dynamic>.from(data);
      ChatMessage chatdata = ChatMessage.fromMap(result);
      print(chatdata);
      return context.read<ChatProvider>().addsocketmessage(chatdata);
    });
  }
  createGroupEmit() async {
    String userid = await getUserId();
    socket.emit("subscribe", {
      "user_1": userid,
      "user_2": widget.id,
      "group": widget.groupid,
    });
  }

  _sentmessage() {
    ChatNetwork()
        .createMessage(widget.id, _message.text.toString(), widget.groupid);
    _message.text = "";
  }

  TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: widget.onWeb
          ? null
          : AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.grey[50],
              leading: Container(
                  padding: EdgeInsets.all(15),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 10,
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black,
                      size: 25,
                    ),
                  )),
              titleSpacing: 0,
              title: Container(
                  child: Row(
                children: [
                  Container(
                      child: CircleAvatar(
                    backgroundImage: widget.image == null
                        ? AssetImage("assets/images/placeholder.png")
                        : NetworkImage(widget.image),
                  )),
                  Container(
                      margin: EdgeInsetsDirectional.only(start: 10),
                      child: widget.name == null
                          ? Text(
                              'Anika',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: "Nunito"),
                            )
                          : Text(
                              widget.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: "Nunito"),
                            ))
                ],
              )),
              actions: [
                Container(
                    child: Image.asset(
                  'assets/images/clock.png',
                  width: 25,
                  height: 25,
                )),
                Container(
                    padding: EdgeInsetsDirectional.only(end: 10),
                    child: PopupMenuButton<String>(
                      initialValue: dropdownValue,
                      icon: Container(
                          child: Image.asset(
                        'assets/images/3dot.png',
                        width: 25,
                        height: 25,
                      )),
                      onSelected: (String result) {
                        setState(() {
                          dropdownValue = result;
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          itemdate.map<PopupMenuEntry<String>>((String value) {
                        return PopupMenuItem<String>(
                          height: 30,
                          padding: EdgeInsets.only(left: 20, right: 5),
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        );
                      }).toList(),
                    )),
              ],
            ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Consumer<ChatProvider>(
                  builder: (context, data, child) {
                    return data.chatState == ChatState.Loaded
                        ? data.chatMessageData.length == 0
                            ? Container()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: List.generate(
                                  data.chatMessageData.length,
                                  (index) => Align(
                                    alignment: data.chatMessageData[index]
                                                .receiverDetails[0].id ==
                                            widget.id
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.w, vertical: 30.w),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: data
                                                        .chatMessageData[index]
                                                        .receiverDetails[0]
                                                        .id ==
                                                    widget.id
                                                ? Colors.white
                                                : Color(0xffEB4DB5),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 50.w,
                                            vertical: 15.w,
                                          ),
                                          child: Text(
                                            data.chatMessageData[index].message,
                                            style: TextStyle(
                                              color: data
                                                          .chatMessageData[
                                                              index]
                                                          .receiverDetails[0]
                                                          .id ==
                                                      widget.id
                                                  ? Color(0xff4A4A4A)
                                                  : Colors.white,
                                              fontSize: 40.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                      width: widget.floatingActionButtonWidth ??
                          MediaQuery.of(context).size.width - 55,
                      height: 70,
                      padding: EdgeInsets.all(10),
                      child: Container(
                          padding: EdgeInsetsDirectional.only(start: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: Colors.grey.shade200),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 1.0,
                                offset: Offset(0, 3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: TextField(
                            controller: _message,
                            decoration: InputDecoration(
                                suffixIcon: RotationTransition(
                                    turns: new AlwaysStoppedAnimation(30 / 360),
                                    child: Icon(
                                      Icons.attach_file,
                                      color: Colors.black,
                                    )),
                                border: InputBorder.none,
                                hintText: 'Type a message...'),
                          ))),
                  InkWell(
                    onTap: () => _sentmessage(),
                    child: Container(
                        child: CircleAvatar(
                      backgroundColor: MainTheme.primaryColor,
                      radius: 22,
                      child: Icon(
                        FontAwesomeIcons.solidPaperPlane,
                        color: Colors.white,
                        size: 17,
                      ),
                    )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
