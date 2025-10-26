class ReciterModel {
  final String nameAr;
  final String nameEn;
  final String baseUrl;

  ReciterModel({
    required this.nameAr,
    required this.nameEn,
    required this.baseUrl,
  });
}

List<ReciterModel> reciters = [
  ReciterModel(
    nameAr: "مشاري راشد العفاسي",
    nameEn: "Mishary Rashid Al Afasy",
    baseUrl: "https://server8.mp3quran.net/afs/",
  ),
  ReciterModel(
    nameAr: "أبو بكر الشاطري",
    nameEn: "Abu Bakr Al Shatri",
    baseUrl: "https://server11.mp3quran.net/shatri/",
  ),
  ReciterModel(
    nameAr: "ناصر القطامي",
    nameEn: "Nasser Al Qatami",
    baseUrl: "https://server6.mp3quran.net/qtm/",
  ),
  ReciterModel(
    nameAr: "ياسر الدوسري",
    nameEn: "Yasser Al Dosari",
    baseUrl: "https://server11.mp3quran.net/yasser/",
  ),
  ReciterModel(
    nameAr: "هاني الرفاعي",
    nameEn: "Hani Ar Rifai",
    baseUrl: "https://server8.mp3quran.net/hani/",
  ),
];
