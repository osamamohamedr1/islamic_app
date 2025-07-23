import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/features/quran_audio/data/models/reciter_model.dart';
import 'package:islamic_app/features/quran_audio/data/models/surah_model.dart';
import 'package:just_audio/just_audio.dart';

class QuranAudioRepo {
  final AudioPlayer player;
  final Box audio = Hive.box(audioBox);

  QuranAudioRepo(this.player);

  Future<List<SurahModel>> getSuraList() async {
    List<SurahModel> surahList = [];
    var json = await rootBundle.loadString(Assets.jsonSurahsData);
    var surahJson = jsonDecode(json);
    for (var surah in surahJson) {
      surahList.add(SurahModel.fromJson(surah));
    }
    return surahList;
  }

  Future<Map<String, dynamic>> initializePlayerState() async {
    try {
      // Load saved data
      final savedSurah = audio.get('surah');
      final savedUrl = audio.get('url');
      final savedReciterName = audio.get('reciterName');
      final savedReciterBaseUrl = audio.get('reciterBaseUrl');

      // Find current reciter
      ReciterModel currentReciter = reciters[0];
      if (savedReciterName != null && savedReciterBaseUrl != null) {
        currentReciter = reciters.firstWhere(
          (element) =>
              element.nameAr == savedReciterName &&
              element.baseUrl == savedReciterBaseUrl,
          orElse: () => reciters[0],
        );
      }

      // Set up audio player if there's a saved URL
      if (savedUrl != null) {
        await player.setUrl(savedUrl);
      }

      return {
        'currentSurahName': savedSurah,
        'currentReciter': currentReciter,
        'isPlaying': player.playing,
      };
    } catch (e) {
      log('Error initializing player state: $e');
      rethrow;
    }
  }

  Stream<Duration?> get durationStream => player.durationStream;
  Stream<Duration> get positionStream => player.positionStream;
  Stream<Duration> get bufferedPositionStream => player.bufferedPositionStream;
  Stream<PlayerState> get playerStateStream => player.playerStateStream;

  Future<void> playSurah(
    int id,
    String name,
    ReciterModel currentReciter,
  ) async {
    String url =
        '${currentReciter.baseUrl}/${id.toString().padLeft(3, '0')}.mp3';

    try {
      await audio.put('url', url);
      await audio.put('surah', name);
      await audio.put('reciterName', currentReciter.nameAr);
      await audio.put('reciterBaseUrl', currentReciter.baseUrl);

      await player.setUrl(url);
      await player.play();
    } catch (e) {
      log("Error playing surah: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> togglePlayPause() async {
    try {
      if (player.playing) {
        await player.pause();
        return {'isPlaying': false};
      } else {
        if (player.audioSource == null) {
          final url = audio.get('url');
          final name = audio.get('surah');
          if (url != null && name != null) {
            await player.setUrl(url);
            return {
              'isPlaying': false,
              'currentSurahName': name,
              'needsPlay': true,
            };
          } else {
            return {'isPlaying': false, 'playDefaultSurah': true};
          }
        }
        await player.play();
        return {'isPlaying': true};
      }
    } catch (e) {
      log("Error toggle play/pause: $e");
      rethrow;
    }
  }

  Future<void> stopPlayer() async {
    await player.stop();
  }

  Future<void> seekToPosition(Duration position) async {
    await player.seek(position);
  }

  bool get isPlaying => player.playing;
  bool get hasAudioSource => player.audioSource != null;
  Duration get currentPosition => player.position;
  Duration? get currentDuration => player.duration;
}
