class UserLocationModel {
  final String city;
  final String arabicName;
  final double latitude;
  final double longitude;
  final String governorate;
  final int population;

  const UserLocationModel({
    required this.city,
    required this.arabicName,
    required this.latitude,
    required this.longitude,
    required this.governorate,
    required this.population,
  });

  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    return UserLocationModel(
      city: json['city'],
      arabicName: json['arabic_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      governorate: json['governorate'],
      population: json['population'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'arabic_name': arabicName,
      'latitude': latitude,
      'longitude': longitude,
      'governorate': governorate,
      'population': population,
    };
  }

  void then(Null Function(dynamic saved) param0) {}
}
