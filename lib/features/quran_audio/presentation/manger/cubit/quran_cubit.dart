// import 'package:bloc/bloc.dart';
// import 'package:islamic_app/features/quran_audio/data/repos/quran_audio_repo.dart';
// import 'package:meta/meta.dart';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:islamic_app/features/quran_audio/data/models/reciter_model.dart';
// import 'package:islamic_app/features/quran_audio/data/models/surah_model.dart';
// import 'dart:async';

// part 'quran_state.dart';

// class QuranAudioCubit extends Cubit<QuranAudioState> {
//   final AudioPlayer player = AudioPlayer();
//   late final QuranAudioRepo _repo;

//   // Stream subscriptions for cleanup
//   StreamSubscription? _durationSubscription;
//   StreamSubscription? _positionSubscription;
//   StreamSubscription? _bufferedSubscription;
//   StreamSubscription? _playerStateSubscription;

//   QuranAudioCubit() : super(QuranAudioInitial()) {
//     _repo = QuranAudioRepo(player);
//   }

//   Future<void> initialize() async {
//     try {
//       emit(QuranAudioLoading());

//       // 1. Load surah list first (fast operation)
//       final surahList = await _repo.getSuraList();

//       if (surahList.isEmpty) {
//         emit(QuranAudioError('لا توجد سور متاحة'));
//         return;
//       }

//       // 2. Emit initial loaded state
//       emit(
//         SurahListLoaded(
//           surahList: surahList,
//           currentSurahName: null,
//           currentReciter: reciters.isNotEmpty ? reciters[0] : null,
//           isPlaying: false,
//           isLoading: false,
//           position: Duration.zero,
//           buffered: Duration.zero,
//           duration: null,
//         ),
//       );

//       // 3. Initialize player state in background
//       await _initializePlayerState();
//     } catch (e) {
//       log('Error in initialize: $e');
//       emit(QuranAudioError('تعذر تحميل البيانات: ${e.toString()}'));
//     }
//   }

//   Future<void> _initializePlayerState() async {
//     try {
//       if (state is! SurahListLoaded) return;
//       final currentState = state as SurahListLoaded;

//       // Initialize player state through repo
//       final playerStateData = await _repo.initializePlayerState();

//       // Start listening to player streams
//       _setupPlayerListeners();

//       // Update state with restored data
//       emit(
//         currentState.copyWith(
//           currentSurahName: playerStateData['currentSurahName'],
//           currentReciter: playerStateData['currentReciter'],
//           isPlaying: playerStateData['isPlaying'] ?? false,
//         ),
//       );
//     } catch (e) {
//       log('Error initializing player state: $e');
//       // Don't emit error here since we already have the surah list
//       // Just setup listeners for future operations
//       _setupPlayerListeners();
//     }
//   }

//   void _setupPlayerListeners() {
//     // Cancel existing subscriptions
//     _cancelSubscriptions();

//     // Duration stream
//     _durationSubscription = _repo.durationStream.listen(
//       (duration) {
//         if (state is SurahListLoaded) {
//           emit((state as SurahListLoaded).copyWith(duration: duration));
//         }
//       },
//       onError: (error) {
//         log('Duration stream error: $error');
//       },
//     );

//     // Position stream
//     _positionSubscription = _repo.positionStream.listen(
//       (position) {
//         if (state is SurahListLoaded) {
//           emit((state as SurahListLoaded).copyWith(position: position));
//         }
//       },
//       onError: (error) {
//         log('Position stream error: $error');
//       },
//     );

//     // Buffered position stream
//     _bufferedSubscription = _repo.bufferedPositionStream.listen(
//       (buffered) {
//         if (state is SurahListLoaded) {
//           emit((state as SurahListLoaded).copyWith(buffered: buffered));
//         }
//       },
//       onError: (error) {
//         log('Buffered stream error: $error');
//       },
//     );

//     // Player state stream
//     _playerStateSubscription = _repo.playerStateStream.listen(
//       (playerState) {
//         _handlePlayerStateChange(playerState);
//       },
//       onError: (error) {
//         log('Player state stream error: $error');
//         if (state is SurahListLoaded) {
//           emit(
//             (state as SurahListLoaded).copyWith(
//               isLoading: false,
//               isPlaying: false,
//             ),
//           );
//         }
//       },
//     );
//   }

//   void _handlePlayerStateChange(PlayerState playerState) {
//     final processingState = playerState.processingState;
//     final playing = playerState.playing;

//     if (state is! SurahListLoaded) return;
//     final currentState = state as SurahListLoaded;

