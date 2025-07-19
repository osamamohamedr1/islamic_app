import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/core/utils/help_fun.dart';

class AllDuaRepo {
  HelpFun helpFun = HelpFun();

  Future<AzkarModel> getAllDua() async {
    final box = Hive.box<AzkarModel>(allDuaBox);

    if (!box.containsKey(1)) {
      log('Loading specific section into Hive');
      await helpFun.loadSpecificSection(sectionId: 1, boxName: allDuaBox);
    }

    return box.get(1)!;
  }

  Future<void> toggleFavorite(int index) async {
    final box = Hive.box<AzkarModel>(allDuaBox);
    final model = box.get(1);

    model!.array![index].isFavorite = !model.array![index].isFavorite;

    await box.put(1, model);
    log('Toggled favorite for index $index: ${model.array![index].isFavorite}');
  }
}
