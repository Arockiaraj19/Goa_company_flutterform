import 'package:dating_app/networks/sharedpreference/sharedpreference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class FCM{
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
  print("user id");
  print(id);
  await FirebaseMessaging.instance.subscribeToTopic(id);
}
}