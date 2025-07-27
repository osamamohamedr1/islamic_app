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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? ColorsManger.primary.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(
                color: ColorsManger.primary.withOpacity(0.2),
                width: 0.5,
              )
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: CircleAvatar(
          backgroundColor: isSelected
              ? ColorsManger.primary
              : ColorsManger.primary.withOpacity(0.2),
          child: Text(
            '${surah.id}',
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontSize: isSelected ? 16 : 14,
            ),
          ),
        ),
        title: Text(
          surah.arabic ?? '',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: (isSelected
                ? (isDark ? Colors.white : ColorsManger.primary)
                : (isDark ? Colors.grey[400] : Colors.grey[700])),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: surah.english != null
            ? Text(
                surah.name!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.grey[400] : Colors.grey,
                ),
              )
            : null,
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isSelected
              ? Image.asset(
                  Assets.imagesVoiceAnimation,
                  color: isDark ? Colors.white : ColorsManger.primary,
                  width: 40,
                  key: const ValueKey('voice_animation'),
                )
              : Icon(
                  Icons.play_circle_fill,
                  color: isDark ? Colors.white : ColorsManger.primary,
                  size: 35,
                  key: const ValueKey('play_icon'),
                ),
        ),
        onTap: onTap,
      ),
    );
  }
}
