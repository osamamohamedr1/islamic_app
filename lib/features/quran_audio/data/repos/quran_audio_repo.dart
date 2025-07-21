import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/quran_audio/data/models/surah_model.dart';

class QuranAudioRepo {
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
