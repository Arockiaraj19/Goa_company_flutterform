import 'package:dating_app/pages/chatting_page/wigets/chatt_box.dart';
import 'package:dating_app/pages/detail_page/detail_page.dart';
import 'package:dating_app/shared/theme/theme.dart';
import 'package:dating_app/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:web_socket_channel/status.dart' as status;

class ChattingPage extends StatefulWidget {
  final String image;
  final String name;
  final bool onWeb;
  final double chatBoxWidth;
  final double floatingActionButtonWidth;
  ChattingPage(
      {Key key,
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
                            itemBuilder: (BuildContext context) => itemdate
                                .map<PopupMenuEntry<String>>((String value) {
                              return PopupMenuItem<String>(
                                height: 30,
                                padding: EdgeInsets.only(left: 20, right: 5),
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
            body: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  ChattBox(width: widget.chatBoxWidth),
                  ChattBox(
                    width: widget.chatBoxWidth,
                    sendMsg: true,
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Row(
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
                          border:
                              Border.all(width: 1, color: Colors.grey.shade200),
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
                Container(
                    child: CircleAvatar(
                  backgroundColor: MainTheme.primaryColor,
                  radius: 22,
                  child: Icon(
                    FontAwesomeIcons.solidPaperPlane,
                    color: Colors.white,
                    size: 17,
                  ),
                ))
              ],
            )));
  }
}
