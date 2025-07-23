import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/core/utils/consts.dart';
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
}
