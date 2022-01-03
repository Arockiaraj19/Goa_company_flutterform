// ignore_for_file: implementation_imports

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/models/chatmessage_model.dart';
import 'package:dating_app/models/game_request_model.dart';
import 'package:dating_app/models/games.dart';
import 'package:dating_app/models/imageCheckModel.dart';
import 'package:dating_app/models/question_model.dart';
import 'package:dating_app/networks/ImageCheck.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/client/api_list.dart';
import 'package:dating_app/networks/dio_exception.dart';
import 'package:dating_app/networks/games_network.dart';
import 'package:dating_app/networks/image_upload_network.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/networks/user_network.dart';

import 'package:dating_app/providers/chat_provider.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/loadingLottie.dart';
import 'package:dating_app/shared/helpers/websize.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/error_card.dart';
import 'package:dating_app/shared/widgets/image_upload_alert.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
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
  ];

  IO.Socket socket = IO.io(
      socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableForceNewConnection()
          .enableReconnection() // for Flutter or Dart VM
          .build());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("enna id varuthu");
    print(widget.id);

    socket.onConnect((data) {
      // print('connect' + data);
    });
    print("subscribe varuthaa");
    context.read<ChatProvider>().getMessageData(widget.groupid);
    get();
  }

  get() async {
    await createGroupEmit();
    socket.on("group_${widget.groupid}", (data) {
      print(data);
      final result = new Map<String, dynamic>.from(data);
      print("what message i get");
      print(result);
      ChatMessage chatdata = ChatMessage.fromMap(result);
      print(chatdata);

      return context.read<ChatProvider>().addsocketmessage(chatdata);
    });
    ChatNetwork().patchUnreadMessage(widget.groupid);
  }

  createGroupEmit() async {
    String userid = await getUserId();
    socket.emit("subscribe", {
      "user_1": userid,
      "user_2": widget.id,
      "group": widget.groupid,
    });
  }

  _sentmessage(List<String> image) async {
    try {
      ChatNetwork().createMessage(
          widget.id, _message.text.toString(), widget.groupid, image);
      _message.text = "";
      selectedUserAvatar = null;
    } catch (e) {
      print(e);
    }
  }

  TextEditingController _message = TextEditingController();

  blockuser() async {
    String userid = await getUserId();
    print("you clicked block user");
    try {
      bool result = await ChatNetwork()
          .blockuser(userid, widget.id, widget.groupid, true);
      if (result) {
        showtoast("You blocked successfully");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    socket.emit("disconnect", "group_${widget.groupid}");
    socket.onDisconnect((_) => print('disconnect'));
    super.dispose();
  }

  String convertime(now) {
    return DateFormat('KK:mm:a').format(now);
  }

  gotogame(user1, user2, user1name) async {
    try {
      List<GamesModel> games = await Games().getallgames();
      GameRequest gameRequest =
          await Games().sendgamerequest(games[0].id, widget.id);

      NavigateFunction().withquery(Navigate.quizGamePage +
          "?questionid=${games[0].id}&playid=${gameRequest.id}&user1=${user1}&user2=${user2}&istrue=${true}&user1name=${user1name}&user2name=${widget.name}");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: widget.onWeb
            ? null
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.grey[50],
        leading: widget.onWeb
            ? null
            : InkWell(
                onTap: () {
                  ChatNetwork().patchUnreadMessage(widget.groupid);
                  context.read<ChatProvider>().getGroupData("");
                  Navigator.pop(context);
                },
                child: Container(
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
              ),
        titleSpacing: 0,
        title: Container(
            child: Row(
          children: [
            if (widget.onWeb) SizedBox(width: 5),
            Container(
                child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: widget.image == null
                  ? AssetImage("assets/images/placeholder.png")
                  : NetworkImage(widget.image),
            )),
            Container(
                margin: EdgeInsetsDirectional.only(start: 10),
                child: widget.name == null
                    ? Text(
                        'Some One',
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
          FutureBuilder(
            future: Games().checkrequest(widget.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print("inga snapshot data enna varuthu");
                print(snapshot.data.questions);
                return Consumer<HomeProvider>(builder: (context, data, child) {
                  return InkWell(
                    onTap: () {
                      gotogame(data.userData.identificationImage, widget.image,
                          data.userData.firstName);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      child: Stack(
                        children: [
                          Container(
                              child: Image.asset(
                            'assets/images/clock.png',
                            width: 25,
                            height: 25,
                          )),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                    gradient: MainTheme.backgroundGradient,
                                    shape: BoxShape.circle)),
                          )
                        ],
                      ),
                    ),
                  );
                });
              } else {
                return Consumer<HomeProvider>(
                  builder: (context, data, child) {
                    return InkWell(
                      onTap: () {
                        gotogame(data.userData.identificationImage,
                            widget.image, data.userData.firstName);
                      },
                      child: Container(
                          child: Image.asset(
                        'assets/images/clock.png',
                        width: 25,
                        height: 25,
                      )),
                    );
                  },
                );
              }
            },
          ),
          Consumer<HomeProvider>(builder: (context, data, child) {
            return Container(
                padding: EdgeInsetsDirectional.only(end: 10),
                child: PopupMenuButton<String>(
                  initialValue: dropdownValue,
                  icon: Container(
                      child: Image.asset(
                    'assets/images/3dot.png',
                    width: 25,
                    height: 25,
                  )),
                  onSelected: (String result) async {
                    setState(() {
                      dropdownValue = result;
                    });
                    if (result == itemdate[0]) {
                      try {
                        await UserNetwork().getMatchedprofiledata(widget.id);
                      } catch (e) {
                        print(e);
                      }
                    }
                    if (result == itemdate[1]) {
                      blockuser();
                    }
                    if (result == itemdate[2]) {
                      gotogame(data.userData.identificationImage, widget.image,
                          data.userData.firstName);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      itemdate.map<PopupMenuEntry<String>>((String value) {
                    return PopupMenuItem<String>(
                      height: 45,
                      padding: EdgeInsets.only(left: 20, right: 15),
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    );
                  }).toList(),
                ));
          })
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          ChatNetwork().patchUnreadMessage(widget.groupid);
          socket.emit("disconnect", "group_${widget.groupid}");
          socket.onDisconnect((_) => print('disconnect'));
          context.read<ChatProvider>().getGroupData("");
          Navigator.pop(context);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Consumer<ChatProvider>(
                  builder: (context, data, child) {
                    return data.chatMessageState == ChatMessageState.Error
                        ? ErrorCard(
                            text: data.errorText,
                            ontab: () => context
                                .read<ChatProvider>()
                                .getMessageData(widget.groupid))
                        : data.chatMessageState == ChatMessageState.Loaded
                            ? data.chatMessageData.length == 0
                                ? Container()
                                : StickyGroupedListView<ChatMessage, DateTime>(
                                    addAutomaticKeepAlives: true,
                                    reverse: true,
                                    addSemanticIndexes: true,
                                    elements: data.chatMessageData,
                                    order: StickyGroupedListOrder.DESC,
                                    groupBy: (ChatMessage element) => DateTime(
                                        element.createdAt.year,
                                        element.createdAt.month,
                                        element.createdAt.day),
                                    groupComparator:
                                        (DateTime value1, DateTime value2) =>
                                            value1.compareTo(value2),
                                    itemComparator: (ChatMessage element1,
                                            ChatMessage element2) =>
                                        element1.createdAt
                                            .compareTo(element2.createdAt),
                                    floatingHeader: false,
                                    groupSeparatorBuilder:
                                        (ChatMessage element) => Container(
                                      color: Colors.white,
                                      height: 50,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: MainTheme.chatPageColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              DateFormat('dd-MM-yyyy').format(
                                                          element.createdAt) ==
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(
                                                              DateTime.now())
                                                  ? "Today"
                                                  : DateFormat('dd-MM-yyyy')
                                                              .format(element
                                                                  .createdAt) ==
                                                          DateFormat('dd-MM-yyyy')
                                                              .format(DateTime
                                                                      .now()
                                                                  .subtract(
                                                                      Duration(
                                                                          days:
                                                                              1)))
                                                      ? "Yesterday"
                                                      : '${element.createdAt.day}. ${element.createdAt.month}, ${element.createdAt.year}',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemBuilder: (_, ChatMessage element) {
                                      return Align(
                                        alignment: element.receiverDetails.first
                                                    .userId ==
                                                widget.id
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  widget.onWeb ? 22 : 30.w,
                                              vertical:
                                                  widget.onWeb ? 5 : 30.w),
                                          child: Card(
                                            elevation: widget.onWeb ? 5 : 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      element.receiverDetails[0]
                                                                  .userId ==
                                                              widget.id
                                                          ? MainTheme
                                                              .chatPageColor
                                                          : Colors.white),
                                              child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: widget.onWeb
                                                        ? 20
                                                        : 50.w,
                                                    vertical: widget.onWeb
                                                        ? inputFont
                                                        : 15.w,
                                                  ),
                                                  child:
                                                      element.images.length == 0
                                                          ? Column(
                                                              crossAxisAlignment: element
                                                                          .receiverDetails[
                                                                              0]
                                                                          .userId ==
                                                                      widget.id
                                                                  ? CrossAxisAlignment
                                                                      .end
                                                                  : CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  element
                                                                      .message,
                                                                  style:
                                                                      TextStyle(
                                                                    color: element.receiverDetails[0].userId ==
                                                                            widget
                                                                                .id
                                                                        ? Colors
                                                                            .white
                                                                        : Color(
                                                                            0xff4A4A4A),
                                                                    fontSize: widget
                                                                            .onWeb
                                                                        ? inputFont
                                                                        : 40.sp,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  convertime(element
                                                                      .createdAt),
                                                                  textAlign: element
                                                                              .receiverDetails[
                                                                                  0]
                                                                              .userId ==
                                                                          widget
                                                                              .id
                                                                      ? TextAlign
                                                                          .right
                                                                      : TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: element.receiverDetails[0].userId ==
                                                                            widget
                                                                                .id
                                                                        ? Colors
                                                                            .white
                                                                        : MainTheme
                                                                            .chatPageColor,
                                                                    fontSize: widget
                                                                            .onWeb
                                                                        ? 10
                                                                        : 25.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Column(
                                                              crossAxisAlignment: element
                                                                          .receiverDetails[
                                                                              0]
                                                                          .userId ==
                                                                      widget.id
                                                                  ? CrossAxisAlignment
                                                                      .end
                                                                  : CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CachedNetworkImage(
                                                                  height: widget
                                                                          .onWeb
                                                                      ? 250
                                                                      : 200.h,
                                                                  width: widget
                                                                          .onWeb
                                                                      ? 125
                                                                      : 500.w,
                                                                  imageUrl: element
                                                                      .images[0],
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Text(
                                                                  convertime(element
                                                                      .createdAt),
                                                                  textAlign: element
                                                                              .receiverDetails[
                                                                                  0]
                                                                              .userId ==
                                                                          widget
                                                                              .id
                                                                      ? TextAlign
                                                                          .right
                                                                      : TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: element.receiverDetails[0].userId ==
                                                                            widget
                                                                                .id
                                                                        ? Colors
                                                                            .white
                                                                        : MainTheme
                                                                            .chatPageColor,
                                                                    fontSize: widget
                                                                            .onWeb
                                                                        ? 10
                                                                        : 25.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                            : LoadingLottie();
                  },
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
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      selectUserImage();
                                    },
                                    child: RotationTransition(
                                        turns: new AlwaysStoppedAnimation(
                                            30 / 360),
                                        child: Icon(
                                          Icons.attach_file,
                                          color: Colors.black,
                                        )),
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Type a message...'),
                            ))),
                    InkWell(
                      onTap: () => _sentmessage([]),
                      child: Container(
                          child: CircleAvatar(
                        backgroundColor: MainTheme.chatPageColor,
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
      ),
    );
  }

  XFile selectedUserAvatar;
  Uint8List selectedWebAvatar;
  void selectUserImage() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ImageUploadAlert(
            onImagePicked: !kIsWeb
                ? (XFile imageData) {
                    setState(() {
                      selectedUserAvatar = imageData;
                    });
                    showPopup();
                  }
                : (Uint8List imageData) {
                    setState(() {
                      selectedWebAvatar = imageData;
                      print("bytes inga varuthaa");
                    });

                    showPopup();
                  },
          );
        });
  }

  bool loading = false;

  void showPopup() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (context1) => StatefulBuilder(builder: (context, setSState) {
              return Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: double.infinity,
                        height: 300.h,
                        child: !kIsWeb
                            ? Image.file(File(selectedUserAvatar.path))
                            : Image.memory(
                                selectedWebAvatar,
                              )),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                      child: loading
                          ? Center(child: CircularProgressIndicator())
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  InkWell(
                                    onTap: () {
                                      setSState(() {
                                        loading = true;
                                      });
                                      goToAlbumPage();
                                    },
                                    child: Container(
                                      height: 150.r,
                                      width: 150.r,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: MainTheme.backgroundGradient,
                                      ),
                                      child: Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      selectedUserAvatar = null;
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 150.r,
                                      width: 150.r,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[400],
                                      ),
                                      child: Icon(
                                        Icons.cancel,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ]),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              );
            }));
  }

  goToAlbumPage() async {
    String base64Image = base64Encode(selectedWebAvatar);
    try {
      ImageCheckModel resultsafe = await ImageCheckNetwork().check(base64Image);
      if (resultsafe.safe < resultsafe.unsafe) {
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
        showtoast("your image is restricted");
        return ImageCheckNetwork().addBadCount();
      }
    } on DioError catch (e) {
      return showtoast(DioException.fromDioError(e).toString());
    }
    var network = UploadImageWeb();

    String result =
        await network.uploadImage(selectedWebAvatar, "user_chat_images");
    print("image result correct a varuthaaaa");
    print(result);
    List<String> images = [];
    images.add(result);
    _sentmessage(images);
    selectedWebAvatar = null;
    Navigator.pop(context);
  }
}
