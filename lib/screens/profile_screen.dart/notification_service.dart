import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _fluttterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('logo');

  void initialseNotifications() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);
    await _fluttterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'ChannelName',
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    _fluttterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      notificationDetails,
    );
  }

  void schedhuleNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'ChannelName',
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    _fluttterLocalNotificationsPlugin.periodicallyShow(
      0,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails,
    );
  }

  void stopNotifications() async {
    _fluttterLocalNotificationsPlugin.cancel(0);
  }
}
