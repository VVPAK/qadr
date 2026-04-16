// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SurahImpl _$$SurahImplFromJson(Map<String, dynamic> json) => _$SurahImpl(
  number: (json['number'] as num).toInt(),
  nameArabic: json['nameArabic'] as String,
  nameEnglish: json['nameEnglish'] as String,
  nameRussian: json['nameRussian'] as String,
  revelationType: json['revelationType'] as String,
  ayahCount: (json['ayahCount'] as num).toInt(),
);

Map<String, dynamic> _$$SurahImplToJson(_$SurahImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'nameArabic': instance.nameArabic,
      'nameEnglish': instance.nameEnglish,
      'nameRussian': instance.nameRussian,
      'revelationType': instance.revelationType,
      'ayahCount': instance.ayahCount,
    };

_$AyahImpl _$$AyahImplFromJson(Map<String, dynamic> json) => _$AyahImpl(
  surahNumber: (json['surahNumber'] as num).toInt(),
  ayahNumber: (json['ayahNumber'] as num).toInt(),
  textArabic: json['textArabic'] as String,
  textEnglish: json['textEnglish'] as String,
  textRussian: json['textRussian'] as String,
);

Map<String, dynamic> _$$AyahImplToJson(_$AyahImpl instance) =>
    <String, dynamic>{
      'surahNumber': instance.surahNumber,
      'ayahNumber': instance.ayahNumber,
      'textArabic': instance.textArabic,
      'textEnglish': instance.textEnglish,
      'textRussian': instance.textRussian,
    };

_$QuranSearchResultImpl _$$QuranSearchResultImplFromJson(
  Map<String, dynamic> json,
) => _$QuranSearchResultImpl(
  ayah: Ayah.fromJson(json['ayah'] as Map<String, dynamic>),
  surahName: json['surahName'] as String,
  relevance: (json['relevance'] as num).toDouble(),
);

Map<String, dynamic> _$$QuranSearchResultImplToJson(
  _$QuranSearchResultImpl instance,
) => <String, dynamic>{
  'ayah': instance.ayah,
  'surahName': instance.surahName,
  'relevance': instance.relevance,
};
