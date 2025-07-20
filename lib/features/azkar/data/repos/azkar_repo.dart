import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
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
}
