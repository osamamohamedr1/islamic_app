import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/core/utils/consts.dart';

class HelpFun {
  Future<void> loadSpecificSection({
    required int sectionId,
    required String boxName,
  }) async {
    try {
      final String jsonString = await rootBundle.loadString(Assets.jsonAzkar);
      final jsonAzkar = jsonDecode(jsonString);

      for (var zkr in jsonAzkar) {
        if (zkr['id'] == sectionId) {
          var item = AzkarModel.fromJson(zkr);
          Hive.box<AzkarModel>(allDuaBox).put(item.id, item);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
