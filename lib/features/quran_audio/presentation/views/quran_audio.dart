import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/features/quran_audio/data/models/reciter_model.dart';
import 'package:islamic_app/features/quran_audio/presentation/manger/surah_cubit/surah_cubit.dart';
import 'package:islamic_app/features/quran_audio/presentation/views/widgets/progress_bar_widget.dart';
import 'package:just_audio/just_audio.dart';

class QuranAudioView extends StatefulWidget {
  const QuranAudioView({super.key});

  @override
  State<QuranAudioView> createState() => _QuranAudioViewState();
}

class _QuranAudioViewState extends State<QuranAudioView>
    with AutomaticKeepAliveClientMixin {
  final AudioPlayer _player = AudioPlayer();
  String? currentSurahName;
  bool isPlaying = false;
  bool isLoading = false;
  Duration? _duration;
  Duration _position = Duration.zero;
  Duration _buffered = Duration.zero;
  var audio = Hive.box(audioBox);
  ReciterModel _currentReciter = reciters[0];

  @override
  void initState() {
    super.initState();

    // Load saved values
    final savedSurah = audio.get('surah');
    final savedUrl = audio.get('url');
    final savedReciterName = audio.get('reciterName');
    final savedReciterBaseUrl = audio.get('reciterBaseUrl');

    // If values exist, set current variables
    if (savedSurah != null &&
        savedUrl != null &&
        savedReciterName != null &&
        savedReciterBaseUrl != null) {
      setState(() {
        currentSurahName = savedSurah;
        _currentReciter = reciters.firstWhere(
          (element) =>
              element.nameAr == savedReciterName &&
              element.baseUrl == savedReciterBaseUrl,
          orElse: () => reciters[0],
        );
      });

      // Pre-load audio (without auto play)
      _player.setUrl(savedUrl);
    }

    // Listen to player streams (as before)
    _player.durationStream.listen((duration) {
      if (duration != null) {
        setState(() {
          _duration = duration;
        });
      }
    });

    _player.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });

    _player.bufferedPositionStream.listen((bufferedPosition) {
      if (mounted) {
        setState(() {
          _buffered = bufferedPosition;
        });
      }
    });

    _player.playerStateStream.listen((playerState) {
      final processingState = playerState.processingState;
      final playing = playerState.playing;

      if (mounted) {
        setState(() {
          isLoading =
              processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering;
          isPlaying = playing;
        });
      }

      if (processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        setState(() {
          isPlaying = false;
          _position = Duration.zero;
          _buffered = Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playSurah(int id, String name) async {
    String convertToThreeDigitString(int id) {
      return id.toString().padLeft(3, '0');
    }

    final url =
        '${_currentReciter.baseUrl}/${convertToThreeDigitString(id)}.mp3';
    await audio.put('url', url);
    try {
      setState(() {
        currentSurahName = name;
        isPlaying = true;
      });
      await audio.put('surah', currentSurahName);
      await _player.setUrl(audio.get('url'));
      await _player.play();
    } catch (e) {
      log("Error playing audio: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("حدث خطأ أثناء تشغيل السورة")));
    }
  }

  Future<void> _togglePlayPause() async {
    try {
      if (_player.playing) {
        await _player.pause();
        setState(() {
          isPlaying = false;
        });
      } else {
        if (_player.audioSource == null) {
          final savedUrl = audio.get('url');
          final savedSurah = audio.get('surah');
          if (savedUrl != null && savedSurah != null) {
            await _player.setUrl(savedUrl);
            setState(() {
              currentSurahName = savedSurah;
              isPlaying = true;
            });
          } else {
            await _playSurah(1, "الفاتحة");
            return;
          }
        }
        await _player.play();
        setState(() {
          isPlaying = true;
        });
      }
    } catch (e) {
      log("TogglePlayPause error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("حدث خطأ أثناء تشغيل السورة")));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          'القرآن الكريم',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: ColorsManger.primary),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: BlocBuilder<SurahCubit, SurahState>(
              builder: (context, state) {
                if (state is SurahLoaded) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (context, index) => Divider(
                      color: ColorsManger.grey,
                      height: 0,
                      thickness: .2,
                    ),
                    itemCount: state.surahList.length,
                    itemBuilder: (context, index) {
                      final surah = state.surahList[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == state.surahList.length - 1 ? 200 : 0,
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: surah.arabic == currentSurahName
                                ? ColorsManger.primary.withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: surah.arabic == currentSurahName
                                ? Border.all(
                                    color: ColorsManger.primary.withOpacity(
                                      0.2,
                                    ),
                                    width: .5,
                                  )
                                : null,
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: surah.arabic == currentSurahName
                                  ? ColorsManger.primary
                                  : ColorsManger.primary.withOpacity(0.1),
                              child: Text(
                                '${surah.id}',
                                style: TextStyle(
                                  color: surah.arabic == currentSurahName
                                      ? Colors.white
                                      : ColorsManger.primary,
                                  fontWeight: FontWeight.normal,
                                  fontSize: surah.arabic == currentSurahName
                                      ? 16
                                      : 14,
                                ),
                              ),
                            ),
                            title: Text(
                              surah.arabic ?? '',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: surah.arabic == currentSurahName
                                        ? ColorsManger.primary
                                        : Colors.black87,
                                    fontWeight: surah.arabic == currentSurahName
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                            ),
                            subtitle: surah.english != null
                                ? Text(
                                    surah.english!,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey[600]),
                                  )
                                : null,
                            trailing: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child:
                                  surah.arabic == currentSurahName && isPlaying
                                  ? Image.asset(
                                      Assets.imagesVoiceAnimation,

                                      key: const ValueKey('voice_animation'),
                                    )
                                  : Icon(
                                      Icons.play_circle_fill,
                                      color: ColorsManger.primary,
                                      size: 35,
                                      key: const ValueKey('play_icon'),
                                    ),
                            ),
                            onTap: () {
                              if (currentSurahName != surah.arabic) {
                                _playSurah(surah.id ?? 1, surah.arabic ?? "");
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Image.asset(Assets.imagesLoadingAnimation);
                }
              },
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: ColorsManger.primary,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'سورة ${currentSurahName ?? audio.get('surah')}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      isLoading
                          ? SizedBox(
                              width: 75,
                              height: 75,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
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
                              onPressed: _togglePlayPause,
                              color: Colors.white,
                            ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: DropdownButton<ReciterModel>(
                            value: _currentReciter,
                            underline: SizedBox.shrink(),
                            dropdownColor: ColorsManger.primary,
                            iconEnabledColor: Colors.white,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                            isExpanded: true,

                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _currentReciter = value;
                                  if (_player.playing) {
                                    _player.stop();
                                    isPlaying = false;
                                    currentSurahName = null;
                                  }
                                });
                              }
                            },
                            items: reciters
                                .map(
                                  (reciter) => DropdownMenuItem<ReciterModel>(
                                    value: reciter,
                                    child: Text(
                                      reciter.nameAr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ProgressBarWidget(
                    position: _position,
                    buffered: _buffered,
                    duration: _duration,
                    player: _player,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
