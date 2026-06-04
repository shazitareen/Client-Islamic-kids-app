// lib/services/notification_service.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Handles daily reminder notifications for the Daily Tasks module.
class NotificationService {
  static const int _dailyTasksNotificationId = 1001;
  static const String _channelId = 'daily_tasks_channel';
  static const String _channelName = 'Daily Islamic Tasks';

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  /// Initialise the notification plugin and timezone database.
  Future<void> initialize() async {
    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings: initSettings);

    // Create the notification channel for Android 8+
    const androidChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: 'Daily reminders for your Islamic habits',
      importance: Importance.high,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    debugPrint('Notification service initialized');
  }

  /// Requests notification permissions from the user.
  Future<void> requestPermissions() async {
    // For Android 13+
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // For iOS
    await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  /// Schedules a daily notification at the given hour and minute (24hr).
  /// Default: 7:00 AM every day.
  Future<void> scheduleDailyReminder({int hour = 7, int minute = 0}) async {
    await _notifications.cancel(id: _dailyTasksNotificationId);

    final scheduledTime = _nextInstanceOfTime(hour, minute);

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: 'Daily reminders for your Islamic habits',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    try {
      await _notifications.zonedSchedule(
        id: _dailyTasksNotificationId,
        title: '🌙 Daily Islamic Tasks',
        body: 'Have you completed your Islamic habits today? Tap to check! ✅',
        scheduledDate: scheduledTime,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
      );
      debugPrint('Daily reminder scheduled for $hour:${minute.toString().padLeft(2, '0')} every day');
    } catch (e) {
      debugPrint('Failed to schedule daily reminder: $e');
    }
  }

  /// Cancels the daily reminder notification.
  Future<void> cancelDailyReminder() async {
    await _notifications.cancel(id: _dailyTasksNotificationId);
  }

  /// Calculates the next occurrence of the given time.
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
