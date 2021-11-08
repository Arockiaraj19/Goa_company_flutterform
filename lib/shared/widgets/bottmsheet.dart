import 'package:dating_app/shared/widgets/subscription_bottomsheet.dart';
import 'package:flutter/material.dart';

class BottomSheetClass{
    showplans(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        // isDismissible: false,
        // enableDrag: false,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (BuildContext context) {
          return BottomsheetWidget();
        });
  }
}