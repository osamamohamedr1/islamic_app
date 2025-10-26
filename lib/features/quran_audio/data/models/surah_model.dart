class SurahModel {
  int? id;
  String? name;
  int? aya;
  String? english;
  String? turkish;
  String? place;
  String? arabic;

  SurahModel({
    this.id,
    this.name,
    this.aya,
    this.english,
    this.turkish,
    this.place,
    this.arabic,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    aya: json['aya'] as int?,
    english: json['english'] as String?,
    turkish: json['turkish'] as String?,
    place: json['place'] as String?,
    arabic: json['arabic'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'aya': aya,
    'english': english,
    'turkish': turkish,
    'place': place,
    'arabic': arabic,
  };
}
