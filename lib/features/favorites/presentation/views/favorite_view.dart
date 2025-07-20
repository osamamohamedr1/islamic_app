import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/favorites/presentation/manger/cubit/favorite_cubit.dart';
import 'package:islamic_app/features/favorites/presentation/views/widgets/favorite_item.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          'المفضلة',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final favorite = state.favorites[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: FavortieItem(
                      text: favorite.text ?? 'لا يوجد مفضلة',
                      azkarArray: favorite,
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: Image.asset(Assets.imagesLoadingAnimation));
          }
        },
      ),
    );
  }
}
