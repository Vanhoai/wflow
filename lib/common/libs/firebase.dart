import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';

late final FirebaseApp firebaseApp;
late final FirebaseAuth firebaseAuth;
late final FirebaseMessaging firebaseMessaging;

late final AndroidNotificationChannel channel;
late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class FirebaseService {
  static Future<void> initialFirebase() async {
    firebaseApp = await Firebase.initializeApp();
    firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
    firebaseMessaging = FirebaseMessaging.instance;
    channel = const AndroidNotificationChannel("WFlow", "WFlow");
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await registerNotification();
  }

  static Future<void> registerNotification() async {
    NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );

    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
        }

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        print("notification: $notification");
        print("android: $android");

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
    print("User Credential: $userCredential");
    return userCredential;
  }

  static Future<String?> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final String? token = await messaging.getToken();
    return token;
  }

  static Future<void> signInWithEmailLink(String email) async {}

  static Future<void> signInWithPhoneNumber() async {}
}
