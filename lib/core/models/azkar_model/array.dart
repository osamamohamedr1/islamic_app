import 'package:hive/hive.dart';
part 'array.g.dart';

@HiveType(typeId: 1)
class Array {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? text;
  @HiveField(2)
  int? count;
  @HiveField(3)
  String? audio;
  @HiveField(4)
  String? filename;
  @HiveField(5)
  bool isFavorite;

  Array({
    this.id,
    this.text,
    this.count,
    this.audio,
    this.filename,
    this.isFavorite = false,
  });

  factory Array.fromJson(Map<String, dynamic> json) => Array(
    id: json['id'] as int?,
    text: json['text'] as String?,
    count: json['count'] as int?,
    audio: json['audio'] as String?,
    filename: json['filename'] as String?,
    isFavorite: false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'count': count,
    'audio': audio,
    'filename': filename,
  };
}
