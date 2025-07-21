import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class QuranAudioView extends StatefulWidget {
  const QuranAudioView({super.key});

  @override
  State<QuranAudioView> createState() => _QuranAudioViewState();
}

class _QuranAudioViewState extends State<QuranAudioView> {
  final AudioPlayer _player = AudioPlayer();
  String? currentSurahName;
  String? currentSurahUrl;
  bool isPlaying = false;

  final List<Map<String, String>> surahs = [
    {
      'name': 'سورة الفاتحة',
      'url': 'https://server11.mp3quran.net/yasser/001.mp3',
    },
    {
      'name': 'سورة البقرة',
      'url': 'https://server11.mp3quran.net/yasser/002.mp3',
    },
    {
      'name': 'سورة آل عمران',
      'url': 'https://server11.mp3quran.net/yasser/003.mp3',
    },
    // Add more if needed
  ];

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playSurah(String name, String url) async {
    try {
      await _player.setUrl(url);
      await _player.play();
      setState(() {
        currentSurahName = name;
        currentSurahUrl = url;
        isPlaying = true;
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> _togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }

    setState(() {
      isPlaying = _player.playing;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: surahs.length,
              itemBuilder: (context, index) {
                final surah = surahs[index];
                return ListTile(
                  title: Text(surah['name']!),
                  onTap: () => _playSurah(surah['name']!, surah['url']!),
                );
              },
            ),
          ),

          if (currentSurahName != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Theme.of(context).cardColor,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      currentSurahName!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      size: 36,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
