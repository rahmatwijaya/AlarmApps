import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'apputama.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("background notification");
  print(message.notification!.title);
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await requestizin();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const AlarmApps());
}
// eV4MevGxTqSQSFQrXjkjgm:APA91bFFAze1CE36BvlkkfFOTT49XCa7WGjYxglidTAxS__Lb2aaASVKe5fSM1WqsoFISCN7Mr45aUFkL6pLCAr_CTTks6sBBruNzqMEh2ts9d6wVhYpXertuUT0iyRnIpy_DqD-lFT0
Future <void> requestizin() async{
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

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

