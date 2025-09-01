part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoacationLoading extends MapState {}

final class FindNearestMasjdLoading extends MapState {}

final class CreateRouteLoading extends MapState {}

final class MarkerUpdated extends MapState {}

final class PolylineUpdated extends MapState {}

final class LocationLoaded extends MapState {
  final LatLng location;

  LocationLoaded(this.location);
}

final class LiveLocationUpdate extends MapState {
  final LatLng location;

  LiveLocationUpdate(this.location);
}

final class MapError extends MapState {
  final String message;

  MapError(this.message);
}

final class GetNearestMasjd extends MapState {
  final List<Place> masjds;

  GetNearestMasjd({required this.masjds});
}

final class RouteCreated extends MapState {
  final List<LatLng> points;

  RouteCreated({required this.points});
}
