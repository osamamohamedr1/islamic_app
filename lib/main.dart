import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/routes/app_router.dart';
import 'package:islamic_app/core/routes/routes.dart';
import 'package:islamic_app/core/themes/app_themes.dart';
import 'package:islamic_app/core/utils/cache_helper.dart';
import 'package:islamic_app/features/bottom_nav_bar.dart/presentation/manger/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.initSharedPrefCaching();

  runApp(IslamicApp());
}

class IslamicApp extends StatelessWidget {
  const IslamicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeState) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: MaterialApp(
              locale: Locale('ar', 'EG'),
              themeMode: themeState,
              darkTheme: AppThemes.darkTheme,
              theme: AppThemes.lightTheme,
              initialRoute: Routes.bottomNavBar,
              onGenerateRoute: onGenerateRoute,
            ),
          );
        },
      ),
    );
  }
}
