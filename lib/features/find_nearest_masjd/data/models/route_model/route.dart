import 'polyline.dart';

class RouteDetails {
  num? distanceMeters;
  String? duration;
  Polyline? polyline;

  RouteDetails({this.distanceMeters, this.duration, this.polyline});

  factory RouteDetails.fromJson(Map<String, dynamic> json) => RouteDetails(
    distanceMeters: json['distanceMeters'] as int?,
    duration: json['duration'] as String?,
    polyline: json['polyline'] == null
        ? null
        : Polyline.fromJson(json['polyline']),
  );

  Map<String, dynamic> toJson() => {
    'distanceMeters': distanceMeters,
    'duration': duration,
    'polyline': polyline?.toJson(),
  };
}
