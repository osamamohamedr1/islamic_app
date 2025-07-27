import 'package:adhan/adhan.dart';
import 'package:islamic_app/core/functions/notifications_service.dart';
import 'package:timezone/data/latest_all.dart' as tzData;

class PrayerNotificationService {
  static Future<void> scheduleDailyPrayerNotifications() async {
    tzData.initializeTimeZones();
    Coordinates coordinates = Coordinates(30.033333, 31.233334);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(coordinates, params);
    final now = DateTime.now();
    final Map<String, DateTime> prayers = {
      'الفجر': prayerTimes.fajr,
      'الظهر': prayerTimes.dhuhr,
      'العصر': prayerTimes.asr,
      'المغرب': prayerTimes.maghrib,
      'العشاء': prayerTimes.isha,
    };

    int id = 100;

    for (var entry in prayers.entries) {
      final prayerName = entry.key;
      final prayerTime = entry.value;

      if (prayerTime.isAfter(now)) {
        await NotificationService.scheduleNotification(
          id: id++,
          title: 'وقت الصلاة',
          body: ' حان وقت صلاة $prayerName',
          delay: prayerTime.difference(now),
        );
      }
    }
  }
}
