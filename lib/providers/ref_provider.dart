import 'package:flutter/material.dart';

class RefProvider extends ChangeNotifier {
  String _refId;
  String get refid => _refId;
  saveId(value) {
    print("ref id provider kku varuthaaa");
    print(value);
    _refId = value;
  }
}

class RefData {
  static String id;
}
