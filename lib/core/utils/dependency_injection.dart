import 'package:get_it/get_it.dart';
import 'package:islamic_app/core/utils/azkar_functionality.dart';
import 'package:islamic_app/core/utils/help_fun.dart';
import 'package:islamic_app/features/azkar/data/repos/azkar_repo.dart';
import 'package:islamic_app/features/favorites/data/repos/favorite_repo.dart';
import 'package:islamic_app/features/home/data/repos/prayers_time_repo.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<PrayersTimeRepo>(PrayersTimeRepo());
  getIt.registerSingleton<AzkarRepo>(AzkarRepo(AzkrFunctionality(HelpFun())));
  getIt.registerSingleton<FavoriteRepo>(FavoriteRepo());
}