//     // Determine loading state
//     final isLoading =
//         processingState == ProcessingState.loading ||
//         processingState == ProcessingState.buffering;

//     // Handle different processing states
//     switch (processingState) {
//       case ProcessingState.idle:
//         emit(currentState.copyWith(isPlaying: false, isLoading: false));
//         break;

//       case ProcessingState.loading:
//       case ProcessingState.buffering:
//         emit(currentState.copyWith(isLoading: true, isPlaying: playing));
//         break;

//       case ProcessingState.ready:
//         emit(currentState.copyWith(isPlaying: playing, isLoading: false));
//         break;

//       case ProcessingState.completed:
//         _handlePlaybackCompleted();
//         break;
//     }
//   }

//   Future<void> _handlePlaybackCompleted() async {
//     try {
//       await _repo.seekToPosition(Duration.zero);
//       if (state is SurahListLoaded) {
//         emit(
//           (state as SurahListLoaded).copyWith(
//             isPlaying: false,
//             position: Duration.zero,
//             buffered: Duration.zero,
//           ),
//         );
//       }
//     } catch (e) {
//       log('Error handling playback completion: $e');
//     }
//   }

//   Future<void> playSurah(int id, String name) async {
//     if (state is! SurahListLoaded) return;
//     final currentState = state as SurahListLoaded;

//     try {
//       // Show loading immediately
//       emit(
//         currentState.copyWith(
//           currentSurahName: name,
//           isLoading: true,
//           isPlaying: false,
//         ),
//       );

//       await _repo.playSurah(
//         id,
//         name,
//         currentState.currentReciter ?? reciters[0],
//       );

//       // State will be updated through player state stream
//     } catch (e) {
//       log("Error playing surah: $e");

//       // Reset loading state on error
//       emit(currentState.copyWith(isLoading: false, isPlaying: false));

//       // You might want to show a snackbar or error message here
//       _showError('تعذر تشغيل السورة');
//     }
//   }

//   Future<void> togglePlayPause() async {
//     if (state is! SurahListLoaded) return;
//     final currentState = state as SurahListLoaded;

//     try {
//       // Show loading state for better UX
//       emit(currentState.copyWith(isLoading: true));

//       final result = await _repo.togglePlayPause();

//       if (result['playDefaultSurah'] == true) {
//         await playSurah(1, 'الفاتحة');
//         return;
//       }

//       if (result['needsPlay'] == true) {
//         await player.play();
//         emit(
//           currentState.copyWith(
//             currentSurahName: result['currentSurahName'],
//             isPlaying: true,
//             isLoading: false,
//           ),
//         );
//         return;
//       }

//       emit(
//         currentState.copyWith(
//           isPlaying: result['isPlaying'] ?? false,
//           isLoading: false,
//         ),
//       );
//     } catch (e) {
//       log("Error toggle play/pause: $e");
//       emit(currentState.copyWith(isLoading: false, isPlaying: false));
//       _showError('تعذر التحكم في التشغيل');
//     }
//   }

//   Future<void> changeReciter(ReciterModel? newReciter) async {
//     if (newReciter == null || state is! SurahListLoaded) return;
//     final currentState = state as SurahListLoaded;

//     try {
//       await _repo.stopPlayer();

//       emit(
//         currentState.copyWith(
//           currentReciter: newReciter,
//           isPlaying: false,
//           isLoading: false,
//           currentSurahName: null,
//           position: Duration.zero,
//           buffered: Duration.zero,
//           duration: null,
//         ),
//       );
//     } catch (e) {
//       log("Error changing reciter: $e");
//       _showError('تعذر تغيير القارئ');
//     }
//   }

//   Future<void> seekToPosition(Duration position) async {
//     if (state is! SurahListLoaded) return;

//     try {
//       await _repo.seekToPosition(position);
//     } catch (e) {
//       log("Error seeking to position: $e");
//       _showError('تعذر تغيير موضع التشغيل');
//     }
//   }

//   Future<void> retry() async {
//     await initialize();
//   }

//   void _showError(String message) {
//     // This could emit a temporary error state or use a different mechanism
//     // to show errors (like through a stream that the UI listens to)
//     log('Error to show to user: $message');
//   }

//   void _cancelSubscriptions() {
//     _durationSubscription?.cancel();
//     _positionSubscription?.cancel();
//     _bufferedSubscription?.cancel();
//     _playerStateSubscription?.cancel();
//   }

//   @override
//   Future<void> close() {
//     _cancelSubscriptions();
//     player.dispose();
//     return super.close();
//   }
// }
