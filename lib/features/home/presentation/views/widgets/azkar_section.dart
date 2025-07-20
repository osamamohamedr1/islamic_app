import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/routes/routes.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/core/utils/extensions.dart';
import 'package:islamic_app/features/azkar/presentation/manger/cubit/azkar_cubit_cubit.dart';
import 'package:islamic_app/features/favorites/presentation/manger/cubit/favorite_cubit.dart';
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
                  title: 'جوامع الدعاء',
                  iconPath: Assets.svgsDoua,
                  onTap: () {
                    context.pushNamed(Routes.allDua);
                    context.read<AzkarCubit>().getAllDua();
                  },
                ),
              ),

              Expanded(
                child: AzkarItem(
                  title: 'أذكار الصباح والمساء',
                  iconPath: Assets.svgsMorningAzkar,
                  onTap: () {
                    context.pushNamed(Routes.morningAndNightAzkar);
                    context.read<AzkarCubit>().getMorningAndNightAzkar();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: AzkarItem(
                  title: 'أذكار النوم',
                  iconPath: Assets.svgsNightAzkar,
                  onTap: () {
                    context.pushNamed(Routes.sleepAzkar);
                    context.read<AzkarCubit>().getSleepAzkar();
                  },
                ),
              ),
              Expanded(
                child: AzkarItem(
                  title: 'أذكار متنوعة',
                  iconPath: Assets.svgsDifferentAzkar,
                  onTap: () {
                    context.pushNamed(Routes.differentAzkarCollection);
                    context.read<AzkarCubit>().getDifferentAzkarCollection();
                  },
                ),
              ),

              Expanded(
                child: AzkarItem(
                  title: 'المفضلة',
                  iconPath: Assets.svgsFavorite,
                  onTap: () {
                    context.pushNamed(Routes.favoriteAzkar);
                    context.read<FavoriteCubit>().getFavorites();
                  },
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
                  title: 'التسبيح',
                  iconPath: Assets.svgsTasbeh,
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
