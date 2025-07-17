import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:islamic_app/features/home/data/repos/home_repo.dart';
import 'package:islamic_app/features/home/presentation/manger/cubit/prayers_time_cubit.dart';
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
    return BlocProvider(
      create: (context) =>
          PrayersTimeCubit(PrayersTimeRepo())..getPrayerTimes(),

      child: Scaffold(
        appBar: homeAppBar(formattedDate, context),
        body: Column(
          spacing: 16,
          children: [
            PrayerTimesRow(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [CommingPrayerFrame()]),
            ),
          ],
        ),
      ),
    );
  }

  AppBar homeAppBar(String formattedDate, BuildContext context) => AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          HijriDate.now().toString(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 16,
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
              'القاهرة',
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
