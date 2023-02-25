import 'package:fashion_shopping_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (message.data['route'] != null) {
    Get.toNamed(message.data['route']);
  }
}

class FirebaseService extends GetxService {
  Future<FirebaseApp> init() async {
    // Init Firebase
    final firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // FCM
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    messaging.subscribeToTopic('discount');
    // FCM forceground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    // FCM background message
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    return firebaseApp;
  }
}
