import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/choose_location/data/models/user_location_model.dart';

class UserLocationRepository {
  // Future<void> saveLocation(UserLocationModel location) async {
  //   final box = Hive.box(userLocationBox);
  //   await box.put(selectedLocation, location.toJson());
  // }

  // UserLocationModel? getSavedLocation() {
  //   final box = Hive.box(userLocationBox);
  //   final json = box.get(selectedLocation);
  //   if (json == null) return null;
  //   try {
  //     return UserLocationModel.fromJson(json);
  //   } catch (e) {
  //     log(e.toString());
  //     return null;
  //   }
  // }

  Future<List<UserLocationModel>> getAllCities() async {
    final String jsonString = await rootBundle.loadString(
      Assets.jsonCitiesLocation,
    );
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map(
          (cityJson) =>
              UserLocationModel.fromJson(cityJson as Map<String, dynamic>),
        )
        .toList();
  }
}
