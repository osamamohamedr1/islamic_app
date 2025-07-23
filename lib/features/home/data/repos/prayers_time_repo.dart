import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/core/utils/failure.dart';
import 'package:islamic_app/features/home/data/models/prayer_model.dart';

class PrayersTimeRepo {
  Either<Failure, List<PrayerModel>> getPrayerTimes() {
    try {
      Coordinates coordinates = Coordinates(30.033333, 31.233334);
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;
      final prayerTimes = PrayerTimes.today(coordinates, params);
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
      bool foundNext = false;
      for (var prayer in prayerModelsList) {
        if (!foundNext && prayer.time.isAfter(DateTime.now())) {
          prayer.isComming = true;
          foundNext = true;
        }
      }
      if (!foundNext) {
        prayerModelsList.first.isComming = true;
      }

      return right(prayerModelsList);
    } catch (e) {
      return left(Failure(errorMessage: 'Failed to fetch prayer times: $e'));
    }
  }

  PrayerModel calculateNextPrayer() {
    final result = getPrayerTimes();
    return result.fold(
      (failure) => PrayerModel(
        name: 'الفجر',
        time: DateTime.now(),
        iconPath: Assets.svgsFajr,
        isComming: true,
      ),
      (prayers) {
        for (var prayer in prayers) {
          if (prayer.time.isAfter(DateTime.now())) {
            return prayer;
          }
        }
        return prayers.first;
      },
    );
  }
}
