import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/features/quran_audio/data/models/reciter_model.dart';
import 'package:islamic_app/features/quran_audio/presentation/views/widgets/progress_bar_widget.dart';
import 'package:islamic_app/features/quran_audio/presentation/views/widgets/reciter_menu.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerControls extends StatelessWidget {
  final String? currentSurahName;
  final ReciterModel currentReciter;
  final bool isLoading;
  final bool isPlaying;
  final Function() onTogglePlayPause;
  final Function(ReciterModel reciter) onReciterChange;
  final Duration position;
  final Duration buffered;
  final Duration? duration;
  final AudioPlayer player;

  const AudioPlayerControls({
    super.key,
    required this.currentSurahName,
    required this.currentReciter,
    required this.isLoading,
    required this.isPlaying,
    required this.onTogglePlayPause,
    required this.onReciterChange,
    required this.position,
    required this.buffered,
    required this.duration,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),

        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'سورة ${currentSurahName ?? Hive.box(audioBox).get('surah') ?? 'الفاتحة'}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: ColorsManger.primary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              isLoading
                  ? const SizedBox(
                      width: 75,
                      height: 75,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          color: ColorsManger.primary,
                          strokeWidth: 3,
                        ),
                      ),
                    )
                  : IconButton(
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        size: 65,
                      ),
                      onPressed: onTogglePlayPause,
                      color: ColorsManger.primary,
                    ),
              Expanded(
                child: ReciterDropdown(
                  currentReciter: currentReciter,
                  onChanged: onReciterChange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ProgressBarWidget(
            position: position,
            buffered: buffered,
            duration: duration,
            player: player,
          ),
        ],
      ),
    );
  }
}
