import 'package:get_it/get_it.dart';
import 'package:islamic_app/features/dua/data/repos/dua_repo.dart';
import 'package:islamic_app/features/home/data/repos/prayers_time_repo.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<PrayersTimeRepo>(PrayersTimeRepo());
  getIt.registerSingleton<AllDuaRepo>(AllDuaRepo());
}
