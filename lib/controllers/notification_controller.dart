import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationController {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Initialization with Permission Request
  Future<void> initNotification() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    print("Notification Permission: ${await Permission.notification.status}");
    print(
      "Exact Alarm Permission: ${await Permission.scheduleExactAlarm.status}",
    );

    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    print(currentTimeZone);

    // Request permission for Android 13+
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // Handle Exact Alarm Permission for Android 12+
    if (Platform.isAndroid && await Permission.scheduleExactAlarm.isDenied) {
      final intent = AndroidIntent(
        action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
        package:
            'com.example.takecare', // Replace with your actual package name
      );
      await intent.launch();
    }

    const initSettingAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initSettings = InitializationSettings(android: initSettingAndroid);

    await notificationsPlugin.initialize(initSettings);

    _isInitialized = true;
  }

  // Notification Details
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  // Show Notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(), // Use the correct details
    );
  }

  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.alarmClock,

      matchDateTimeComponents: DateTimeComponents.time,
    );

    print(
      "notification scheduled for ${now.year} ${now.month} ${now.day} $hour:$minute",
    );
    print("Current time: $now");
  }

  // Cancel Notification
  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }
}
