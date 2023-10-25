part of 'firebase.dart';

class FirebaseMessagingService {
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

        print('notification: $notification');
        print('android: $android');

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android.smallIcon,
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
              ),
            ),
          );
        }

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  static Future<void> setupLocalPushNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> pushNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(channel.id, channel.name);
    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await FlutterLocalNotificationsPlugin().show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  static Future<String?> getDeviceToken() async {
    final String? token = await firebaseMessaging.getToken();
    return token;
  }
}
