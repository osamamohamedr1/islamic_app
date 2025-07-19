import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/routes/routes.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/core/utils/extensions.dart';
import 'package:islamic_app/features/dua/presentation/manger/cubit/all_dua_cubit_cubit.dart';
import 'package:islamic_app/features/home/presentation/views/widgets/azkar_item.dart';

class AzkarCategorySection extends StatelessWidget {
  const AzkarCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AzkarItem(
                  title: 'أذكار المساء',
                  iconPath: Assets.svgsNightAzkar,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: AzkarItem(
                  title: 'أذكار الصباح',
                  iconPath: Assets.svgsMorningAzkar,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: AzkarItem(
                  title: 'أذكار الصلاة',
                  iconPath: Assets.svgsPrayerAzkar,
                  onTap: () {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: AzkarItem(
                  title: 'جوامع الدعاء',
                  iconPath: Assets.svgsDoua,
                  onTap: () {
                    context.pushNamed(Routes.allDua);
                    context.read<AllDuaCubitCubit>().getSpecificSection(1);
                  },
                ),
              ),
              Expanded(
                child: AzkarItem(
                  title: 'التسبيح',
                  iconPath: Assets.svgsTasbeh,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: AzkarItem(
                  title: 'المفضلة',
                  iconPath: Assets.svgsFavorite,
                  onTap: () {},
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: AzkarItem(
                  title: 'أقرب المساجد لك',
                  iconPath: Assets.svgsNearestMosque,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: AzkarItem(
                  title: 'أذكار متنوعة',
                  iconPath: Assets.svgsPrayerAzkar,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
