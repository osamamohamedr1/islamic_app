import 'package:bloc/bloc.dart';
import 'package:islamic_app/features/choose_location/data/models/user_location_model.dart';
import 'package:islamic_app/features/choose_location/data/repos/location_repo.dart';
import 'package:meta/meta.dart';

part 'user_location_state.dart';

class UserLocationCubit extends Cubit<UserLocationState> {
  UserLocationCubit() : super(UserLocationInitial());
  final UserLocationRepository _repository = UserLocationRepository();
  Future<void> loadCities() async {
    emit(LocationLoading());
    final cities = await _repository.getAllCities();

    emit(LocationLoaded(cities: cities));
  }

  // Future<void> saveLocation(UserLocationModel location) async {
  //   await _repository.saveLocation(location);
  // }

  // void getSavedLocation() {
  //   var location = _repository.getSavedLocation();
  //   emit(SavedLocationLoaded(location: location!));
  // }
}
