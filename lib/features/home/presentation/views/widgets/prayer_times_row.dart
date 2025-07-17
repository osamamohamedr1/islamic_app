import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/features/home/presentation/manger/cubit/prayers_time_cubit.dart';
import 'package:islamic_app/features/home/presentation/views/widgets/prayer_time_item.dart';

class PrayerTimesRow extends StatelessWidget {
  const PrayerTimesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(color: ColorsManger.lightGrey),
      child: BlocBuilder<PrayersTimeCubit, PrayersTimeState>(
        builder: (context, state) {
          if (state is PrayersTimeLoaded) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(state.prayerTimes.length, (index) {
                final prayer = state.prayerTimes[index];
                return PrayerTimeItem(prayerModel: prayer);
              }),
            );
          } else if (state is PrayersTimeError) {
            return Center(
              child: Text(
                state.message,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.red),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: ColorsManger.primary),
            );
          }
        },
      ),
    );
  }
}
