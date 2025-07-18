import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    iconTheme: IconThemeData(color: ColorsManger.primary),
    scaffoldBackgroundColor: ColorsManger.offWhite,
    brightness: Brightness.light,
    primaryColor: ColorsManger.primary,
    colorScheme: ColorScheme.light(
      primary: ColorsManger.primary,
      secondary: ColorsManger.darkBLue,
    ),
    appBarTheme: AppBarTheme(backgroundColor: ColorsManger.offWhite),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: ColorsManger.darkBLue,
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: ColorsManger.darkBLue,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 18.sp),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 16.sp),
      bodySmall: TextStyle(color: ColorsManger.grey, fontSize: 14.sp),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 10,
      selectedIconTheme: IconThemeData(size: 28),
      selectedItemColor: ColorsManger.primary,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    iconTheme: IconThemeData(color: ColorsManger.primary),
    brightness: Brightness.dark,
    primaryColor: ColorsManger.darkBLue,
    colorScheme: ColorScheme.dark(
      primary: ColorsManger.darkBLue,
      secondary: ColorsManger.primary,
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: ColorsManger.darkBLue,
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 18.sp),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 16.sp),
      bodySmall: TextStyle(color: Colors.white, fontSize: 14.sp),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 5,
      selectedItemColor: ColorsManger.primary,
      unselectedItemColor: Colors.white70,
      backgroundColor: ColorsManger.darkCard,
    ),
  );
}
