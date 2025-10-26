import 'package:hive/hive.dart';
import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
import 'package:islamic_app/core/utils/help_fun.dart';

class AzkrFunctionality {
  final HelpFun helpFun;

  AzkrFunctionality(this.helpFun);

  Future<AzkarModel> getAzkar({
    required int azkarId,
    required String boxName,
  }) async {
    final box = Hive.box<AzkarModel>(boxName);

    if (!box.containsKey(azkarId)) {
      await helpFun.loadSpecificSection(sectionId: azkarId, boxName: boxName);
    }

    return box.get(azkarId)!;
  }

  Future<void> toggleFavorite({
    required int index,
    required int azkarId,
    required String boxName,
  }) async {
    final box = Hive.box<AzkarModel>(boxName);
    final model = box.get(azkarId);

    model!.array![index].isFavorite = !model.array![index].isFavorite;

    await box.put(azkarId, model);
  }
}
