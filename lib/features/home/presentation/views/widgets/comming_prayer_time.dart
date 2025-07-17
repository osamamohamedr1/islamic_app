import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/core/utils/dependency_injection.dart';
import 'package:islamic_app/features/home/data/repos/home_repo.dart';

class CommingPrayerFrame extends StatelessWidget {
  const CommingPrayerFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final commingPrayer = getIt.get<PrayersTimeRepo>().getNextPrayer();
    return Stack(
      children: [
        Image.asset(
          Assets.imagesCommingPrayerFrame,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),

        Positioned(
          left: 16,
          top: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'الصلاة القادمة',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 18),
              ),
              Text(
                commingPrayer.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                DateFormat('hh:mm a', 'ar').format(commingPrayer.time),

                textAlign: TextAlign.left,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
