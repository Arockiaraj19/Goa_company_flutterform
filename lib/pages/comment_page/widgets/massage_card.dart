import 'package:dating_app/models/chatgroup_model.dart';
import 'package:flutter/material.dart';

class MassageCard extends StatefulWidget {
  final double height;
  final double width;
  final Function onTap;
  final ChatGroup data;
  MassageCard({Key key, this.height, this.width, this.onTap, this.data})
      : super(key: key);

  @override
  _MassageCardState createState() => _MassageCardState();
}

class _MassageCardState extends State<MassageCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Container(
            margin: EdgeInsets.all(7),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsetsDirectional.only(end: 10, start: 10),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29uJTIwcG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                      ),
                    )),
                Container(
                    height: widget.height,
                    width: widget.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            widget.data.id.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: "Nunito"),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Can we go somewhere? ",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontFamily: "Nunito"),
                          ),
                        ),
                      ],
                    ))
              ],
            )));
  }
}
