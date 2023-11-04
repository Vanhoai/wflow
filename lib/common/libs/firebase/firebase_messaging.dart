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
          pushNotification(
            id: notification.hashCode,
            title: notification.title!,
            body: notification.body!,
          );
        }
      });
    } else {
      AlertUtils.showMessage('Notification', 'Please allow notification in setting');
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

  static Future<void> pushNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelShowBadge: true,
      channelDescription: channel.description,
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
      ticker: 'ticker',
      timeoutAfter: 5000,
      color: Colors.blue,
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: 'payload',
    );
  }

  static Future<String?> getDeviceToken() async {
    final String? token = await firebaseMessaging.getToken();
    return token;
  }

  static Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }
}
