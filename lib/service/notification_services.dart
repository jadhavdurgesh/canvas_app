import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Initialize notifications
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
    );

    await _notifications.initialize(initSettings,
        onDidReceiveNotificationResponse: onSelectNotification);
  }
  

  // Show notification
  static Future<void> showNotification(String title, String body) async {
    print('Notification: $title - $body');
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'drawing_notifications',
      'Drawing Updates',
      channelDescription: 'Notifications about drawing activities',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  static Future<void> onSelectNotification(
      NotificationResponse response) async {
    print('Notification tapped: ${response.payload}');
  }
}
