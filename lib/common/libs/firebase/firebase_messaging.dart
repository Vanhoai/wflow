part of 'firebase.dart';

class FirebaseMessagingService {
  static Future<void> registerNotification() async {
    NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

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
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  static Future<void> setupLocalPushNotification() async {
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidInitializationSettings androidSetting = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const DarwinInitializationSettings darwinSetting = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidSetting,
      iOS: darwinSetting,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> pushNotification(
    String title,
    String body,
    List<AndroidNotificationAction>? actions,
  ) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelShowBadge: true,
      channelDescription: channel.description,
      actions: actions,
      when: DateTime.now().millisecondsSinceEpoch,
      visibility: NotificationVisibility.public,
      importance: Importance.max,
      channelAction: AndroidNotificationChannelAction.createIfNotExists,
      playSound: true,
      enableLights: true,
      showWhen: true,
      showProgress: true,
      priority: Priority.max,
      icon: 'mipmap/ic_launcher',
      fullScreenIntent: true,
      styleInformation: const DefaultStyleInformation(false, false),
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(1000),
      title,
      body,
      notificationDetails,
      payload: 'payload',
    );

    String deviceToken = await getDeviceToken() ?? '';
    print('Device Token: $deviceToken');
  }

  static Future<String?> getDeviceToken() async {
    final String? token = await firebaseMessaging.getToken();
    return token;
  }

  static Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }
}
