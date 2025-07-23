part of 'surah_cubit.dart';

@immutable
sealed class SurahState {}

final class SurahInitial extends SurahState {}

final class SurahLoaded extends SurahState {
  final List<SurahModel> surahList;

  SurahLoaded({required this.surahList});
}
