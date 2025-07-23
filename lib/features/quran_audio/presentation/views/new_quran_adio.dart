// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:islamic_app/features/quran_audio/presentation/manger/cubit/quran_cubit.dart';
// import 'package:islamic_app/core/themes/colors_manger.dart';
// import 'package:islamic_app/core/utils/assets.dart';
// import 'package:islamic_app/features/quran_audio/data/models/reciter_model.dart';
// import 'package:islamic_app/features/quran_audio/presentation/views/widgets/progress_bar_widget.dart';

// class NewQuranAudioView extends StatelessWidget {
//   const NewQuranAudioView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => QuranAudioCubit()..initialize(),
//       child: const QuranAudioScreen(),
//     );
//   }
// }

// class QuranAudioScreen extends StatelessWidget {
//   const QuranAudioScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'القرآن الكريم',
//           style: Theme.of(context).textTheme.titleSmall?.copyWith(
//             color: ColorsManger.primary,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: IconThemeData(color: ColorsManger.primary),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.search, color: ColorsManger.primary),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<QuranAudioCubit, QuranAudioState>(
//               builder: (context, state) {
//                 if (state is QuranAudioLoading) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(Assets.imagesLoadingAnimation),
//                         const SizedBox(height: 16),
//                         Text(
//                           'جاري تحميل السور...',
//                           style: Theme.of(context).textTheme.bodyMedium
//                               ?.copyWith(color: ColorsManger.primary),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 if (state is QuranAudioError) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.error_outline, size: 64, color: Colors.red),
//                         const SizedBox(height: 16),
//                         Text(
//                           state.message,
//                           style: Theme.of(
//                             context,
//                           ).textTheme.bodyMedium?.copyWith(color: Colors.red),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 16),
//                         ElevatedButton(
//                           onPressed: () {
//                             context.read<QuranAudioCubit>().initialize();
//                           },
//                           child: const Text('إعادة المحاولة'),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 if (state is SurahListLoaded) {
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       await context.read<QuranAudioCubit>().initialize();
//                     },
//                     child: ListView.separated(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       itemCount: state.surahList.length,
//                       separatorBuilder: (context, index) =>
//                           const Divider(height: 0, thickness: 0.1),
//                       itemBuilder: (context, index) {
//                         final surah = state.surahList[index];
//                         final isCurrentSurah =
//                             surah.arabic == state.currentSurahName;

//                         return Container(
//                           margin: const EdgeInsets.symmetric(vertical: 4),
//                           decoration: BoxDecoration(
//                             color: isCurrentSurah
//                                 ? ColorsManger.primary.withOpacity(0.1)
//                                 : Colors.transparent,
//                             borderRadius: BorderRadius.circular(12),
//                             border: isCurrentSurah
//                                 ? Border.all(
//                                     color: ColorsManger.primary.withOpacity(
//                                       0.2,
//                                     ),
//                                     width: 1,
//                                   )
//                                 : null,
//                           ),
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                             ),
//                             leading: CircleAvatar(
//                               backgroundColor: isCurrentSurah
//                                   ? ColorsManger.primary
//                                   : ColorsManger.primary.withOpacity(0.1),
//                               child: Text(
//                                 '${surah.id}',
//                                 style: TextStyle(
//                                   color: isCurrentSurah
//                                       ? Colors.white
//                                       : ColorsManger.primary,
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: isCurrentSurah ? 16 : 14,
//                                 ),
//                               ),
//                             ),
//                             title: Text(
//                               surah.arabic ?? '',
//                               style: Theme.of(context).textTheme.bodyMedium
//                                   ?.copyWith(
//                                     color: isCurrentSurah
//                                         ? ColorsManger.primary
//                                         : Colors.black87,
//                                     fontWeight: isCurrentSurah
//                                         ? FontWeight.bold
//                                         : FontWeight.normal,
//                                   ),
//                             ),
//                             subtitle: surah.english != null
//                                 ? Text(
//                                     surah.english!,
//                                     style: Theme.of(context).textTheme.bodySmall
//                                         ?.copyWith(color: Colors.grey[600]),
//                                   )
//                                 : null,
//                             trailing: AnimatedSwitcher(
//                               duration: const Duration(milliseconds: 300),
//                               child: isCurrentSurah && state.isPlaying
//                                   ? Image.asset(
//                                       Assets.imagesVoiceAnimation,
//                                       width: 35,
//                                       height: 35,
//                                       color: ColorsManger.primary,
//                                       key: const ValueKey('voice_animation'),
//                                     )
//                                   : Icon(
//                                       Icons.play_circle_fill,
//                                       color: ColorsManger.primary,
//                                       size: 35,
//                                       key: const ValueKey('play_icon'),
//                                     ),
//                             ),
//                             onTap: () {
//                               context.read<QuranAudioCubit>().playSurah(
//                                 surah.id ?? 1,
//                                 surah.arabic ?? '',
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }

//                 return const Center(child: Text('لا توجد بيانات متاحة'));
//               },
//             ),
//           ),

//           const AudioPlayerBar(),
//         ],
//       ),
//     );
//   }
// }

// class AudioPlayerBar extends StatelessWidget {
//   const AudioPlayerBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<QuranAudioCubit, QuranAudioState>(
//       builder: (context, state) {
//         if (state is! SurahListLoaded || state.currentSurahName == null) {
//           return const SizedBox.shrink();
//         }

//         final cubit = context.read<QuranAudioCubit>();

//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: ColorsManger.offWhite,
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'سورة ${state.currentSurahName ?? ''}',
//                           style: Theme.of(context).textTheme.bodyMedium
//                               ?.copyWith(
//                                 color: ColorsManger.primary,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                           overflow: TextOverflow.ellipsis,
//                         ),

//                         Text(
//                           state.currentReciter.nameAr,
//                           style: Theme.of(context).textTheme.bodySmall
//                               ?.copyWith(color: Colors.grey[600]),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Play/Pause button
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 16),
//                     child: state.isLoading
//                         ? Container(
//                             width: 56,
//                             height: 56,
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: ColorsManger.primary.withOpacity(0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const CircularProgressIndicator(
//                               color: ColorsManger.primary,
//                               strokeWidth: 3,
//                             ),
//                           )
//                         : IconButton(
//                             icon: Container(
//                               width: 56,
//                               height: 56,
//                               decoration: BoxDecoration(
//                                 color: ColorsManger.primary,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: ColorsManger.primary.withOpacity(
//                                       0.3,
//                                     ),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Icon(
//                                 state.isPlaying
//                                     ? Icons.pause
//                                     : Icons.play_arrow,
//                                 size: 32,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             onPressed: cubit.togglePlayPause,
//                           ),
//                   ),

//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: ColorsManger.primary.withOpacity(0.3),
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: DropdownButton<ReciterModel>(
//                         isExpanded: true,
//                         value: state.currentReciter,
//                         dropdownColor: Colors.white,
//                         iconEnabledColor: ColorsManger.primary,
//                         underline: const SizedBox.shrink(),
//                         onChanged: cubit.changeReciter,
//                         items: reciters.map((reciter) {
//                           return DropdownMenuItem(
//                             value: reciter,
//                             child: Text(
//                               reciter.nameAr,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: Theme.of(context).textTheme.bodyMedium
//                                   ?.copyWith(color: ColorsManger.primary),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               ProgressBarWidget(
//                 position: state.position,
//                 buffered: state.buffered,
//                 duration: state.duration,
//                 player: cubit.player,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
