import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/quran_audio/presentation/manger/surah_cubit/surah_cubit.dart';
import 'package:islamic_app/features/quran_audio/presentation/views/widgets/surah_tile.dart';

class SurahListWidget extends StatelessWidget {
  final String? currentSurahName;
  final Function(int id, String name) onSurahTap;

  const SurahListWidget({
    super.key,
    required this.currentSurahName,
    required this.onSurahTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahCubit, SurahState>(
      builder: (context, state) {
        if (state is SurahLoaded) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.surahList.length,
            separatorBuilder: (_, __) =>
                Divider(color: ColorsManger.grey, height: 0, thickness: .2),
            itemBuilder: (context, index) {
              final surah = state.surahList[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == state.surahList.length - 1 ? 200 : 0,
                ),
                child: SurahTile(
                  surah: surah,
                  isSelected: surah.arabic == currentSurahName,
                  onTap: () => onSurahTap(surah.id ?? 1, surah.arabic ?? ''),
                ),
              );
            },
          );
        } else {
          return Image.asset(Assets.imagesLoadingAnimation);
        }
      },
    );
  }
}
