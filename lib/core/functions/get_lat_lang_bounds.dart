import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLngBounds getLatLangBounds(List<LatLng> points) {
  double southwestLat = points.first.latitude;
  double southwestLng = points.first.longitude;
  double northeastLat = points.first.latitude;
  double northeastLng = points.first.longitude;
  for (var point in points) {
    southwestLat = min(southwestLat, point.latitude);
    southwestLng = min(southwestLng, point.longitude);
    northeastLat = max(northeastLat, point.latitude);
    northeastLng = max(northeastLng, point.longitude);
  }
  return LatLngBounds(
    southwest: LatLng(southwestLat, southwestLng),
    northeast: LatLng(northeastLat, northeastLng),
  );
}
