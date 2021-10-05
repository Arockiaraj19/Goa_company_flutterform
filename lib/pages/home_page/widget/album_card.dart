import 'package:flutter/material.dart';

class AlbumCard extends StatefulWidget {
  final String image;
  AlbumCard({Key key, this.image}) : super(key: key);

  @override
  _AlbumCardState createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.grey.shade200, blurRadius: 1.0)
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(widget.image??"",
                fit: BoxFit.cover)));
  }
}
