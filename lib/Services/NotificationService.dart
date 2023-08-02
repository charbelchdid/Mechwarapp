import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void setupFirebaseMessaging() {
    // Request permission for receiving notifications (required for iOS)
    _firebaseMessaging.requestPermission();

    // Configure the Firebase messaging service
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      // Handle the received notification while the app is in the foreground
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked!');
      print('Message data: ${message.data}');

      // Handle the received notification when the user clicks on it
    });
  }
}
