// part of 'quran_cubit.dart';

// @immutable
// sealed class QuranAudioState {}

// class QuranAudioInitial extends QuranAudioState {}

// class QuranAudioLoading extends QuranAudioState {}

// class QuranAudioError extends QuranAudioState {
//   final String message;
//   QuranAudioError(this.message);
// }

// class SurahListLoaded extends QuranAudioState {
//   final List<SurahModel> surahList;
//   final String? currentSurahName;
//   final bool isPlaying;
//   final bool isLoading;
//   final ReciterModel currentReciter;
//   final Duration position;
//   final Duration buffered;
//   final Duration? duration;

//   SurahListLoaded({
//     required this.surahList,
//     required this.currentSurahName,
//     required this.isPlaying,
//     required this.isLoading,
//     required this.currentReciter,
//     required this.position,
//     required this.buffered,
//     required this.duration,
//   });

//   SurahListLoaded copyWith({
//     List<SurahModel>? surahList,
//     String? currentSurahName,
//     bool? isPlaying,
//     bool? isLoading,
//     ReciterModel? currentReciter,
//     Duration? position,
//     Duration? buffered,
//     Duration? duration,
//   }) {
//     return SurahListLoaded(
//       surahList: surahList ?? this.surahList,
//       currentSurahName: currentSurahName ?? this.currentSurahName,
//       isPlaying: isPlaying ?? this.isPlaying,
//       isLoading: isLoading ?? this.isLoading,
//       currentReciter: currentReciter ?? this.currentReciter,
//       position: position ?? this.position,
//       buffered: buffered ?? this.buffered,
//       duration: duration ?? this.duration,
//     );
//   }
// }
