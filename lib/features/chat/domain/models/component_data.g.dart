// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrayerTimesDataImpl _$$PrayerTimesDataImplFromJson(
  Map<String, dynamic> json,
) => _$PrayerTimesDataImpl(
  prayers: (json['prayers'] as List<dynamic>)
      .map((e) => PrayerTimeEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
  date: json['date'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$PrayerTimesDataImplToJson(
  _$PrayerTimesDataImpl instance,
) => <String, dynamic>{
  'prayers': instance.prayers,
  'date': instance.date,
  'runtimeType': instance.$type,
};

_$QuranAyahDataImpl _$$QuranAyahDataImplFromJson(Map<String, dynamic> json) =>
    _$QuranAyahDataImpl(
      ayahs: (json['ayahs'] as List<dynamic>)
          .map((e) => AyahEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuranAyahDataImplToJson(_$QuranAyahDataImpl instance) =>
    <String, dynamic>{'ayahs': instance.ayahs, 'runtimeType': instance.$type};

_$DuaDataImpl _$$DuaDataImplFromJson(Map<String, dynamic> json) =>
    _$DuaDataImpl(
      arabic: json['arabic'] as String,
      transliteration: json['transliteration'] as String,
      translation: json['translation'] as String,
      source: json['source'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DuaDataImplToJson(_$DuaDataImpl instance) =>
    <String, dynamic>{
      'arabic': instance.arabic,
      'transliteration': instance.transliteration,
      'translation': instance.translation,
      'source': instance.source,
      'runtimeType': instance.$type,
    };

_$TasbihDataImpl _$$TasbihDataImplFromJson(Map<String, dynamic> json) =>
    _$TasbihDataImpl(
      dhikrText: json['dhikrText'] as String,
      targetCount: (json['targetCount'] as num?)?.toInt() ?? 33,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TasbihDataImplToJson(_$TasbihDataImpl instance) =>
    <String, dynamic>{
      'dhikrText': instance.dhikrText,
      'targetCount': instance.targetCount,
      'runtimeType': instance.$type,
    };

_$QiblaDataImpl _$$QiblaDataImplFromJson(Map<String, dynamic> json) =>
    _$QiblaDataImpl($type: json['runtimeType'] as String?);

Map<String, dynamic> _$$QiblaDataImplToJson(_$QiblaDataImpl instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_$PrayerTimeEntryImpl _$$PrayerTimeEntryImplFromJson(
  Map<String, dynamic> json,
) => _$PrayerTimeEntryImpl(
  name: json['name'] as String,
  time: json['time'] as String,
  isNext: json['isNext'] as bool? ?? false,
);

Map<String, dynamic> _$$PrayerTimeEntryImplToJson(
  _$PrayerTimeEntryImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'time': instance.time,
  'isNext': instance.isNext,
};

_$AyahEntryImpl _$$AyahEntryImplFromJson(Map<String, dynamic> json) =>
    _$AyahEntryImpl(
      surah: (json['surah'] as num).toInt(),
      ayah: (json['ayah'] as num).toInt(),
      arabic: json['arabic'] as String,
      translation: json['translation'] as String,
    );

Map<String, dynamic> _$$AyahEntryImplToJson(_$AyahEntryImpl instance) =>
    <String, dynamic>{
      'surah': instance.surah,
      'ayah': instance.ayah,
      'arabic': instance.arabic,
      'translation': instance.translation,
    };
