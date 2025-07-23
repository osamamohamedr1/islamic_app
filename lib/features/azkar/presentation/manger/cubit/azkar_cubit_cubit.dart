import 'package:bloc/bloc.dart';
import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/features/azkar/data/repos/azkar_repo.dart';
import 'package:meta/meta.dart';

part 'azkar_cubit_state.dart';

class AzkarCubit extends Cubit<AzkarCubitState> {
  AzkarCubit(this.azkarRepo) : super(AzkarCubitInitial());

  final AzkarRepo azkarRepo;
  Future<void> getAllDua() async {
    var result = await azkarRepo.getAzkar(boxName: azkarBox, azkarId: 1);
    emit((AllDuaoaded(result)));
  }

  Future<void> getMorningAndNightAzkar() async {
    var result = await azkarRepo.getAzkar(boxName: azkarBox, azkarId: 2);
    emit(MorningAndNightAzkarLoaded(result));
  }

  Future<void> getSleepAzkar() async {
    var result = await azkarRepo.getAzkar(boxName: azkarBox, azkarId: 3);
    emit(SleepAkarLoaded(result));
  }

  Future<void> getDifferentAzkarCollection() async {
    var result = await azkarRepo.differentAzkarCollection();
    emit(DifferentAzkarCollectionLoaded(result));
  }

  Future<void> getAzkarDetails({required int azkarId}) async {
    var result = await azkarRepo.getAzkar(
      azkarId: azkarId,
      boxName: differerntAzkarBox,
    );
    emit(DifferentAzkarDetailsLoaded(result));
  }

  Future<void> toggleFav({required int index, required int azkarId}) async {
    await azkarRepo.toggleFavorite(index: index, azkarId: azkarId);
  }
}
