import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/azkar/presentation/manger/cubit/azkar_cubit_cubit.dart';
import 'package:islamic_app/features/azkar/presentation/views/widgets/dua_item.dart';

class DifferentAzkarDetailsView extends StatelessWidget {
  const DifferentAzkarDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzkarCubit, AzkarCubitState>(
      builder: (context, state) {
        if (state is DifferentAzkarDetailsLoaded) {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              iconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                state.azkarModel.category ?? '',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: state.azkarModel.array!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? 16 : 0,
                      bottom: index == state.azkarModel.array!.length - 1
                          ? 24
                          : 16,
                    ),
                    child: DuaItem(
                      azkarArray: state.azkarModel.array![index],
                      onToggleFavorite: () {
                        context.read<AzkarCubit>().toggleFav(
                          index: index,
                          azkarId: state.azkarModel.array?[index].id ?? 0,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: Image.asset(Assets.imagesLoadingAnimation)),
          );
        }
      },
    );
  }
}
