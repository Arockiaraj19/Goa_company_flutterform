import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/models/chatmessage_model.dart';
import 'package:dating_app/models/expertchatmessage_model.dart';
import 'package:dating_app/models/game_request_model.dart';
import 'package:dating_app/models/games.dart';
import 'package:dating_app/models/question_model.dart';
import 'package:dating_app/networks/chat_network.dart';
import 'package:dating_app/networks/client/api_list.dart';
import 'package:dating_app/networks/expertChat_netword.dart';
import 'package:dating_app/networks/games_network.dart';
import 'package:dating_app/networks/image_upload_network.dart';
import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/networks/user_network.dart';

import 'package:dating_app/providers/chat_provider.dart';
import 'package:dating_app/providers/expertChat_provider.dart';
import 'package:dating_app/providers/home_provider.dart';
import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/helpers/loadingLottie.dart';
import 'package:dating_app/shared/helpers/websize.dart';
import 'package:dating_app/shared/layouts/base_layout.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/error_card.dart';
import 'package:dating_app/shared/widgets/image_upload_alert.dart';
import 'package:dating_app/shared/widgets/navigation_rail.dart';
import 'package:dating_app/shared/widgets/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
// import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter/foundation.dart' show kIsWeb;

class ExpertChattingPage extends StatefulWidget {
  final String groupid;
  final String id;
  final String name;
  final bool onWeb;
  final double chatBoxWidth;
  final double floatingActionButtonWidth;
  final int status;
  final List<String> image;
  ExpertChattingPage(
      {Key key,
      this.groupid,
      this.id,
      this.name,
      this.onWeb = false,
      this.chatBoxWidth,
      this.floatingActionButtonWidth,
      this.status,
      this.image})
      : super(key: key);

  @override
  _ExpertChattingPageState createState() => _ExpertChattingPageState();
}

