import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/bottom_nav_bar.dart/presentation/manger/theme/theme_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Switch(
              value: context.read<ThemeCubit>().state == ThemeMode.light,
              onChanged: (value) {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
