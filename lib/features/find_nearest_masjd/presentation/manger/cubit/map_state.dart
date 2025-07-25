part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoacationLoading extends MapState {}

final class MapLocationLoaded extends MapState {
  final LatLng location;

  MapLocationLoaded(this.location);
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
