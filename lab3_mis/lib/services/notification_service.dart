import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        navigatorKey.currentState?.pushNamed('/random');
        },
    );
  }

  Future<void> showReminder() async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'reminder_channel',
      'Random Meal Reminder',
      channelDescription: 'Random meal daily reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(1000),
      'Рандом рецепт!',
      'Кликни тука за да видиш нов рандом рецепт',
      platformDetails,
    );
  }

  Future<void> startRepeating({int seconds = 30}) async {
    await showReminder();
    Stream.periodic(Duration(seconds: seconds)).listen((_) {
      showReminder();
    });
  }

}
