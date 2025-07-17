import 'package:flutter/material.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/home/data/models/prayer_model.dart';
import 'package:islamic_app/features/home/presentation/views/widgets/prayer_time_item.dart';

class PrayerTimesRow extends StatelessWidget {
  const PrayerTimesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        color: ColorsManger.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PrayerTimeItem(
            prayerModel: PrayerModel(
              name: 'الفجر',
              time: '04:30',
              iconPath: Assets.svgsFajr,
              isComming: true,
            ),
          ),
          PrayerTimeItem(
            prayerModel: PrayerModel(
              name: 'الظهر',
              time: '12:00',
              iconPath: Assets.svgsZhr,
              isComming: false,
            ),
          ),
          PrayerTimeItem(
            prayerModel: PrayerModel(
              name: 'العصر',
              time: '15:30',
              iconPath: Assets.svgsAsr,
              isComming: false,
            ),
          ),
          PrayerTimeItem(
            prayerModel: PrayerModel(
              name: 'المغرب',
              time: '18:00',
              iconPath: Assets.svgsMghreb,
              isComming: false,
            ),
          ),
          PrayerTimeItem(
            prayerModel: PrayerModel(
              name: 'العشاء',
              time: '19:30',
              iconPath: Assets.svgsEsha,
              isComming: false,
            ),
          ),
        ],
      ),
    );
  }
}
