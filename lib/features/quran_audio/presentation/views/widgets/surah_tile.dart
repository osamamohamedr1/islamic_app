import 'package:flutter/material.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/quran_audio/data/models/surah_model.dart';

class SurahTile extends StatelessWidget {
  final SurahModel surah;
  final bool isSelected;
  final VoidCallback onTap;

  const SurahTile({
    super.key,
    required this.surah,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? ColorsManger.primary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(
                color: ColorsManger.primary.withOpacity(0.2),
                width: .5,
              )
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: CircleAvatar(
          backgroundColor: isSelected
              ? ColorsManger.primary
              : ColorsManger.primary.withOpacity(0.1),
          child: Text(
            '${surah.id}',
            style: TextStyle(
              color: isSelected ? Colors.white : ColorsManger.primary,
              fontSize: isSelected ? 16 : 14,
            ),
          ),
        ),
        title: Text(
          surah.arabic ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected ? ColorsManger.primary : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: surah.english != null
            ? Text(
                surah.name!,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              )
            : null,
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isSelected
              ? Image.asset(
                  Assets.imagesVoiceAnimation,
                  color: ColorsManger.primary,
                  width: 40,
                  key: const ValueKey('voice_animation'),
                )
              : Icon(
                  Icons.play_circle_fill,
                  color: ColorsManger.primary,
                  size: 35,
                  key: const ValueKey('play_icon'),
                ),
        ),
        onTap: onTap,
      ),
    );
  }
}
