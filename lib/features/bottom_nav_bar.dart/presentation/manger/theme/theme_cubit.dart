import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islamic_app/core/utils/consts.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);
  final String themeModeKey = 'themeMode';
  final String kLight = 'light';
  final String kDark = 'dark';
  final String kSystem = 'system';
  var box = Hive.box(themeBox);
  void loadTheme() {
    final curretnThemeMode = box.get(themeModeKey);
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
    await box.put(themeModeKey, newTheme == ThemeMode.light ? kLight : kDark);
  }
}
