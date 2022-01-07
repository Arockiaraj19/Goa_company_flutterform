import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:dating_app/networks/topic_network.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  initPushNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    String id = await getUserId();
    String token = await getFCMToken();
    print("user id");
    print(id);
    if (token.isNotEmpty) {
      print("user id token subscripte aakutha");
      Topic().subscripeToken(token, id);
    }
  }
}
