import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget imageViewer(String url) {
  return CachedNetworkImage(
    useOldImageOnUrlChange: true,
    fit: BoxFit.cover,
    placeholder: (context, url) => Image.asset(
      "assets/images/placeholder.png",
      height: (100),
      fit: BoxFit.cover,
    ),
    imageUrl: url,
    errorWidget: (context, url, error) => Image.asset(
      "assets/images/placeholder.png",
      height: (80),
      fit: BoxFit.cover,
    ),
  );
}
