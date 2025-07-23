import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:just_audio/just_audio.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    super.key,
    required Duration position,
    required Duration buffered,
    required Duration? duration,
    required AudioPlayer player,
  }) : _position = position,
       _buffered = buffered,
       _duration = duration,
       _player = player;

  final Duration _position;
  final Duration _buffered;
  final Duration? _duration;
  final AudioPlayer _player;

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      progress: _position,
      buffered: _buffered,
      total: _duration ?? Duration.zero,
      progressBarColor: ColorsManger.primary,
      baseBarColor: Colors.amber,
      bufferedBarColor: Colors.blue.withOpacity(0.5),
      thumbColor: ColorsManger.primary,
      timeLabelTextStyle: Theme.of(
        context,
      ).textTheme.bodySmall!.copyWith(color: Colors.white),
      timeLabelPadding: 4,
      barHeight: 3.0,
      thumbRadius: 6.0,

      onSeek: (duration) {
        _player.seek(duration);
      },
    );
  }
}
