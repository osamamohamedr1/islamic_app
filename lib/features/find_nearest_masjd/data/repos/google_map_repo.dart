import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/utils/failure.dart';
import 'package:location/location.dart';

class MapRepository {
  final Location _location = Location();

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
}
