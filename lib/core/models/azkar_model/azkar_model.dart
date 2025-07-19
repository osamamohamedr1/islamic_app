import 'package:hive/hive.dart';

import 'array.dart';
part 'azkar_model.g.dart';

@HiveType(typeId: 0)
class AzkarModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? category;
  @HiveField(2)
  String? audio;
  @HiveField(3)
  String? filename;
  @HiveField(4)
  List<Array>? array;

  AzkarModel({this.id, this.category, this.audio, this.filename, this.array});

  factory AzkarModel.fromJson(Map<String, dynamic> json) => AzkarModel(
    id: json['id'] as int?,
    category: json['category'] as String?,
    audio: json['audio'] as String?,
    filename: json['filename'] as String?,
    array: (json['array'] as List<dynamic>?)
        ?.map((e) => Array.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'audio': audio,
    'filename': filename,
    'array': array?.map((e) => e.toJson()).toList(),
  };
}
