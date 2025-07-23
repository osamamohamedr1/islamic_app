// import 'package:hive/hive.dart';
// import 'package:islamic_app/core/utils/consts.dart';

// class AudioSessionService {
//   static final _box = Hive.box(audioBox);

//   static Future<void> save({
//     required int surahId,
//     required String surahName,
//     required String reciterId,
//   }) async {
//     await _box.putAll({
//       'surahId': surahId,
//       'surahName': surahName,
//       'reciterId': reciterId,
//     });
//   }

//   static Map<String, dynamic>? load() {
//     final surahId = _box.get('surahId');
//     final surahName = _box.get('surahName');
//     final reciterId = _box.get('reciterId');

//     if (surahId != null && surahName != null && reciterId != null) {
//       return {
//         'surahId': surahId,
//         'surahName': surahName,
//         'reciterId': reciterId,
//       };
//     }
//     return null;
//   }

//   static Future<void> clear() async => await _box.clear();
// }
