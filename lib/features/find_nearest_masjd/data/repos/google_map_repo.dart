import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:islamic_app/core/utils/failure.dart';
import 'package:islamic_app/env/env.dart';
import 'package:islamic_app/features/find_nearest_masjd/data/models/mosque_model/place.dart';
import 'package:islamic_app/features/find_nearest_masjd/data/models/route_model/route_model.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class MapRepository {
  final Location _location = Location();

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
    try {
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
    } catch (e) {
      log(e.toString());
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
            "radius": 2000,
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
        log(result.body);
        log(masjds[0].displayName!.text ?? '');
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

  Future<Either<Failure, List<LatLng>>> getRoute({
    required LatLng originLocation,
    required LatLng destination,
  }) async {
    try {
      final requestData = {
        "origin": {
          "location": {
            "latLng": {
              "latitude": originLocation.latitude,
              "longitude": originLocation.longitude,
            },
          },
        },
        "destination": {
          "location": {
            "latLng": {
              "latitude": destination.latitude,
              "longitude": destination.longitude,
            },
          },
        },
        "travelMode": "DRIVE",
        "routingPreference": "TRAFFIC_AWARE",
        "computeAlternativeRoutes": false,
        "routeModifiers": {
          "avoidTolls": false,
          "avoidHighways": false,
          "avoidFerries": false,
        },
        "languageCode": "ar",
        "units": "METRIC",
      };
      final headers = {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': mapKey,
        'X-Goog-FieldMask':
            'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
        'Accept-Language': 'ar',
      };
      var result = await http.post(
        Uri.parse('https://routes.googleapis.com/directions/v2:computeRoutes'),
        headers: headers,

        body: jsonEncode(requestData),
      );

      if (result.statusCode == 200) {
        log(result.body);
        final data = jsonDecode(result.body);

        RouteModel route = RouteModel.fromJson(data);
        log(route.routes![0].polyline?.encodedPolyline ?? "");
        return right(
          decodeRoute(route.routes?[0].polyline?.encodedPolyline ?? ''),
        );
      } else {
        return Left(
          Failure(errorMessage: jsonDecode(result.body)['error']['message']),
        );
      }
    } catch (e) {
      log(e.toString());
      log('message');
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  List<LatLng> decodeRoute(String encodedString) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> points = polylinePoints.decodePolyline(encodedString);

    return points.map((e) => LatLng(e.latitude, e.longitude)).toList();
  }
}
