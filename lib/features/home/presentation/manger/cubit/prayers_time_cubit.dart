import 'package:bloc/bloc.dart';
import 'package:islamic_app/features/home/data/models/prayer_model.dart';
import 'package:islamic_app/features/home/data/repos/home_repo.dart';
import 'package:meta/meta.dart';

part 'prayers_time_state.dart';

class PrayersTimeCubit extends Cubit<PrayersTimeState> {
  PrayersTimeCubit(this.homeRepo) : super(PrayersTimeInitial());

  final HomeRepo homeRepo;
  void getPrayerTimes() {
    try {
      emit(PrayersTimeLoading());
      final prayerTimes = homeRepo.getPrayerTimes();
      emit(PrayersTimeLoaded(prayerTimes));
    } catch (e) {
      emit(PrayersTimeError('Failed to load prayer times'));
    }
  }
}
