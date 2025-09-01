import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/utils/assets.dart';
import 'package:islamic_app/features/quran_audio/data/models/surah_model.dart';
import 'package:islamic_app/features/quran_audio/presentation/manger/surah_cubit/surah_cubit.dart';
import 'package:islamic_app/features/quran_audio/presentation/views/widgets/surah_tile.dart';
import 'package:just_audio/just_audio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islamic_app/core/themes/colors_manger.dart';
import 'package:islamic_app/core/utils/consts.dart';
import 'package:islamic_app/features/quran_audio/data/models/reciter_model.dart';
import 'package:islamic_app/features/quran_audio/presentation/views/widgets/audio_player_controlers.dart';
import 'package:just_audio_background/just_audio_background.dart';

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
  List<SurahModel> allSurahList = [];
  List<SurahModel> searchedForSurah = [];
  bool isSearching = false;
  final TextEditingController textEditingController = TextEditingController();

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

      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: name,

            album: " قرأن",
            title: name,
            artUri: Uri.parse('https://example.com/albumart.jpg'),
          ),
        ),
      );
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
            await _player.setAudioSource(
              AudioSource.uri(
                Uri.parse(savedUrl),
                tag: MediaItem(
                  id: savedSurah,

                  album: " قرأن",
                  title: savedSurah,
                  artUri: Uri.parse('https://example.com/albumart.jpg'),
                ),
              ),
            );
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: .6,
        elevation: .6,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        leading: isSearching ? BackButton() : null,
        title: isSearching
            ? buildTextField()
            : Text(
                'القرآن الكريم',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
        actions: buildAppBarActions(),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: BlocBuilder<SurahCubit, SurahState>(
              builder: (context, state) {
                if (state is SurahLoaded) {
                  allSurahList = state.surahList;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: textEditingController.text.isEmpty
                        ? allSurahList.length
                        : searchedForSurah.length,
                    separatorBuilder: (_, __) => Divider(
                      color: ColorsManger.grey,
                      height: 0,
                      thickness: .2,
                    ),
                    itemBuilder: (context, index) {
                      final surah = textEditingController.text.isEmpty
                          ? allSurahList
                          : searchedForSurah;

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == state.surahList.length - 1 ? 200 : 0,
                        ),
                        child: SurahTile(
                          surah: surah[index],
                          isSelected: surah[index].arabic == currentSurahName,
                          onTap: () => _playSurah(
                            surah[index].id ?? 1,
                            surah[index].arabic ?? '',
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

  Widget buildTextField() {
    return TextField(
      controller: textEditingController,

      decoration: InputDecoration(
        hintText: 'اسم السورة',
        border: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.bodySmall,
      ),
      onChanged: (searchedChar) {
        addSearchedSurahForSearchedList(searchedChar);
      },
    );
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            textEditingController.clear();
            searchedForSurah.clear();
            setState(() {
              isSearching = false;
            });
          },
          icon: Icon(Icons.clear),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            ModalRoute.of(context)?.addLocalHistoryEntry(
              LocalHistoryEntry(
                onRemove: () {
                  //stop search
                  textEditingController.clear();
                  searchedForSurah.clear();
                  setState(() {
                    isSearching = false;
                  });
                },
              ),
            );
            setState(() {
              isSearching = true;
            });
          },
          icon: Icon(Icons.search),
        ),
      ];
    }
  }

  void addSearchedSurahForSearchedList(String searchedChar) {
    searchedForSurah = allSurahList
        .where((char) => char.arabic!.contains(searchedChar))
        .toList();

    setState(() {});
  }
}
