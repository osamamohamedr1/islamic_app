import 'package:flutter/material.dart';
import 'package:islamic_app/core/routes/routes.dart';
import 'package:islamic_app/features/bottom_nav_bar.dart/presentation/views/bottom_nav_bar_view.dart';
import 'package:islamic_app/features/dua/presentation/views/all_doua_view.dart';
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
