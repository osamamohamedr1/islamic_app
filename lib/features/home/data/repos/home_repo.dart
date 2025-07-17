import 'dart:developer';
import 'package:adhan/adhan.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/home/data/models/prayer_model.dart';

class HomeRepo {
  List<PrayerModel> getPrayerTimes() {
    Coordinates coordinates = Coordinates(30.0444, 31.2357);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(coordinates, params);
    log(prayerTimes.maghrib.toString());
    final List<PrayerModel> prayerModelsList = [
      PrayerModel(
        name: 'الفجر',
        time: prayerTimes.fajr,
        iconPath: Assets.svgsFajr,
        isComming: false,
      ),
      PrayerModel(
        name: 'الظهر',
        time: prayerTimes.dhuhr,
        iconPath: Assets.svgsZhr,
        isComming: false,
      ),
      PrayerModel(
        name: 'العصر',
        time: prayerTimes.asr,
        iconPath: Assets.svgsAsr,
        isComming: false,
      ),
      PrayerModel(
        name: 'المغرب',
        time: prayerTimes.maghrib,
        iconPath: Assets.svgsMghreb,
        isComming: false,
      ),
      PrayerModel(
        name: 'العشاء',
        time: prayerTimes.isha,
        iconPath: Assets.svgsEsha,
        isComming: false,
      ),
    ];
    for (var prayer in prayerModelsList) {
      if (prayer.time.isAfter(DateTime.now())) {
        prayer.isComming = true;
        break;
      }
    }

    return prayerModelsList;
  }
}
