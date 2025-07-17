part of 'prayers_time_cubit.dart';

@immutable
sealed class PrayersTimeState {}

final class PrayersTimeInitial extends PrayersTimeState {}

final class PrayersTimeLoading extends PrayersTimeState {}

final class PrayersTimeLoaded extends PrayersTimeState {
  final List<PrayerModel> prayerTimes;

  PrayersTimeLoaded(this.prayerTimes);
}

final class PrayersTimeError extends PrayersTimeState {
  final String message;

  PrayersTimeError(this.message);
}
