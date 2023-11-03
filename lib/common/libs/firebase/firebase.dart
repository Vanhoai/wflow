import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wflow/firebase_options.dart';

part 'firebase_auth.dart';
part 'firebase_messaging.dart';

late final FirebaseApp firebaseApp;
late final FirebaseAuth firebaseAuth;
late final FirebaseMessaging firebaseMessaging;

late final AndroidNotificationChannel channel;
late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class FirebaseService {
  static Future<void> initialFirebase() async {
    firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
    firebaseMessaging = FirebaseMessaging.instance;

    channel = const AndroidNotificationChannel(
      'WFlow',
      'WFlow',
      importance: Importance.max,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      showBadge: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessagingService.setupLocalPushNotification();
    await FirebaseMessagingService.registerNotification();
  }
}
