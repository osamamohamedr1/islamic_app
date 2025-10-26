import 'package:hive_flutter/adapters.dart';
import 'package:islamic_app/core/models/azkar_model/array.dart';
import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
import 'package:islamic_app/core/utils/consts.dart';

class FavoriteRepo {
  // Future<void> addToFavorites(AzkarModel azkar) async {
  //   await favoriteBox.put(azkar.id, azkar);
  // }

  // Future<void> removeFromFavorites(int id) async {
  //   await favoriteBox.delete(id);
  // }

  Future<List<AzkarArray>> getAllFavoriteDuas() async {
    List<AzkarArray> allFavorites = [];

    final List<String> allBoxNames = [azkarBox, differerntAzkarBox];

    for (String boxName in allBoxNames) {
      final box = Hive.box<AzkarModel>(boxName);

      for (var azkarModel in box.values) {
        if (azkarModel.array != null) {
          final favoriteDuas = azkarModel.array!
              .where((dua) => dua.isFavorite)
              .toList();

          allFavorites.addAll(favoriteDuas);
        }
      }
    }

    return allFavorites;
  }

  // bool isFavorite(int id) {
  //   return favoriteBox.containsKey(id);
  // }

  // Future<void> toggleFavorite(AzkarModel azkar) async {
  //   if (isFavorite(azkar.id!)) {
  //     await removeFromFavorites(azkar.id!);
  //   } else {
  //     await addToFavorites(azkar);
  //   }
  // }
}
