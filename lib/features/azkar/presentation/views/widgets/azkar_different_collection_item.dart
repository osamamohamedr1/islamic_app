import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/models/azkar_model/azkar_model.dart';
import 'package:islamic_app/core/routes/routes.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/core/utils/extensions.dart';
import 'package:islamic_app/features/azkar/presentation/manger/cubit/azkar_cubit_cubit.dart';

class AzkarDifferentCollectionList extends StatelessWidget {
  const AzkarDifferentCollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          'أذكار متنوعة',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AzkarCubit, AzkarCubitState>(
        buildWhen: (previous, current) =>
            current is DifferentAzkarCollectionLoaded,
        builder: (context, state) {
          if (state is DifferentAzkarCollectionLoaded) {
            List<AzkarModel> filteredCollection = state.azkarCollection
                .skip(3)
                .toList();

            return ListView.builder(
              itemCount: filteredCollection.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.differentAzkarDetails);
                      context.read<AzkarCubit>().getAzkarDetails(
                        azkarId: (filteredCollection[index].id! + 1),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 12 : 0),
                      child: AzkarCollectionItem(
                        title: filteredCollection[index].category ?? '',
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Image.asset(Assets.imagesLoadingAnimation));
          }
        },
      ),
    );
  }
}

class AzkarCollectionItem extends StatelessWidget {
  const AzkarCollectionItem({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 12),

      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode ? ColorsManger.darkCard : ColorsManger.lightBlue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          Icon(Icons.arrow_forward_rounded, size: 22),
        ],
      ),
    );
  }
}
