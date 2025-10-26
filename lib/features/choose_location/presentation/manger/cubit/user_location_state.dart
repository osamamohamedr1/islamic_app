part of 'user_location_cubit.dart';

@immutable
sealed class UserLocationState {}

final class UserLocationInitial extends UserLocationState {}

final class LocationLoading extends UserLocationState {}

final class LocationLoaded extends UserLocationState {
  final List<UserLocationModel> cities;

  LocationLoaded({required this.cities});
}

final class SavedLocationLoaded extends UserLocationState {
  final UserLocationModel location;

  SavedLocationLoaded({required this.location});
}
