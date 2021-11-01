import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AlbumImageCard extends StatefulWidget {
  final String alreadyimage;
  final String image;
  final Color colors;
  final Function onTap;
  final bool isFile;
  final XFile selectedUserAvatar;
  final Function onTapClose;

  AlbumImageCard(
      {Key key,
      this.alreadyimage,
      this.image,
      this.colors,
      this.onTap,
      this.isFile = false,
      this.selectedUserAvatar,
      this.onTapClose})
      : super(key: key);

  @override
  _AlbumImageCardState createState() => _AlbumImageCardState();
}

class _AlbumImageCardState extends State<AlbumImageCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height / 6,
            child: InkWell(
                onTap: () {
                  widget.onTap();
                  print(Platform.isAndroid);
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: widget.selectedUserAvatar != null
                        ? Platform.isAndroid
                            ? Image.file(
                                File(widget.selectedUserAvatar.path),
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                widget.selectedUserAvatar.path,
                                fit: BoxFit.fill,
                              )
                        : widget.alreadyimage == null
                            ? Image.asset(
                                "assets/images/Add_image.png",
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                widget.alreadyimage,
                                fit: BoxFit.fill,
                              )))),
        Positioned(
            top: 0,
            right: 0,
            child: Center(
                child: InkWell(
                    onTap: () {
                      widget.onTapClose();
                    },
                    child: CircleAvatar(
                        backgroundColor: widget.colors ?? Colors.grey[200],
                        radius: 16,
                        child: Icon(
                          FontAwesomeIcons.timesCircle,
                          size: 15,
                          color: Colors.red,
                        )))))
      ],
    );
  }
}
