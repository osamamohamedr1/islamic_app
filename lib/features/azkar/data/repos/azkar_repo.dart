import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/core/utils/azkar_functionality.dart';
import 'package:islamic_app/core/utils/consts.dart';

class AzkarRepo {
  final AzkrFunctionality azkarFunctionality;

  AzkarRepo(this.azkarFunctionality);

  Future<AzkarModel> getAzkar({
    required String boxName,
    required int azkarId,
  }) async {
    return await azkarFunctionality.getAzkar(
      azkarId: azkarId,
      boxName: boxName,
    );
  }

  Future<void> toggleFavorite({
    required int index,
    required int azkarId,
  }) async {
    await azkarFunctionality.toggleFavorite(
      index: index,
      azkarId: azkarId,
      boxName: azkarBox,
    );
  }

  Future<List<AzkarModel>> differentAzkarCollection() async {
    List<AzkarModel> azkarCollection = [];
    var box = Hive.box<AzkarModel>(differerntAzkarBox);
    if (box.isNotEmpty) {
      return box.values.toList();
    }
    try {
      final String jsonString = await rootBundle.loadString(Assets.jsonAzkar);
      final jsonAzkar = jsonDecode(jsonString);

      for (var zkr in jsonAzkar) {
        azkarCollection.add(AzkarModel.fromJson(zkr));
      }
      box.addAll(azkarCollection);
      return azkarCollection;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
