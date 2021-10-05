import 'package:flutter/cupertino.dart';

String parseError(String message) {
  switch (message) {
    case 'username_already_registered':
      return 'A user already registered';

    default:
      return message;
  }
}

void removeFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
  return;
}
