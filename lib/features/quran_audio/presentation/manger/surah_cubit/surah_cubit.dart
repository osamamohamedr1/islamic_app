import 'package:bloc/bloc.dart';
import 'package:islamic_app/features/quran_audio/data/models/surah_model.dart';
import 'package:islamic_app/features/quran_audio/data/repos/quran_audio_repo.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  SurahCubit() : super(SurahInitial());
  final QuranAudioRepo quranAudioRepo = QuranAudioRepo(AudioPlayer());
  void getSuraList() async {
    quranAudioRepo.getSuraList();
    final surahList = await quranAudioRepo.getSuraList();
    emit(SurahLoaded(surahList: surahList));
  }
}
