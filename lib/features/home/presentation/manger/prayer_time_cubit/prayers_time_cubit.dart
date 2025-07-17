import 'package:bloc/bloc.dart';
import 'package:islamic_app/features/home/data/models/prayer_model.dart';
import 'package:islamic_app/features/home/data/repos/prayers_time_repo.dart';
import 'package:meta/meta.dart';

part 'prayers_time_state.dart';

class PrayersTimeCubit extends Cubit<PrayersTimeState> {
  PrayersTimeCubit(this.homeRepo) : super(PrayersTimeInitial());

  final PrayersTimeRepo homeRepo;
  void getPrayerTimes() {
    emit(PrayersTimeLoading());
    final prayerTimes = homeRepo.getPrayerTimes();
    prayerTimes.fold(
      (failure) => emit(PrayersTimeError(failure.errorMessage)),
      (prayerModelsList) {
        emit(PrayersTimeLoaded(prayerModelsList));
      },
    );
  }
}
