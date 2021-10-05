import 'package:dating_app/pages/home_page/widget/album_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AlbumCardList extends StatefulWidget {
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final int crossAxisCount;
  final int itemCount;
  final double childAspectRatio;
  final List<String> images;
  AlbumCardList(
      {Key key,
      this.crossAxisSpacing,
      this.mainAxisSpacing,
      this.crossAxisCount,
      this.itemCount,
      this.childAspectRatio, this.images})
      : super(key: key);

  @override
  _AlbumCardListState createState() => _AlbumCardListState();
}

class _AlbumCardListState extends State<AlbumCardList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: widget.crossAxisSpacing ?? 10,
          mainAxisSpacing: widget.mainAxisSpacing ?? 10,
          crossAxisCount: widget.crossAxisCount ?? 3,
          childAspectRatio: widget.childAspectRatio ?? 1.5),
      itemCount: widget.itemCount ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return AlbumCard(image: widget.images[index],);
      },
    );
  }
}
