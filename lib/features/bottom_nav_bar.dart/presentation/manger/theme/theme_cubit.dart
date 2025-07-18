import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/core/utils/cache_helper.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);
  final String themeModeKey = 'themeMode';
  final String kLight = 'light';
  final String kDark = 'dark';
  final String kSystem = 'system';
  void loadTheme() {
    final curretnThemeMode = CacheHelper.getData(key: themeModeKey);
    if (curretnThemeMode != null) {
      if (curretnThemeMode == kLight) {
        emit(ThemeMode.light);
      } else if (curretnThemeMode == kDark) {
        emit(ThemeMode.dark);
      } else {
        emit(ThemeMode.system);
      }
    } else {
      emit(ThemeMode.light);
    }
  }

  // void setTheme(ThemeMode theme) async {
  //   emit(theme);

  //   await CacheHelper.saveData(
  //     key: themeModeKey,
  //     value: theme == ThemeMode.system
  //         ? kSystem
  //         : theme == ThemeMode.light
  //             ? kLight
  //             : kDark,
  //   );
  // }

  void toggleTheme() async {
    final newTheme = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    emit(newTheme);
    await CacheHelper.saveData(
      key: themeModeKey,
      value: newTheme == ThemeMode.light ? kLight : kDark,
    );
  }
}
