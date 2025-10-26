import 'route.dart';

class RouteModel {
  List<RouteDetails>? routes;

  RouteModel({this.routes});

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
    routes: (json['routes'] as List<dynamic>?)
        ?.map((e) => RouteDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'routes': routes?.map((e) => e.toJson()).toList(),
  };
}
