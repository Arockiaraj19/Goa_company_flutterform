// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Widget adsenseAdsView() {
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
      'adViewType',
      (int viewID) => IFrameElement()
        ..width = '320'
        ..height = '60'
        ..src = 'adview.html'
        ..style.border = 'none');

  return SizedBox(
    height: 250.0,
    width: 320.0,
    child: HtmlElementView(
      viewType: 'adViewType',
    ),
  );
}

class GoogleAdsCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: adsenseAdsView(),
      ),
    );
  }
}
