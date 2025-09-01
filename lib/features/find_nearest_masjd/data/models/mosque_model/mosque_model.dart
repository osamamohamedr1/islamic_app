import 'place.dart';

class MosqueModel {
  List<Place>? places;

  MosqueModel({this.places});

  factory MosqueModel.fromJson(Map<String, dynamic> json) => MosqueModel(
    places: (json['places'] as List<dynamic>?)
        ?.map((e) => Place.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'places': places?.map((e) => e.toJson()).toList(),
  };
}
