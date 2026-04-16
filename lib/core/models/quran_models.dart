import 'package:freezed_annotation/freezed_annotation.dart';

part 'quran_models.freezed.dart';
part 'quran_models.g.dart';

@freezed
class Surah with _$Surah {
  const factory Surah({
    required int number,
    required String nameArabic,
    required String nameEnglish,
    required String nameRussian,
    required String revelationType,
    required int ayahCount,
  }) = _Surah;

  factory Surah.fromJson(Map<String, dynamic> json) => _$SurahFromJson(json);
}

@freezed
class Ayah with _$Ayah {
  const factory Ayah({
    required int surahNumber,
    required int ayahNumber,
    required String textArabic,
    required String textEnglish,
    required String textRussian,
  }) = _Ayah;

  factory Ayah.fromJson(Map<String, dynamic> json) => _$AyahFromJson(json);
}

@freezed
class QuranSearchResult with _$QuranSearchResult {
  const factory QuranSearchResult({
    required Ayah ayah,
    required String surahName,
    required double relevance,
  }) = _QuranSearchResult;

  factory QuranSearchResult.fromJson(Map<String, dynamic> json) =>
      _$QuranSearchResultFromJson(json);
}
