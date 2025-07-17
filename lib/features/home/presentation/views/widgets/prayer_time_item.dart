import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/features/home/data/models/prayer_model.dart';

class PrayerTimeItem extends StatelessWidget {
  const PrayerTimeItem({super.key, required this.prayerModel});

  final PrayerModel prayerModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: prayerModel.isComming ? Colors.lightBlue : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            prayerModel.iconPath,
            width: 28,
            colorFilter: ColorFilter.mode(
              prayerModel.isComming ? Colors.white : Colors.grey,
              BlendMode.srcATop,
            ),
          ),
          Text(
            prayerModel.name,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 16,
              fontWeight: prayerModel.isComming
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: prayerModel.isComming ? Colors.white : ColorsManger.grey,
            ),
          ),
          Text(
            prayerModel.time,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: prayerModel.isComming
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: prayerModel.isComming ? Colors.white : ColorsManger.grey,
            ),
          ),
        ],
      ),
    );
  }
}
