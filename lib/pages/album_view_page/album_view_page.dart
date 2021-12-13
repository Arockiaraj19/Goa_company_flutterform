import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AlbumView extends StatefulWidget {
  List<String> galleryItems;
  AlbumView({this.galleryItems});

  @override
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  @override
  void initState() {
    super.initState();
    print("you enter the page");
  }

  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: PhotoViewGallery.builder(
            
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.galleryItems[index]),
            initialScale: PhotoViewComputedScale.contained * 1,
            heroAttributes:
                PhotoViewHeroAttributes(tag: widget.galleryItems[index]),
          );
        },
        itemCount: widget.galleryItems.length,
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes,
            ),
          ),
        ),
        // backgroundDecoration: widget.backgroundDecoration,
        pageController: controller,
        allowImplicitScrolling: true,
        onPageChanged: (int) {
          print("ethanavathu $int");
        },
      )),
    );
  }
}
