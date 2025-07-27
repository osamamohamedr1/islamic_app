import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/features/quran_audio/data/models/reciter_model.dart';
import 'package:islamic_app/features/quran_audio/presentation/views/widgets/audio_player_controlers.dart';
import 'package:islamic_app/features/quran_audio/presentation/views/widgets/surah_list_widget.dart';

class NewQuranAudioView extends StatefulWidget {
  const NewQuranAudioView({super.key});

  @override
  State<NewQuranAudioView> createState() => _NewQuranAudioViewState();
}

class _NewQuranAudioViewState extends State<NewQuranAudioView>
    with AutomaticKeepAliveClientMixin {
  final AudioPlayer _player = AudioPlayer();
  ReciterModel _currentReciter = reciters[0];
  String? currentSurahName;
  bool isPlaying = false;
  bool isLoading = false;

  Duration _position = Duration.zero;
  Duration _buffered = Duration.zero;
  Duration? _duration;

  final audio = Hive.box(audioBox);

  @override
  void initState() {
    super.initState();

    final savedSurah = audio.get('surah');
    final savedUrl = audio.get('url');
    final savedReciterName = audio.get('reciterName');
    final savedReciterBaseUrl = audio.get('reciterBaseUrl');

    if (savedSurah != null &&
        savedUrl != null &&
        savedReciterName != null &&
        savedReciterBaseUrl != null) {
      setState(() {
        currentSurahName = savedSurah;
        _currentReciter = reciters.firstWhere(
          (r) =>
              r.nameAr == savedReciterName && r.baseUrl == savedReciterBaseUrl,
          orElse: () => reciters[0],
        );
      });
      _player.setUrl(savedUrl);
    }

    _player.durationStream.listen((d) {
      if (d != null && mounted) setState(() => _duration = d);
    });

    _player.positionStream.listen((p) {
      if (mounted) setState(() => _position = p);
    });

    _player.bufferedPositionStream.listen((b) {
      if (mounted) setState(() => _buffered = b);
    });

    _player.playerStateStream.listen((s) {
      if (!mounted) return;
      setState(() {
        isLoading =
            s.processingState == ProcessingState.loading ||
            s.processingState == ProcessingState.buffering;
        isPlaying = s.playing;
      });

      if (s.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        setState(() {
          isPlaying = false;
          _position = Duration.zero;
          _buffered = Duration.zero;
        });
      }
    });
  }

  Future<void> _playSurah(int id, String name) async {
    final paddedId = id.toString().padLeft(3, '0');
    final url = '${_currentReciter.baseUrl}/$paddedId.mp3';

    await audio.put('surah', name);
    await audio.put('url', url);
    await audio.put('reciterName', _currentReciter.nameAr);
    await audio.put('reciterBaseUrl', _currentReciter.baseUrl);

    try {
      setState(() {
        currentSurahName = name;
        isPlaying = true;
      });

      await _player.setUrl(url);
      await _player.play();
    } on PlayerException catch (e) {
      log("PlayerException: ${e.message}");
      _showErrorSnack("حدث خطأ أثناء تحميل الملف الصوتي");
    } on PlayerInterruptedException catch (e) {
      log("PlayerInterruptedException: ${e.message}");
      _showErrorSnack("تم مقاطعة تشغيل الصوت");
    } catch (e) {
      log("Unknown error: $e");
      _showErrorSnack("تأكد من اتصال الإنترنت أو أعد المحاولة لاحقًا");
    }
  }

  Future<void> _togglePlayPause() async {
    try {
      if (_player.playing) {
        await _player.pause();
        setState(() => isPlaying = false);
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
        setState(() => isPlaying = true);
      }
    } on PlayerException catch (e) {
      log("PlayerException: ${e.message}");
      _showErrorSnack("لا يمكن تشغيل السورة");
    } on PlayerInterruptedException catch (e) {
      log("Interrupted: ${e.message}");
      _showErrorSnack("تم إيقاف التشغيل مؤقتًا");
    } catch (e) {
      log("Unknown toggle error: $e");
      _showErrorSnack("حدث خطأ أثناء تشغيل السورة");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
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
            child: SurahListWidget(
              currentSurahName: currentSurahName,
              onSurahTap: _playSurah,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AudioPlayerControls(
              currentSurahName: currentSurahName,
              currentReciter: _currentReciter,
              isLoading: isLoading,
              isPlaying: isPlaying,
              onTogglePlayPause: _togglePlayPause,
              onReciterChange: (reciter) {
                setState(() {
                  _currentReciter = reciter;
                  if (_player.playing) {
                    _player.stop();
                    isPlaying = false;
                    currentSurahName = null;
                  }
                });
              },
              position: _position,
              buffered: _buffered,
              duration: _duration,
              player: _player,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _showErrorSnack(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
