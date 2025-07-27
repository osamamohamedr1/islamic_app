import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:islamic_app/core/functions/notification_prefresnces.dart';
import 'package:islamic_app/features/home/presentation/views/home_view.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('ic_notification');

    final ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final settings = InitializationSettings(
      android: android,
      iOS: ios,
      macOS: ios,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );

    await requestPermissions();
  }

  static Future<void> requestPermissions() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  static void _onNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null) debugPrint('Notification payload: $payload');

    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => HomeView()),
    );
  }

  /// Show a simple notification
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    final enabled = await NotificationPrefs.isEnabled();
    if (!enabled) return;
    const androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      sound: RawResourceAndroidNotificationSound('azan'),
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(id, title, body, details, payload: payload);
  }

  /// Schedule a notification using timezone
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required Duration delay,
    String? payload,
  }) async {
    final enabled = await NotificationPrefs.isEnabled();
    if (!enabled) return;
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(delay),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          channelDescription: 'your channel description',
          sound: RawResourceAndroidNotificationSound('azan'),
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  /// Periodic notification (not supported on Windows)
  static Future<void> repeatNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final enabled = await NotificationPrefs.isEnabled();
    if (!enabled) return;
    const androidDetails = AndroidNotificationDetails(
      'repeating_channel_id',
      'repeating_channel_name',
      channelDescription: 'repeating description',
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.everyMinute,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  /// Retrieve all pending notifications
  static Future<List<PendingNotificationRequest>> getPendingNotifications() {
    return _plugin.pendingNotificationRequests();
  }

  /// Retrieve all active notifications (Android 6.0+, iOS 10.0+, macOS 10.14+)
  static Future<List<ActiveNotification>> getActiveNotifications() async {
    return await _plugin.getActiveNotifications();
  }
}
