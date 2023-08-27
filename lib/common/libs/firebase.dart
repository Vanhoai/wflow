import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wflow/configuration/environment.dart';

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
    channel = const AndroidNotificationChannel("Wflow", "Wflow");
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await registerNotification();

    final String deviceToken = await getDeviceToken() ?? "";
    print("deviceToken: $deviceToken");
  }

  static void subscribeToTopic(String topic) {
    firebaseMessaging.subscribeToTopic(topic);
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

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
              ),
            ),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<String?> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final String? token = await messaging.getToken();
    return token;
  }

  static Future<void> signInWithEmailLink(String email) async {
    await signOut();

    ActionCodeSettings actionCodeSettings = ActionCodeSettings(
      url: 'https://wflow-5100c.firebaseapp.com/finishSignUp?cartId=1234',
      handleCodeInApp: true,
      iOSBundleId: EnvironmentConfiguration.applicationID,
      androidPackageName: EnvironmentConfiguration.applicationID,
      androidInstallApp: true,
      androidMinimumVersion: '21',
    );

    await firebaseAuth.sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings);
  }

  static Future<void> signInWithPhoneNumber() async {
    await signOut();

    const String phoneNumber = '+84 989 467 834';
    const String codePhone = "984132";

    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(seconds: 30),
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        print("userCredential: ${userCredential.toString()}");
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = codePhone;
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        print("userCredential: ${userCredential.toString()}");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
