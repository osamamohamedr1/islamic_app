import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:islamic_app/core/utils/cache_helper.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/features/home/data/repos/prayers_time_repo.dart';
import 'package:islamic_app/features/home/presentation/manger/prayer_time_cubit/prayers_time_cubit.dart';
import 'package:islamic_app/features/home/presentation/views/widgets/all_custom_container.dart';
import 'package:islamic_app/features/home/presentation/views/widgets/azkar_section.dart';
import 'package:islamic_app/features/home/presentation/views/widgets/comming_prayer_time.dart';
import 'package:islamic_app/features/home/presentation/views/widgets/prayer_times_row.dart';
import 'package:jhijri/_src/_jHijri.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat(
      'd MMMM y',
      'ar_EG',
    ).format(DateTime.now());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PrayersTimeCubit(PrayersTimeRepo())..getPrayerTimes(),
        ),
      ],
      child: Scaffold(
        appBar: homeAppBar(
          formattedDate,
          context,
          CacheHelper.getData(key: locationName),
        ),
        body: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              PrayerTimesRow(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 16,
                  children: [
                    CommingPrayerFrame(),
                    AllCustomContainer(),
                    AzkarCategorySection(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar homeAppBar(
    String formattedDate,
    BuildContext context,
    String? location,
  ) => AppBar(
    scrolledUnderElevation: 0,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          HijriDate.now().toString(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
    automaticallyImplyLeading: false,
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'المكان',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              location ?? 'القاهرة',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