class _ExpertChattingPageState extends State<ExpertChattingPage> {
  TextEditingController _firstNameCtrl = TextEditingController();

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
    skip = 0;
    socket.onConnect((data) {
      // print('connect' + data);
    });
    print("subscribe varuthaa");
    print("group id correct a varuthuaaa");
    print(widget.groupid);
    context.read<ExpertChatProvider>().getMessageData(widget.groupid, skip);
    get();
  }

  get() async {
    await createGroupEmit();
    socket.on("expert_group_${widget.groupid}", (data) {
      print(data);
      final result = new Map<String, dynamic>.from(data);
      print("what message i get");
      print(result);
      ExpertChatMessage chatdata = ExpertChatMessage.fromMap(result);
      print(chatdata);
      return context
          .read<ExpertChatProvider>()
          .addsocketmessage(chatdata, widget.groupid);
    });
  }

  int skip = 0;
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
      ExpertNetwork().createMessage(
          widget.id, _message.text.toString(), widget.groupid, image);
      _message.text = "";
      selectedUserAvatar = null;
    } catch (e) {
      print(e);
    }
  }

  TextEditingController _message = TextEditingController();
  @override
  void didUpdateWidget(ExpertChattingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
    print(oldWidget.groupid);
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

  bool onNotification(ScrollEndNotification t) {
    if (t.metrics.pixels > 0 && t.metrics.atEdge) {
      skip += 1;
      print("at the end");
      print(skip);
      pagination();
    } else {
      print('I am at the start');
    }
    return true;
  }

  void pagination() async {
    await context
        .read<ExpertChatProvider>()
        .getMessageData(widget.groupid, skip);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 769) {
        return _buildPhone(context);
      } else {
        return _buildWeb(context);
      }
    });
  }

  Widget _buildWeb(context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      body: BaseLayout(
          navigationRail: NavigationMenu(
            currentTabIndex: 1,
          ),
          body: Container(
              color: Colors.grey[200],
              padding: EdgeInsetsDirectional.only(start: 2),
              child: _buildPhone(context))),
    );
  }

  SafeArea _buildPhone(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: widget.onWeb
          ? null
          : AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.grey[50],
              leading: InkWell(
                onTap: () => Navigator.pop(context),
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
                  Container(
                      child: widget.image.length == 0
                          ? CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage("assets/images/placeholder.png"))
                          : CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(widget.image[0]))),
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
                            )),
                  SizedBox(
                    width: 8,
                  ),
                  if (widget.status == 1)
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    )
                ],
              )),
              actions: [],
            ),
      body: WillPopScope(
        onWillPop: () {
          socket.emit("disconnect", "group_${widget.groupid}");
          socket.onDisconnect((_) => print('disconnect'));
          Navigator.pop(context);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Consumer<ExpertChatProvider>(
                  builder: (context, data, child) {
                    return data.chatState == ExpertChatState.Error
                        ? ErrorCard(
                            text: data.errorText,
                            ontab: () => context
                                .read<ExpertChatProvider>()
                                .getMessageData(widget.groupid, 0))
                        : data.chatState == ExpertChatState.Loaded
                            ? data.chatMessageData.length == 0
                                ? Container()
                                : NotificationListener(
                                    onNotification: onNotification,
                                    child: StickyGroupedListView<
                                        ExpertChatMessage, DateTime>(
                                      addAutomaticKeepAlives: true,
                                      reverse: true,
                                      addSemanticIndexes: true,
                                      elements: data.chatMessageData,
                                      order: StickyGroupedListOrder.DESC,
                                      groupBy: (ExpertChatMessage element) =>
                                          DateTime(
                                              element.createdAt.year,
                                              element.createdAt.month,
                                              element.createdAt.day),
                                      groupComparator:
                                          (DateTime value1, DateTime value2) =>
                                              value1.compareTo(value2),
                                      itemComparator:
                                          (ExpertChatMessage element1,
                                                  ExpertChatMessage element2) =>
                                              element1.createdAt.compareTo(
                                                  element2.createdAt),
                                      floatingHeader: false,
                                      groupSeparatorBuilder:
                                          (ExpertChatMessage element) =>
                                              Container(
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                DateFormat('dd-MM-yyyy').format(
                                                            element
                                                                .createdAt) ==
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
                                      itemBuilder:
                                          (_, ExpertChatMessage element) {
                                        return Align(
                                          alignment: element.userType == "2"
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
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        element.userType == "2"
                                                            ? MainTheme
                                                                .chatPageColor
                                                            : Colors.white),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: widget.onWeb
                                                          ? 20
                                                          : 50.w,
                                                      vertical: widget.onWeb
                                                          ? inputFont
                                                          : 15.w,
                                                    ),
                                                    child: element.images
                                                                .length ==
                                                            0
                                                        ? Column(
                                                            crossAxisAlignment: element
                                                                        .userType ==
                                                                    "2"
                                                                ? CrossAxisAlignment
                                                                    .end
                                                                : CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                element.message,
                                                                style:
                                                                    TextStyle(
                                                                  color: element
                                                                              .userType ==
                                                                          "2"
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
                                                                            .userType ==
                                                                        "2"
                                                                    ? TextAlign
                                                                        .right
                                                                    : TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  color: element
                                                                              .userType ==
                                                                          "2"
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
                                                                        .userType ==
                                                                    "2"
                                                                ? CrossAxisAlignment
                                                                    .end
                                                                : CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CachedNetworkImage(
                                                                height:
                                                                    widget.onWeb
                                                                        ? 250
                                                                        : 200.h,
                                                                width:
                                                                    widget.onWeb
                                                                        ? 125
                                                                        : 500.w,
                                                                imageUrl: element
                                                                    .images[0],
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                              Text(
                                                                convertime(element
                                                                    .createdAt),
                                                                textAlign: element
                                                                            .userType ==
                                                                        "2"
                                                                    ? TextAlign
                                                                        .right
                                                                    : TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  color: element
                                                                              .userType ==
                                                                          "2"
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
                                    ),
                                  )
                            : LoadingLottie();
                  },
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                        width: !widget.onWeb
                            ? MediaQuery.of(context).size.width - 55
                            : MediaQuery.of(context).size.width - 135,
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
    ));
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
    var network = UploadImageWeb();

    String result =
        await network.uploadImage(selectedWebAvatar, "user_chat_images");
    print("image result correct a varuthaaaa");
    print(result);
    List<String> images = [];
    images.add(result);
    _sentmessage(images);
    selectedUserAvatar = null;
    Navigator.pop(context);
  }
}
