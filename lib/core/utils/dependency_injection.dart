import 'package:get_it/get_it.dart';
import 'package:islamic_app/features/home/data/repos/home_repo.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<HomeRepo>(HomeRepo());
}
