import 'package:flutter/material.dart';
import 'package:islamic_app/core/routes/routes.dart';
import 'package:islamic_app/features/azkar/presentation/views/different_azkar_view.dart';
import 'package:islamic_app/features/azkar/presentation/views/morning_and_night_azkar_view.dart';
import 'package:islamic_app/features/azkar/presentation/views/sleep_azkar_view.dart';
import 'package:islamic_app/features/azkar/presentation/views/widgets/azkar_different_collection_item.dart';
import 'package:islamic_app/features/bottom_nav_bar.dart/presentation/views/bottom_nav_bar_view.dart';
import 'package:islamic_app/features/azkar/presentation/views/all_doua_view.dart';
import 'package:islamic_app/features/home/presentation/views/home_view.dart';

Route onGenerateRoute(RouteSettings settting) {
  switch (settting.name) {
    case Routes.home:
      return MaterialPageRoute(
        builder: (context) {
          return HomeView();
        },
      );

    case Routes.bottomNavBar:
      return MaterialPageRoute(
        builder: (context) {
          return BottomNavBarView();
        },
      );
    case Routes.allDua:
      return MaterialPageRoute(
        builder: (context) {
          return AllDuaView();
        },
      );
    case Routes.morningAndNightAzkar:
      return MaterialPageRoute(
        builder: (context) {
          return MorningAndNightAzkarView();
        },
      );
    case Routes.sleepAzkar:
      return MaterialPageRoute(
        builder: (context) {
          return SleepAzkarView();
        },
      );
    case Routes.differentAzkarCollection:
      return MaterialPageRoute(
        builder: (context) {
          return AzkarDifferentCollectionList();
        },
      );
    case Routes.differentAzkarDetails:
      return MaterialPageRoute(
        builder: (context) {
          return DifferentAzkarDetailsView();
        },
      );
    default:
      return MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            body: Center(child: Text('No route defined for ${settting.name}')),
          );
        },
      );
  }
}
