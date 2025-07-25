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

  Future<void> getLocation() async {
    emit(MapLoacationLoading());
    var currentLocation = await mapRepository.getCurrentLocation();
    currentLocation.fold(
      (failure) {
        emit(MapError(failure.errorMessage));
      },
      (location) {
        emit(
          MapLocationLoaded(LatLng(location.latitude!, location.longitude!)),
        );
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
}
