import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/bottom_nav_bar.dart/presentation/manger/theme/theme_cubit.dart';
import 'package:islamic_app/features/settings/presentation/views/widgets/setting_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          'الإعدادات',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 1),
          SettingItem(
            title: 'غامق',
            widget: SizedBox(
              height: 24,
              child: Switch(
                padding: EdgeInsets.all(0),
                value: context.watch<ThemeCubit>().state == ThemeMode.dark,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleTheme();
                },
              ),
            ),
          ),
          SettingItem(
            title: 'تحديث الموقع',
            widget: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SettingItem(
            title: 'التنبيهات',
            widget: Switch(
              value: true,
              onChanged: (value) {
                value = !value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
