import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:islamic_app/features/find_nearest_masjd/data/models/mosque_model/place.dart';
import 'package:islamic_app/features/find_nearest_masjd/data/repos/google_map_repo.dart';
import 'package:meta/meta.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(this.mapRepository) : super(MapInitial());
  final MapRepository mapRepository;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  Set<Marker> get markers => _markers;
  Set<Polyline> get polylines => _polylines;

  void clearMarkers() => _markers.clear();

  void addMarker(Marker marker) {
    _markers.add(marker);
    emit(MarkerUpdated());
  }

  void addMarkers(Set<Marker> newMarkers) {
    _markers.addAll(newMarkers);
    emit(MarkerUpdated());
  }

  void replaceMarker(String markerId, Marker newMarker) {
    _markers.removeWhere((marker) => marker.markerId.value == markerId);
    _markers.add(newMarker);
    emit(MarkerUpdated());
  }

  void setPolylines(Set<Polyline> newPolylines) {
    _polylines
      ..clear()
      ..addAll(newPolylines);
    emit(PolylineUpdated());
  }

  Future<void> getLocation() async {
    emit(MapLoacationLoading());
    var currentLocation = await mapRepository.getCurrentLocation();
    currentLocation.fold(
      (failure) {
        emit(MapError(failure.errorMessage));
      },
      (location) {
        emit(LocationLoaded(LatLng(location.latitude!, location.longitude!)));
      },
    );
  }

  Future<void> getLiveLocation() async {
    emit(MapLoacationLoading());

    var liveLocation = await mapRepository.getLiveLocation();
    liveLocation.fold(
      (failure) {
        emit(MapError(failure.errorMessage));
      },
      (liveLocation) {
        liveLocation.listen((location) {
          emit(
            LiveLocationUpdate(LatLng(location.latitude!, location.longitude!)),
          );
        });
      },
    );
  }

  Future<void> getNearbyPLaces({required LatLng location}) async {
    emit(FindNearestMasjdLoading());
    var result = await mapRepository.getNearByPlaces(location);

    result.fold(
      (failure) {
        log(failure.errorMessage);
        emit(MapError(failure.errorMessage));
      },
      (masjds) {
        emit(GetNearestMasjd(masjds: masjds));
      },
    );
  }

  Future<void> createRoute({
    required LatLng originLocation,
    required LatLng destination,
  }) async {
    emit(CreateRouteLoading());
    var result = await mapRepository.getRoute(
      originLocation: originLocation,
      destination: destination,
    );

    result.fold(
      (failure) {
        log(failure.errorMessage);
        emit(MapError(failure.errorMessage));
      },
      (points) {
        emit(RouteCreated(points: points));
      },
    );
  }
}
