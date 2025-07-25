import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:islamic_app/core/utils/failure.dart';
import 'package:islamic_app/env/env.dart';
import 'package:islamic_app/features/find_nearest_masjd/data/models/mosque_model/place.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class MapRepository {
  final Location _location = Location();
  final Dio dio = Dio();
  final mapKey = Env.key;
  Future<Either<Failure, LocationData>> getCurrentLocation() async {
    try {
      await _checkPermissions();
      _location.changeSettings(distanceFilter: 2);
      final location = await _location.getLocation();
      return Right(location);
    } catch (e) {
      return Left(Failure(errorMessage: "Current location error: $e"));
    }
  }

  Future<Either<Failure, Stream<LocationData>>> getLiveLocation() async {
    try {
      await _checkPermissions();
      var locaion = _location.onLocationChanged;
      return Right(locaion);
    } catch (e) {
      return Left(Failure(errorMessage: "Live location error: $e"));
    }
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) throw Exception("Service disabled");
    }

    var permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission != PermissionStatus.granted) {
        throw Exception("Permission denied");
      }
    }
  }

  Future<Either<Failure, List<Place>>> getNearByPlaces(LatLng location) async {
    try {
      final requestData = {
        "includedTypes": ["mosque"],
        "maxResultCount": 10,
        "locationRestriction": {
          "circle": {
            "center": {
              "latitude": location.latitude,
              "longitude": location.longitude,
            },
            "radius": 1000.0,
          },
        },
      };
      final headers = {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': mapKey,
        'X-Goog-FieldMask': 'places.displayName,places.location,places.rating',
        'Accept-Language': 'ar',
      };
      var result = await http.post(
        Uri.parse('https://places.googleapis.com/v1/places:searchNearby'),
        headers: headers,

        body: jsonEncode(requestData),
      );
      if (result.statusCode == 200) {
        final data = jsonDecode(result.body);

        final List places = data['places'] ?? [];
        List<Place> masjds = [];
        masjds = places.map((masjd) => Place.fromJson(masjd)).toList();
        // log(result.body);
        // log(masjds[0].displayName!.text ?? '');
        return right(masjds);
      } else {
        return Left(
          Failure(errorMessage: jsonDecode(result.body)['error']['message']),
        );
      }
    } catch (e) {
      log(e.toString());
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
