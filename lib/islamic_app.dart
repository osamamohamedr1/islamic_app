import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/routes/app_router.dart';
import 'package:islamic_app/core/routes/routes.dart';
import 'package:islamic_app/core/themes/app_themes.dart';
import 'package:islamic_app/core/utils/dependency_injection.dart';
import 'package:islamic_app/features/azkar/data/repos/azkar_repo.dart';
import 'package:islamic_app/features/azkar/presentation/manger/cubit/azkar_cubit_cubit.dart';
import 'package:islamic_app/features/bottom_nav_bar.dart/presentation/manger/theme/theme_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:islamic_app/features/favorites/data/repos/favorite_repo.dart';
import 'package:islamic_app/features/favorites/presentation/manger/cubit/favorite_cubit.dart';

class IslamicApp extends StatelessWidget {
  const IslamicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()..loadTheme()),

        BlocProvider(create: (context) => AzkarCubit(getIt.get<AzkarRepo>())),

        BlocProvider(
          create: (context) => FavoriteCubit(getIt.get<FavoriteRepo>()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeState) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => Builder(
              builder: (context) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  supportedLocales: const [
                    Locale('ar', 'EG'),
                    Locale('en', 'US'),
                  ],
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  locale: Locale('ar', 'EG'),
                  themeMode: themeState,
                  darkTheme: AppThemes.darkTheme,
                  theme: AppThemes.lightTheme,
                  initialRoute: Routes.bottomNavBar,
                  onGenerateRoute: onGenerateRoute,
                  builder: (context, child) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: child!,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
