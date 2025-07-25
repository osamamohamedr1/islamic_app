import 'display_name.dart';
import 'location.dart';

class Place {
  Location? location;
  num? rating;
  DisplayName? displayName;

  Place({this.location, this.rating, this.displayName});

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    rating: json['rating'] as num?,
    displayName: json['displayName'] == null
        ? null
        : DisplayName.fromJson(json['displayName'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'location': location?.toJson(),
    'rating': rating,
    'displayName': displayName?.toJson(),
  };
}
