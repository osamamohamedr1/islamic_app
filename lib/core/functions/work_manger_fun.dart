import 'package:islamic_app/core/functions/notifications_service.dart';
import 'package:islamic_app/features/prayer_notifications/data/repos/prayer_notification_service.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    await NotificationService.initialize();

    await PrayerNotificationService.scheduleDailyPrayerNotifications();

    return Future.value(true);
  });
}

Future<void> registerPrayerNotificationTask() async {
  await Workmanager().registerPeriodicTask(
    "1",
    "daily_prayer_task",
    frequency: Duration(hours: 24),
    initialDelay: Duration(minutes: 1),
    inputData: {'lat': 30.0444, 'lng': 31.2357},
  );
}
