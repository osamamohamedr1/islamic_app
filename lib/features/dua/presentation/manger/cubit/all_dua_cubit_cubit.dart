import 'package:bloc/bloc.dart';
import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
import 'package:islamic_app/features/dua/data/repos/dua_repo.dart';
import 'package:meta/meta.dart';

part 'all_dua_cubit_state.dart';

class AllDuaCubitCubit extends Cubit<AllDuaCubitState> {
  AllDuaCubitCubit(this.duaRepo) : super(AllDuaCubitInitial());
  final AllDuaRepo duaRepo;

  Future<void> getSpecificSection(int sectionId) async {
    var result = await duaRepo.getAllDua();
    emit(AllDuaCubitLoaded(result));
  }

  Future<void> toggleFavorite(int index) async {
    await duaRepo.toggleFavorite(index);
  }
}
