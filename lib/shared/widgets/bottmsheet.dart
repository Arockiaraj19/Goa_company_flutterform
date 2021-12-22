import 'package:dating_app/pages/notification/notification_page.dart';
import 'package:dating_app/pages/subscriptions/subscription_page.dart';

import 'package:dating_app/routes.dart';
import 'package:dating_app/shared/widgets/alert_widget.dart';
import 'package:dating_app/shared/widgets/subscription_bottomsheet.dart';
import 'package:flutter/material.dart';

class BottomSheetClass {
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

  showsub(context, {onWeb = false}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: 700,
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        if (onWeb == true) {
                          NavigateFunction().withquery(Navigate.findMatchPage);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(Icons.cancel)),
                  Expanded(
                    child: Subscription(
                      onboard: false,
                      swiperIndex: 1,
                      onWeb: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  shownav(context, {onWeb = false}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
                Container(width: 400, height: 500, child: NotificationPage()),
          );
        });
  }
}
